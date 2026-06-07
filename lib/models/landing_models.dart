import 'package:flutter/material.dart';

class FeatureModel {
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;

  const FeatureModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
  });
}

class TimelineStepModel {
  final String stepNumber;
  final String title;
  final String description;
  final IconData icon;

  const TimelineStepModel({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });
}

enum ProviderType {
  publicBank("Public Sector Bank"),
  privateBank("Private Bank"),
  nbfc("NBFC"),
  intlLender("International Lender");

  final String displayName;
  const ProviderType(this.displayName);
}

class LoanOfferModel {
  final String providerName;
  final ProviderType type;
  final double interestRateMin;
  final String processingTime;
  final List<String> benefits;
  final String eligibility;
  final String maxLoanAmount;

  const LoanOfferModel({
    required this.providerName,
    required this.type,
    required this.interestRateMin,
    required this.processingTime,
    required this.benefits,
    required this.eligibility,
    required this.maxLoanAmount,
  });
}

class TestimonialModel {
  final String studentName;
  final String university;
  final String country;
  final String loanAmount;
  final String review;
  final String initials;
  final Color avatarBgColor;

  const TestimonialModel({
    required this.studentName,
    required this.university,
    required this.country,
    required this.loanAmount,
    required this.review,
    required this.initials,
    required this.avatarBgColor,
  });
}

class DestinationModel {
  final String countryName;
  final String flagEmoji;
  final String description;
  final String visaSuccessRate;
  final String popularCourses;
  final Color themeColor;

  const DestinationModel({
    required this.countryName,
    required this.flagEmoji,
    required this.description,
    required this.visaSuccessRate,
    required this.popularCourses,
    required this.themeColor,
  });
}

class FaqModel {
  final String question;
  final String answer;

  const FaqModel({
    required this.question,
    required this.answer,
  });
}
