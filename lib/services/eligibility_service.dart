import '../models/landing_models.dart';
import 'dummy_data.dart';

class EligibilityResult {
  final double score; // 0 to 100
  final String status; // 'High', 'Moderate', 'Requires Attention'
  final String message;
  final double estimatedEmi; // monthly payment
  final double interestRate; // recommended rate
  final List<LoanOfferModel> matchedLenders;

  EligibilityResult({
    required this.score,
    required this.status,
    required this.message,
    required this.estimatedEmi,
    required this.interestRate,
    required this.matchedLenders,
  });
}

class EligibilityService {
  static Future<EligibilityResult> checkEligibility({
    required String country,
    required String university,
    required String course,
    required double loanAmountUSD,
  }) async {
    // Simulate network delay for premium feel loading spinner
    await Future.delayed(const Duration(milliseconds: 1800));

    double baseScore = 65.0;

    // Adjust score based on country choice
    if (country.toLowerCase().contains("usa") || country.toLowerCase().contains("united states")) {
      baseScore += 15;
    } else if (country.toLowerCase().contains("canada") || country.toLowerCase().contains("uk")) {
      baseScore += 10;
    } else {
      baseScore += 5;
    }

    // Adjust score based on university tier (simulated)
    if (university.length > 5 && (university.toLowerCase().contains("university") || university.toLowerCase().contains("institute"))) {
      baseScore += 12;
    } else {
      baseScore += 5;
    }

    // Adjust score based on course STEM fields
    final String courseLower = course.toLowerCase();
    if (courseLower.contains("computer") ||
        courseLower.contains("data") ||
        courseLower.contains("science") ||
        courseLower.contains("engineering") ||
        courseLower.contains("stem") ||
        courseLower.contains("mba")) {
      baseScore += 13;
    } else {
      baseScore += 5;
    }

    // Cap at 98% (realistic)
    if (baseScore > 98) baseScore = 98;
    if (baseScore < 30) baseScore = 30;

    String status = "Requires Co-applicant";
    String message = "Your profile shows potential. Adding a strong financial co-applicant will guarantee approval.";
    if (baseScore >= 80) {
      status = "Excellent Eligibility";
      message = "Fantastic profile! You qualify for premium collateral-free loans from our top banking partners.";
    } else if (baseScore >= 60) {
      status = "Good Eligibility";
      message = "Great! You are eligible for competitive rates. A co-signer will help unlock the lowest interest rates.";
    }

    // Calculate estimated interest rate & EMI
    // EMI formula: P * r * (1 + r)^n / ((1 + r)^n - 1)
    // Let's approximate using simple loan calculations.
    // Assume 9.5% p.a. interest, 10 years (120 months) repayment tenure.
    final double annualRate = baseScore >= 80 ? 8.45 : (baseScore >= 60 ? 9.60 : 10.85);
    final double monthlyRate = (annualRate / 100) / 12;
    const int months = 120; // 10 years tenure

    double emi = 0.0;
    if (loanAmountUSD > 0) {
      // EMI = [P x R x (1+R)^N]/[((1+R)^N)-1]
      importMathPow(double base, int exponent) {
        double result = 1.0;
        for (int i = 0; i < exponent; i++) {
          result *= base;
        }
        return result;
      }
      final double powerFactor = importMathPow(1 + monthlyRate, months);
      emi = (loanAmountUSD * monthlyRate * powerFactor) / (powerFactor - 1);
    }

    // Filter matched lenders
    List<LoanOfferModel> matched = [];
    if (baseScore >= 80) {
      // matches public sector & private banks best
      matched = DummyData.loanOffers.toList();
    } else if (baseScore >= 60) {
      // private banks & nbfcs
      matched = DummyData.loanOffers.where((offer) => 
        offer.type == ProviderType.privateBank || 
        offer.type == ProviderType.nbfc ||
        offer.type == ProviderType.intlLender
      ).toList();
    } else {
      // NBFCs & Intl
      matched = DummyData.loanOffers.where((offer) => 
        offer.type == ProviderType.nbfc || 
        offer.type == ProviderType.intlLender
      ).toList();
    }

    return EligibilityResult(
      score: baseScore,
      status: status,
      message: message,
      estimatedEmi: emi,
      interestRate: annualRate,
      matchedLenders: matched,
    );
  }
}
