import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/landing_models.dart';
import '../services/dummy_data.dart';
import '../utils/responsive.dart';

class TestimonialSlider extends StatefulWidget {
  const TestimonialSlider({super.key});

  @override
  State<TestimonialSlider> createState() => _TestimonialSliderState();
}

class _TestimonialSliderState extends State<TestimonialSlider> {
  final PageController _pageController = PageController(viewportFraction: 0.85);
  int _currentIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;
      int nextIndex = _currentIndex + 1;
      if (nextIndex >= DummyData.testimonials.length) {
        nextIndex = 0;
      }
      _animateToPage(nextIndex);
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
  }

  void _animateToPage(int index) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<TestimonialModel> testimonials = DummyData.testimonials;
    final bool isMobile = Responsive.isMobile(context);

    // Adjust PageController viewport fraction dynamically
    final double fraction = isMobile ? 0.95 : 0.8;
    
    // We recreate PageController only if view sizes change drastically,
    // but a static controller with responsive builder parameters works best.

    return Column(
      children: [
        SizedBox(
          height: isMobile ? 360 : 280,
          child: PageView.builder(
            controller: PageController(viewportFraction: fraction),
            itemCount: testimonials.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final testimonial = testimonials[index];
              final bool isSelected = _currentIndex == index;

              return AnimatedScale(
                scale: isSelected ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: isSelected ? 1.0 : 0.6,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.secondary.withAlpha(40) 
                            : AppColors.textLight.withAlpha(15),
                        width: 1.5,
                      ),
                      boxShadow: isSelected ? AppColors.premiumShadow : null,
                    ),
                    padding: EdgeInsets.all(isMobile ? 20 : 28),
                    child: Flex(
                      direction: isMobile ? Axis.vertical : Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar block
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: testimonial.avatarBgColor.withAlpha(40),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                testimonial.initials,
                                style: AppTextStyles.heading(18, color: testimonial.avatarBgColor, weight: FontWeight.bold),
                              ),
                            ),
                            if (isMobile) ...[
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    testimonial.studentName,
                                    style: AppTextStyles.heading(16, color: AppColors.textDark),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${testimonial.university} (${testimonial.country})",
                                    style: AppTextStyles.body(12, color: AppColors.textLight),
                                  ),
                                ],
                              )
                            ],
                          ],
                        ),
                        if (!isMobile) const SizedBox(width: 24) else const SizedBox(height: 16),
                        
                        // Text review block
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Quotes & Rating Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.format_quote, color: AppColors.secondary, size: 32),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.accentGreen.withAlpha(20),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.monetization_on_outlined, size: 14, color: AppColors.accentGreen),
                                        const SizedBox(width: 4),
                                        Text(
                                          testimonial.loanAmount,
                                          style: AppTextStyles.body(12, color: AppColors.accentGreen, weight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              
                              // Review Text
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    testimonial.review,
                                    style: AppTextStyles.body(14, color: AppColors.textLight),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              
                              // Student details for Desktop
                              if (!isMobile) ...[
                                Text(
                                  testimonial.studentName,
                                  style: AppTextStyles.heading(16, color: AppColors.textDark),
                                ),
                                Text(
                                  "${testimonial.university}, ${testimonial.country}",
                                  style: AppTextStyles.body(12, color: AppColors.textLight, weight: FontWeight.w500),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        
        // Navigation Dots & Arrows
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: AppColors.textLight),
              onPressed: () {
                _stopAutoPlay();
                int prev = _currentIndex - 1;
                if (prev < 0) prev = testimonials.length - 1;
                _animateToPage(prev);
                _startAutoPlay();
              },
            ),
            const SizedBox(width: 8),
            Row(
              children: List.generate(testimonials.length, (index) {
                final bool isActive = _currentIndex == index;
                return GestureDetector(
                  onTap: () {
                    _stopAutoPlay();
                    _animateToPage(index);
                    _startAutoPlay();
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.secondary : AppColors.textMuted.withAlpha(100),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.chevron_right, color: AppColors.textLight),
              onPressed: () {
                _stopAutoPlay();
                int next = _currentIndex + 1;
                if (next >= testimonials.length) next = 0;
                _animateToPage(next);
                _startAutoPlay();
              },
            ),
          ],
        ),
      ],
    );
  }
}
