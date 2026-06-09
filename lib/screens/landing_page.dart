import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/colors.dart';
import '../models/landing_models.dart';
import '../services/dummy_data.dart';
import '../utils/responsive.dart';
import '../services/email_service.dart';
import '../widgets/counter_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/eligibility_checker.dart';
import '../widgets/faq_accordion.dart';
import '../widgets/glass_card.dart';
import '../widgets/hero_illustration.dart';
import '../widgets/interactive_timeline.dart';
import '../widgets/logo_carousel.dart';
import '../widgets/testimonial_slider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  // Section Keys for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _whyChooseKey = GlobalKey();
  final GlobalKey _processKey = GlobalKey();
  final GlobalKey _marketplaceKey = GlobalKey();
  final GlobalKey _partnersKey = GlobalKey();
  final GlobalKey _calculatorKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _destinationsKey = GlobalKey();
  final GlobalKey _faqKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // FAQ Expanded State
  int _expandedFaqIndex = 0;

  // Contact Form Controllers & State
  final _contactFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _selectedDestination = "United States (USA)";
  bool _formSubmitted = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 50 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 50 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 850),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _handleContactSubmit() async {
    if (_contactFormKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      // Send details to gunit.kalra@harborfintech.com
      await EmailService.sendLeadEmail(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        destination: _selectedDestination,
        message: _messageController.text,
      );

      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _formSubmitted = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Stack(
        children: [
          // Background decorative gradients/shapes
          Positioned(
            top: -200,
            left: -200,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withAlpha(15),
              ),
            ),
          ),
          
          // Main Scrollable Area
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // 2. Hero Section
                  _buildHeroSection(),

                  // 3. Trusted By (Logo Carousel)
                  _buildTrustedBySection(),

                  // 4. Why Choose Section
                  _buildWhyChooseSection(),

                  // 5. Loan Process Section (Interactive Timeline)
                  _buildLoanProcessSection(),

                  // 6. Marketplace Section (Comparison Cards)
                  _buildMarketplaceSection(),

                  // 7. Eligibility Checker
                  _buildEligibilityCheckerSection(),

                  // 8. Statistics Section (Counters)
                  _buildStatisticsSection(),

                  // 9. Success Stories (Testimonials Slider)
                  _buildSuccessStoriesSection(),

                  // 10. Study Destination Section
                  _buildDestinationsSection(),

                  // 11. FAQ Section (Accordion)
                  _buildFaqSection(),

                  // 12. Lead Gen CTA
                  _buildLeadGenCTASection(),

                  // 13. Contact & Offices Section
                  _buildContactSection(),

                  // 14. Footer
                  _buildFooterSection(),
                ],
              ),
            ),
          ),

          // 1. Sticky Navigation Bar
          _buildStickyNavBar(),
        ],
      ),
    );
  }

  // ==================== 1. STICKY NAV BAR ====================
  Widget _buildStickyNavBar() {
    final bool isMobile = Responsive.isMobile(context);

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 80,
        decoration: BoxDecoration(
          color: _isScrolled ? Colors.white.withAlpha(235) : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: _isScrolled ? AppColors.textLight.withAlpha(25) : Colors.transparent,
              width: 1.5,
            ),
          ),
          boxShadow: _isScrolled ? AppColors.premiumShadow : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo combined with icon
            GestureDetector(
              onTap: () => _scrollTo(_heroKey),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/logoooo.png',
                      height: 100,
                      width: 250,
                      fit: BoxFit.cover,
                    ),
                    // Container(
                    //   width: 42,
                    //   height: 42,
                    //   decoration: const BoxDecoration(
                    //     gradient: AppColors.primaryGradient,
                    //     shape: BoxShape.circle,
                    //   ),
                    //   child: const Icon(Icons.anchor, color: Colors.white, size: 22),
                    // ),
                    // const SizedBox(width: 12),
                    // Text(
                    //   "Harbor Finance",
                    //   style: AppTextStyles.heading(20, color: AppColors.textDark, weight: FontWeight.bold),
                    // ),
                  ],
                ),
              ),
            ),

            // Navigation Links (Desktop only)
            if (!isMobile)
              Row(
                children: [
                  _buildNavLink("Home", () => _scrollTo(_heroKey)),
                  _buildNavLink("About", () => _scrollTo(_whyChooseKey)),
                  _buildNavLink("Services", () => _scrollTo(_marketplaceKey)),
                  _buildNavLink("Partners", () => _scrollTo(_partnersKey)),
                  _buildNavLink("Testimonials", () => _scrollTo(_testimonialsKey)),
                  _buildNavLink("FAQs", () => _scrollTo(_faqKey)),
                  _buildNavLink("Contact", () => _scrollTo(_contactKey)),
                ],
              ),

            // CTA Button
            CustomButton(
              text: "Apply Now",
              onPressed: () => _scrollTo(_calculatorKey),
              glowEffect: true,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavLink(String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: AppTextStyles.body(14, color: AppColors.textDark, weight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  // ==================== 2. HERO SECTION ====================
  Widget _buildHeroSection() {
    final bool isMobile = Responsive.isMobile(context);
    final double padding = isMobile ? 24.0 : 80.0;

    return Container(
      key: _heroKey,
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.only(top: 140, left: padding, right: padding, bottom: 60),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Hero Info Column
              Expanded(
                flex: isMobile ? 0 : 5,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars, color: AppColors.accentGold, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            "98.4% Education Loan Approval Success",
                            style: AppTextStyles.body(12, color: Colors.white, weight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 24),
                    Text(
                      "Study Abroad Without\nFinancial Barriers",
                      style: AppTextStyles.display(
                        isMobile ? 38 : 56,
                        color: Colors.white,
                        weight: FontWeight.w800,
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ).animate().fadeIn(delay: 150.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 24),
                    Text(
                      "Compare, apply, and secure education loans from 15+ top government banks, private banks, NBFCs, and international lenders. Free guidance, zero markup, end-to-end documentation support.",
                      style: AppTextStyles.body(
                        isMobile ? 15 : 17,
                        color: const Color(0xFF94A3B8),
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
                    const SizedBox(height: 36),
                    Flex(
                      direction: isMobile ? Axis.vertical : Axis.horizontal,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          text: "Check Loan Eligibility",
                          onPressed: () => _scrollTo(_calculatorKey),
                          glowEffect: true,
                          width: isMobile ? double.infinity : 240,
                        ),
                        const SizedBox(width: 16, height: 16),
                        CustomButton(
                          text: "Talk to Expert",
                          onPressed: () => _scrollTo(_contactKey),
                          isSecondary: true,
                          width: isMobile ? double.infinity : 200,
                        ),
                      ],
                    ).animate().fadeIn(delay: 450.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
                  ],
                ),
              ),

              if (isMobile) const SizedBox(height: 48) else const SizedBox(width: 48),

              // Hero Illustration/Dashboard
              Expanded(
                flex: isMobile ? 0 : 5,
                child: const HeroIllustration(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 3. TRUSTED BY (LOGO CAROUSEL) ====================
  Widget _buildTrustedBySection() {
    return Container(
      key: _partnersKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            "OUR FINANCIAL PARTNERS & LENDERS",
            style: AppTextStyles.body(13, color: AppColors.textLight, weight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          const LogoCarousel(),
        ],
      ),
    );
  }

  // ==================== 4. WHY CHOOSE SECTION ====================
  Widget _buildWhyChooseSection() {
    final bool isMobile = Responsive.isMobile(context);
    final List<FeatureModel> features = DummyData.features;

    return Container(
      key: _whyChooseKey,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "WHY CHOOSE US",
                  style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Partnering with Students, Powering Ambitions",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "We streamline the overseas education loan process, assuring absolute transparency.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Grid of features
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.5 : 1.25,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return GlassCard(
                    borderRadius: 20,
                    bgColor: Colors.white,
                    bordercolor: Colors.black.withAlpha(10),
                    shadow: AppColors.premiumShadow,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: feature.accentColor.withAlpha(25),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(feature.icon, color: feature.accentColor, size: 28),
                          ),
                          const SizedBox(height: 18),
                          Text(
                            feature.title,
                            style: AppTextStyles.heading(18, color: AppColors.textDark),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            feature.description,
                            style: AppTextStyles.body(13, color: AppColors.textLight),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 5. LOAN PROCESS SECTION ====================
  Widget _buildLoanProcessSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      key: _processKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "STEP-BY-STEP PROCESS",
                  style: AppTextStyles.body(11, color: AppColors.accentTeal, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Your Journey to Abroad, Simplified",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "From initial profile submission to final university disbursement in 6 simple steps.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 54),
              const InteractiveTimeline(),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 6. MARKETPLACE SECTION ====================
  Widget _buildMarketplaceSection() {
    final bool isMobile = Responsive.isMobile(context);
    final List<LoanOfferModel> offers = DummyData.loanOffers;

    return Container(
      key: _marketplaceKey,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "LOAN MARKETPLACE",
                  style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Compare Lender Categories",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Unbiased comparisons between public banks, private banks, NBFCs, and international finance lenders.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Responsive Cards List
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 4),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 0.95 : 0.68,
                ),
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return GlassCard(
                    borderRadius: 24,
                    bgColor: Colors.white,
                    bordercolor: Colors.black.withAlpha(10),
                    shadow: AppColors.premiumShadow,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withAlpha(20),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              offer.type.displayName,
                              style: AppTextStyles.body(10, color: AppColors.secondary, weight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            offer.providerName,
                            style: AppTextStyles.heading(18, color: AppColors.textDark),
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),
                          
                          // Interest Rate block
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Rate Min", style: AppTextStyles.body(12, color: AppColors.textLight)),
                              Text(
                                "Starting @ ${offer.interestRateMin}% p.a.",
                                style: AppTextStyles.heading(14, color: AppColors.accentGreen, weight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Speed", style: AppTextStyles.body(12, color: AppColors.textLight)),
                              Text(
                                offer.processingTime,
                                style: AppTextStyles.heading(14, color: AppColors.textDark, weight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          Text(
                            "Key Benefits:",
                            style: AppTextStyles.heading(12, color: AppColors.textDark, weight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: offer.benefits.length,
                              itemBuilder: (context, bIndex) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.check_circle_outline, color: AppColors.accentTeal, size: 14),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          offer.benefits[bIndex],
                                          style: AppTextStyles.body(11, color: AppColors.textLight),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Eligibility: ${offer.eligibility}",
                            style: AppTextStyles.body(11, color: AppColors.textLight, weight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 7. ELIGIBILITY CHECKER SECTION ====================
  Widget _buildEligibilityCheckerSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      key: _calculatorKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary.withAlpha(25),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "INSTANT ELIGIBILITY CHECK",
                style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Check Your Loan Eligibility",
              style: AppTextStyles.heading(isMobile ? 24 : 36),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "No credit check required. Unbiased approval chance evaluation instantly.",
              style: AppTextStyles.body(15, color: AppColors.textLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            EligibilityChecker(
              onApplySuccess: () {
                _scrollTo(_contactKey);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==================== 8. STATISTICS SECTION ====================
  Widget _buildStatisticsSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      color: const Color(0xFF0F172A), // Sleek Dark Fintech Panel
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(15000, "+", "Students Assisted"),
              if (isMobile) const Divider(color: Colors.white12, height: 32),
              _buildStatItem(450, "M+", "Loan Amount Processed", prefix: "\$"),
              if (isMobile) const Divider(color: Colors.white12, height: 32),
              _buildStatItem(15, "+", "Partner Institutions"),
              if (isMobile) const Divider(color: Colors.white12, height: 32),
              _buildStatItem(98, "%", "Approval Success Rate"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(int target, String suffix, String label, {String prefix = ""}) {
    return CounterWidget(
      targetValue: target,
      suffix: suffix,
      prefix: prefix,
      label: label,
    );
  }

  // ==================== 9. STUDENT SUCCESS STORIES ====================
  Widget _buildSuccessStoriesSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      key: _testimonialsKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "STUDENT TESTIMONIALS",
                  style: AppTextStyles.body(11, color: AppColors.accentTeal, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Student Success Stories",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Hear what students say about achieving their global career dreams with Harbor Finance.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              const TestimonialSlider(),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 10. STUDY DESTINATION SECTION ====================
  Widget _buildDestinationsSection() {
    final bool isMobile = Responsive.isMobile(context);
    final List<DestinationModel> dests = DummyData.destinations;

    return Container(
      key: _destinationsKey,
      color: const Color(0xFFF8FAFC),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "DESTINATIONS SUPPORTED",
                  style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Top Study Abroad Destinations",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Optimized loan pathways specifically configured for country-specific student visas.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: isMobile ? 1.35 : 1.25,
                ),
                itemCount: dests.length,
                itemBuilder: (context, index) {
                  final dest = dests[index];
                  return GlassCard(
                    borderRadius: 20,
                    bgColor: Colors.white,
                    bordercolor: Colors.black.withAlpha(10),
                    shadow: AppColors.premiumShadow,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                dest.flagEmoji,
                                style: const TextStyle(fontSize: 36),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.accentGreen.withAlpha(20),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "Visa Rate: ${dest.visaSuccessRate}",
                                  style: AppTextStyles.body(11, color: AppColors.accentGreen, weight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          Text(
                            dest.countryName,
                            style: AppTextStyles.heading(18, color: AppColors.textDark),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            dest.description,
                            style: AppTextStyles.body(13, color: AppColors.textLight),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          const Divider(),
                          const SizedBox(height: 6),
                          Text(
                            "Courses: ${dest.popularCourses}",
                            style: AppTextStyles.body(11, color: AppColors.textDark, weight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 11. FAQ SECTION ====================
  Widget _buildFaqSection() {
    final bool isMobile = Responsive.isMobile(context);
    final List<FaqModel> faqs = DummyData.faqs;

    return Container(
      key: _faqKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentTeal.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "HAVE QUESTIONS?",
                  style: AppTextStyles.body(11, color: AppColors.accentTeal, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Frequently Asked Questions",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Clear answers regarding rates, collaterals, and how our 100% free consult works.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              Column(
                children: List.generate(faqs.length, (index) {
                  return FaqAccordionItem(
                    faq: faqs[index],
                    isExpanded: _expandedFaqIndex == index,
                    onTap: () {
                      setState(() {
                        _expandedFaqIndex = _expandedFaqIndex == index ? -1 : index;
                      });
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 12. LEAD GENERATION CTA ====================
  Widget _buildLeadGenCTASection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 950),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Get Your Education Loan Approved Faster",
                      style: AppTextStyles.heading(isMobile ? 28 : 38, color: Colors.white),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Join 15,000+ students who compared rates and secure their studies stress-free. Receive a detailed financial report in under 24 hours.",
                      style: AppTextStyles.body(15, color: Colors.white70),
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    ),
                  ],
                ),
              ),
              if (isMobile) const SizedBox(height: 32) else const SizedBox(width: 48),
              Expanded(
                flex: isMobile ? 0 : 4,
                child: Column(
                  children: [
                    CustomButton(
                      text: "Apply Now",
                      onPressed: () => _scrollTo(_calculatorKey),
                      glowEffect: true,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      text: "Schedule Free Consultation",
                      onPressed: () => _scrollTo(_contactKey),
                      isSecondary: true,
                      // Invert secondary colors for dark backgrounds
                      width: double.infinity,
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                     .scale(begin: const Offset(1,1), end: const Offset(1.02, 1.02), duration: 2.seconds, curve: Curves.easeInOut),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== 13. CONTACT SECTION ====================
  Widget _buildContactSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      key: _contactKey,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "CONTACT US",
                  style: AppTextStyles.body(11, color: AppColors.secondary, weight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Talk to an Overseas Financing Expert",
                style: AppTextStyles.heading(isMobile ? 24 : 36),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Our dedicated loan counseling experts are happy to solve your queries.",
                style: AppTextStyles.body(15, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 54),

              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contact details & Office / Mock Map
                  Expanded(
                    flex: isMobile ? 0 : 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Harbor Corporate Office",
                          style: AppTextStyles.heading(22),
                        ),
                        const SizedBox(height: 16),
                        _buildContactDetailItem(Icons.email_outlined, "Email Support", "info@harborfintech.com"),
                        _buildContactDetailItem(Icons.phone_outlined, "Helpline Phone", "+91-9258756581"),
                        _buildContactDetailItem(Icons.location_on_outlined, "Address Headquarters", " ground floor,Tower 8,Candor TechSpace Sec-135 , Noida, India"),
                        const SizedBox(height: 32),
                        
                        // Mock Google Map component
                        Text(
                          "Global Location Hubs",
                          style: AppTextStyles.heading(16, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.white10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Abstract grid representing mapping
                              Opacity(
                                opacity: 0.15,
                                child: GridView.builder(
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 10,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                  ),
                                  itemCount: 100,
                                  itemBuilder: (context, idx) => Container(color: Colors.white),
                                ),
                              ),
                              // Centered custom map marker
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_pin, color: Colors.redAccent, size: 36)
                                      .animate(onPlay: (controller) => controller.repeat(reverse: true))
                                      .slideY(begin: 0, end: -0.2, duration: 1.seconds, curve: Curves.easeInOut),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white24),
                                    ),
                                    child: Text(
                                      "Bangalore Hub (HQ)",
                                      style: AppTextStyles.body(11, color: Colors.white, weight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isMobile) const SizedBox(height: 48) else const SizedBox(width: 48),

                  // Lead Gen Contact Form
                  Expanded(
                    flex: isMobile ? 0 : 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black12),
                        boxShadow: AppColors.premiumShadow,
                      ),
                      padding: const EdgeInsets.all(28),
                      child: _formSubmitted 
                          ? _buildThankYouState() 
                          : Form(
                              key: _contactFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Request a Call Back",
                                    style: AppTextStyles.heading(20, color: AppColors.textDark),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Get contacted by our finance counseling expert.",
                                    style: AppTextStyles.body(13, color: AppColors.textLight),
                                  ),
                                  const SizedBox(height: 24),
                                  
                                  _buildFormTextField(_nameController, "Your Name", Icons.person_outline),
                                  const SizedBox(height: 16),
                                  _buildFormTextField(_emailController, "Your Email", Icons.email_outlined, isEmail: true),
                                  const SizedBox(height: 16),
                                  _buildFormTextField(_phoneController, "Phone Number", Icons.phone_outlined, isPhone: true),
                                  const SizedBox(height: 16),
                                  
                                  // Selected Destination Dropdown in Form
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Preferred Destination",
                                        style: AppTextStyles.heading(12, color: AppColors.textDark, weight: FontWeight.w600),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(color: Colors.black12),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _selectedDestination,
                                            isExpanded: true,
                                            icon: const Icon(Icons.arrow_drop_down, color: AppColors.textLight),
                                            items: DummyData.destinations.map((d) => DropdownMenuItem(
                                              value: d.countryName,
                                              child: Text(d.countryName, style: AppTextStyles.body(14, color: AppColors.textDark)),
                                            )).toList(),
                                            onChanged: (val) {
                                              if (val != null) setState(() => _selectedDestination = val);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  
                                  _buildFormTextField(_messageController, "Short Message / Notes", Icons.chat_bubble_outline, maxLines: 3),
                                  const SizedBox(height: 28),
                                  
                                  _isSubmitting 
                                      ? const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(AppColors.secondary)))
                                      : CustomButton(
                                          text: "Schedule Free Call",
                                          onPressed: _handleContactSubmit,
                                          icon: Icons.calendar_today_outlined,
                                          width: double.infinity,
                                        ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactDetailItem(IconData icon, String title, String val) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.secondary, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.body(12, color: AppColors.textLight, weight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  val,
                  style: AppTextStyles.heading(15, color: AppColors.textDark, weight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTextField(TextEditingController controller, String label, IconData icon, {bool isEmail = false, bool isPhone = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.heading(12, color: AppColors.textDark, weight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: AppTextStyles.body(14, color: AppColors.textDark),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter this details';
              }
              if (isEmail && !value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: AppColors.textLight, size: 18),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.secondary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThankYouState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: AppColors.accentGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 40),
          ).animate().scale(duration: 400.ms, curve: Curves.elasticOut),
          const SizedBox(height: 24),
          Text(
            "Booking Scheduled!",
            style: AppTextStyles.heading(24, color: AppColors.textDark),
          ),
          const SizedBox(height: 12),
          Text(
            "Thank you, ${_nameController.text}. An overseas education loan expert will call you on your number (${_phoneController.text}) in the next 4 hours.",
            style: AppTextStyles.body(14, color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: "Close & Recalculate",
            onPressed: () {
              setState(() {
                _formSubmitted = false;
                _nameController.clear();
                _emailController.clear();
                _phoneController.clear();
                _messageController.clear();
              });
            },
            width: 200,
          ),
        ],
      ),
    );
  }

  // ==================== 14. FOOTER ====================
  Widget _buildFooterSection() {
    final bool isMobile = Responsive.isMobile(context);

    return Container(
      color: AppColors.primary, // Deep Navy Slate
      padding: const EdgeInsets.only(top: 80, left: 40, right: 40, bottom: 40),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo & Brand Pitch
                  Expanded(
                    flex: isMobile ? 0 : 4,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/logoooo.png',
                              height: 50,
                              fit: BoxFit.contain,
                              color: Colors.white,
                              colorBlendMode: BlendMode.srcIn,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Empowering dreams through low-rate, stress-free education loans for students going abroad. Partnering with top-tier global banking leaders.",
                          style: AppTextStyles.body(13, color: Colors.white60),
                          textAlign: isMobile ? TextAlign.center : TextAlign.start,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                          children: [
                            _buildSocialIcon(Icons.facebook),
                            _buildSocialIcon(Icons.link),
                            _buildSocialIcon(Icons.message),
                            _buildSocialIcon(Icons.video_library),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (isMobile) const SizedBox(height: 40) else const SizedBox(width: 60),

                  // Quick Links
                  Expanded(
                    flex: isMobile ? 0 : 2,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Quick Links",
                          style: AppTextStyles.heading(14, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink("Home", () => _scrollTo(_heroKey)),
                        _buildFooterLink("Why Us", () => _scrollTo(_whyChooseKey)),
                        _buildFooterLink("Lender Marketplace", () => _scrollTo(_marketplaceKey)),
                        _buildFooterLink("Testimonials", () => _scrollTo(_testimonialsKey)),
                      ],
                    ),
                  ),

                  if (isMobile) const SizedBox(height: 40),

                  // Services Links
                  Expanded(
                    flex: isMobile ? 0 : 2,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Our Services",
                          style: AppTextStyles.heading(14, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        _buildFooterLink("Collateral Loan Advisory", () => _scrollTo(_calculatorKey)),
                        _buildFooterLink("Unsecured Global Loans", () => _scrollTo(_calculatorKey)),
                        _buildFooterLink("Pre-Admission Sanctions", () => _scrollTo(_calculatorKey)),
                        _buildFooterLink("Blocked Accounts Support", () => _scrollTo(_calculatorKey)),
                      ],
                    ),
                  ),

                  if (isMobile) const SizedBox(height: 40),

                  // Contacts Quick
                  Expanded(
                    flex: isMobile ? 0 : 3,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Connect",
                          style: AppTextStyles.heading(14, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text("info@harborfintech.com", style: AppTextStyles.body(13, color: Colors.white70)),
                        const SizedBox(height: 8),
                        Text("+91-9258756581", style: AppTextStyles.body(13, color: Colors.white70)),
                        const SizedBox(height: 8),
                        Text("ground floor,Tower 8,Candor TechSpace Sec-135 , Noida, India", style: AppTextStyles.body(13, color: Colors.white60)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              const Divider(color: Colors.white12),
              const SizedBox(height: 24),
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "© 2026 Harbor Finance. All rights reserved.",
                    style: AppTextStyles.body(12, color: Colors.white38),
                  ),
                  if (isMobile) const SizedBox(height: 8),
                  Text(
                    "Designed with Premium UX | ISO 27001 Certified",
                    style: AppTextStyles.body(12, color: Colors.white38),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLink(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            title,
            style: AppTextStyles.body(13, color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Colors.white12,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}
