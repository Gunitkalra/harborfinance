import 'package:flutter/material.dart';
import '../models/landing_models.dart';

class DummyData {
  static const List<String> partnerLogos = [
    'State Bank of India',
    'HDFC Bank',
    'ICICI Bank',
    'Axis Bank',
    'Bank of Baroda',
    'Avanse Financial',
    'InCred Finance',
    'Auxilo Finserve',
    'Mpower Financing',
    'Prodigy Finance',
    'IDFC First Bank',
    'Canara Bank'
  ];

  static const List<FeatureModel> features = [
    FeatureModel(
      title: "Multiple Bank Partnerships",
      description: "Compare and choose from 15+ top public sector banks, private banks, NBFCs, and international lenders under one roof.",
      icon: Icons.account_balance_outlined,
      accentColor: Colors.blue,
    ),
    FeatureModel(
      title: "Lowest Interest Rates",
      description: "Get access to exclusive discounted interest rates starting at just 8.25% p.a. through our banking partnerships.",
      icon: Icons.trending_down_outlined,
      accentColor: Colors.teal,
    ),
    FeatureModel(
      title: "Fast Approval Process",
      description: "Get a conditional loan approval sanction letter within 48 to 72 hours, helping you meet tight university deadlines.",
      icon: Icons.flash_on_outlined,
      accentColor: Colors.amber,
    ),
    FeatureModel(
      title: "Expert Loan Advisors",
      description: "Dedicated financing experts to handhold you through profile evaluation, document checklist, and final disbursement.",
      icon: Icons.support_agent_outlined,
      accentColor: Colors.purple,
    ),
    FeatureModel(
      title: "High Approval Success Rate",
      description: "Our structured profiling and documentation preparation lead to a 98% approval rate even for complex profiles.",
      icon: Icons.workspace_premium_outlined,
      accentColor: Colors.green,
    ),
    FeatureModel(
      title: "End-to-End Doc Support",
      description: "Complete assistance in compiling financial documents, property evaluations, income proof, and co-applicant profiling.",
      icon: Icons.description_outlined,
      accentColor: Colors.red,
    ),
  ];

  static const List<TimelineStepModel> timelineSteps = [
    TimelineStepModel(
      stepNumber: "01",
      title: "Submit Application",
      description: "Fill out a quick 2-minute online form with your basic academic and financial details.",
      icon: Icons.assignment_outlined,
    ),
    TimelineStepModel(
      stepNumber: "02",
      title: "Profile Evaluation",
      description: "Our algorithm and loan advisors evaluate your eligibility, recommending the best lenders.",
      icon: Icons.analytics_outlined,
    ),
    TimelineStepModel(
      stepNumber: "03",
      title: "Compare Loan Offers",
      description: "Get personalized loan quotes from multiple partners side-by-side to choose the lowest rates.",
      icon: Icons.compare_arrows_outlined,
    ),
    TimelineStepModel(
      stepNumber: "04",
      title: "Documentation Assistance",
      description: "Upload your documents securely. We review them to ensure zero discrepancy and submit to selected bank.",
      icon: Icons.folder_shared_outlined,
    ),
    TimelineStepModel(
      stepNumber: "05",
      title: "Sanction & Approval",
      description: "The lender verifies the application and issues your official loan sanction letter in record time.",
      icon: Icons.check_circle_outline_outlined,
    ),
    TimelineStepModel(
      stepNumber: "06",
      title: "Disbursement",
      description: "Funds are directly remitted to your university for tuition fees and your account for living expenses.",
      icon: Icons.monetization_on_outlined,
    ),
  ];

  static const List<LoanOfferModel> loanOffers = [
    LoanOfferModel(
      providerName: "Public Sector Banks",
      type: ProviderType.publicBank,
      interestRateMin: 8.25,
      processingTime: "7 - 10 Days",
      benefits: [
        "Lowest interest rates overall",
        "Concession for female students (0.5%)",
        "Zero pre-payment charges",
        "No collateral options up to \$10k"
      ],
      eligibility: "Co-applicant income + Good academic record",
      maxLoanAmount: "Up to \$100,000",
    ),
    LoanOfferModel(
      providerName: "Premium Private Lenders",
      type: ProviderType.privateBank,
      interestRateMin: 9.50,
      processingTime: "4 - 5 Days",
      benefits: [
        "Faster processing time",
        "Multi-city co-applicant support",
        "Digital paperless documentation",
        "High collateral-free limits"
      ],
      eligibility: "Co-applicant salary + CIBIL score 700+",
      maxLoanAmount: "Up to \$150,000",
    ),
    LoanOfferModel(
      providerName: "Specialized NBFCs",
      type: ProviderType.nbfc,
      interestRateMin: 10.25,
      processingTime: "2 - 3 Days",
      benefits: [
        "Ultra-fast processing & approval",
        "Highly flexible eligibility criteria",
        "100% funding of cost of education",
        "Customized repayment options"
      ],
      eligibility: "Wider range of income profiles accepted",
      maxLoanAmount: "Up to \$120,000",
    ),
    LoanOfferModel(
      providerName: "International FinTech Lenders",
      type: ProviderType.intlLender,
      interestRateMin: 11.50,
      processingTime: "3 - 4 Days",
      benefits: [
        "No collateral or co-signer required",
        "Loans in USD, GBP, or EUR directly",
        "Build credit history abroad",
        "Repayment starts post graduation"
      ],
      eligibility: "STEM/Premium programs + GRE/GMAT score",
      maxLoanAmount: "Up to \$100,000",
    ),
  ];

  static const List<TestimonialModel> testimonials = [
    TestimonialModel(
      studentName: "Aditya Sharma",
      university: "Northeastern University",
      country: "USA",
      loanAmount: "\$65,000",
      review: "Harbor Finance made the impossible possible! I was struggling to get a collateral-free loan for my MS in CS. Their advisors compared multiple NBFCs and international lenders, helping me secure an unsecured USD loan at a rate far lower than what I was getting directly.",
      initials: "AS",
      avatarBgColor: Colors.blueAccent,
    ),
    TestimonialModel(
      studentName: "Priyanka Nair",
      university: "University of Toronto",
      country: "Canada",
      loanAmount: "CAD 72,000",
      review: "The end-to-end documentation support was a lifesaver. Preparing the tax transcripts and property papers was so confusing, but the Harbor team guided my father every step of the way. We got the sanction letter in just 5 days!",
      initials: "PN",
      avatarBgColor: Colors.teal,
    ),
    TestimonialModel(
      studentName: "Rohan Das",
      university: "Imperial College London",
      country: "UK",
      loanAmount: "£45,000",
      review: "I highly recommend Harbor Finance. Their comparison marketplace is transparent and completely unbiased. I was able to verify public bank offers and private lender quotes before locking in the best deal. 10/10 service!",
      initials: "RD",
      avatarBgColor: Colors.deepPurple,
    ),
    TestimonialModel(
      studentName: "Meera Reddy",
      university: "University of Melbourne",
      country: "Australia",
      loanAmount: "AUD 80,000",
      review: "Getting a loan for Australia is complex due to strict visa-financial guidelines. Harbor Finance ensured all bank statements were perfectly compliant. The disbursement was prompt, and I had zero issues during visa verification.",
      initials: "MR",
      avatarBgColor: Colors.orange,
    ),
  ];

  static const List<DestinationModel> destinations = [
    DestinationModel(
      countryName: "United States (USA)",
      flagEmoji: "🇺🇸",
      description: "The top destination for tech & management courses with high collateral-free loan availability.",
      visaSuccessRate: "92%",
      popularCourses: "MS in STEM, MBA, Data Science",
      themeColor: Colors.redAccent,
    ),
    DestinationModel(
      countryName: "Canada",
      flagEmoji: "🇨🇦",
      description: "Highly student-friendly environment with excellent PGWP (Post-Grad Work Permit) pathways.",
      visaSuccessRate: "89%",
      popularCourses: "Computer Science, Finance, Engineering",
      themeColor: Colors.red,
    ),
    DestinationModel(
      countryName: "United Kingdom (UK)",
      flagEmoji: "🇬🇧",
      description: "1-year master programs available with fast-track loan disbursements from major lenders.",
      visaSuccessRate: "95%",
      popularCourses: "Business Analytics, MBA, Public Health",
      themeColor: Colors.blueAccent,
    ),
    DestinationModel(
      countryName: "Australia",
      flagEmoji: "🇦🇺",
      description: "Excellent post-study work rights and strict but stable financial visa clearance.",
      visaSuccessRate: "87%",
      popularCourses: "IT, Engineering, Accounting",
      themeColor: Colors.indigo,
    ),
    DestinationModel(
      countryName: "Germany",
      flagEmoji: "🇩🇪",
      description: "Tuition-free public universities. Blocked account loans and living cost financing support.",
      visaSuccessRate: "94%",
      popularCourses: "Automotive, Robotics, AI, STEM",
      themeColor: Colors.amber,
    ),
    DestinationModel(
      countryName: "Ireland",
      flagEmoji: "🇮🇪",
      description: "European tech hub offering a 2-year post-study work visa for master graduates.",
      visaSuccessRate: "91%",
      popularCourses: "Software Engineering, Cloud Computing",
      themeColor: Colors.green,
    ),
  ];

  static const List<FaqModel> faqs = [
    FaqModel(
      question: "What is Harbor Finance, and how does it help students?",
      answer: "Harbor Finance is an education loan advisor and comparison marketplace. We partner with over 15 leading public banks, private banks, NBFCs, and international lenders to help you find, compare, and secure the lowest interest rates. Our services—from eligibility check to loan disbursement—are 100% free for students.",
    ),
    FaqModel(
      question: "Is there any charge for Harbor Finance services?",
      answer: "No, our consultation, eligibility checking, application filing, and document processing services are completely free for students. We are compensated directly by our partner financial institutions for bringing qualified student profiles.",
    ),
    FaqModel(
      question: "What is the difference between collateral and non-collateral loans?",
      answer: "Collateral loans require you to pledge an asset (like house, plot, fixed deposit) as security. These generally have lower interest rates (starting at 8.25%). Non-collateral (unsecured) loans do not require assets and are approved based on the student's academic profile, university ranking, and co-applicant's income.",
    ),
    FaqModel(
      question: "How much education loan can I secure without collateral?",
      answer: "Depending on your academic profile, co-applicant income, and destination country, you can secure up to \$100,000 (INR 75-80 Lakhs) collateral-free for premier global universities in the US, UK, Canada, and Australia.",
    ),
    FaqModel(
      question: "What documents are required to check loan eligibility?",
      answer: "To check basic eligibility, you only need your university admission letter (or GRE/GMAT score if applying ahead), co-applicant's income proof (salaried/business), and student's academic marks. We will guide you through the detailed document list once you select a lender.",
    ),
    FaqModel(
      question: "How long does it take for the loan to be approved?",
      answer: "NBFCs and private banks can issue conditional approvals within 2 to 4 working days once files are submitted. Public sector banks typically take 7 to 10 working days. Harbor Finance speeds this up through dedicated escalations at our partner banks.",
    ),
  ];
}
