import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import 'glass_card.dart';

class HeroIllustration extends StatelessWidget {
  const HeroIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      width: 500,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow Circle 1
          Positioned(
            top: 40,
            left: 50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withAlpha(20),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 3.seconds, curve: Curves.easeInOut),
          ),
          
          // Background Glow Circle 2
          Positioned(
            bottom: 40,
            right: 50,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentTeal.withAlpha(15),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(begin: const Offset(1.1, 1.1), end: const Offset(0.9, 0.9), duration: 2.5.seconds, curve: Curves.easeInOut),
          ),

          // Central Mock Dashboard Card
          Positioned(
            top: 70,
            left: 30,
            right: 30,
            child: GlassCard(
              borderRadius: 24,
              blur: 15,
              bordercolor: Colors.white.withAlpha(40),
              bgColor: Colors.white.withAlpha(20),
              animateOnHover: false,
              shadow: AppColors.premiumShadow,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top header of mock dashboard
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        Text(
                          "harbor_portal_v1.0",
                          style: AppTextStyles.body(11, color: Colors.white60, weight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Main Loan Amount approved card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "APPROVED LOAN SANCTION",
                                style: AppTextStyles.body(10, color: Colors.white70, weight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "\$68,500 USD",
                                style: AppTextStyles.heading(24, color: Colors.white, weight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.accentGreen,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_upward, size: 12, color: Colors.white),
                                const SizedBox(width: 4),
                                Text(
                                  "Approved",
                                  style: AppTextStyles.body(11, color: Colors.white, weight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Interest rate comparison bar chart
                    Text(
                      "INTEREST RATE COMPARISON",
                      style: AppTextStyles.body(10, color: Colors.white70, weight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    _buildChartBar("Public Banks", 0.6, "8.25%", AppColors.accentGreen),
                    const SizedBox(height: 8),
                    _buildChartBar("Private Banks", 0.78, "9.50%", AppColors.secondary),
                    const SizedBox(height: 8),
                    _buildChartBar("NBFC Partners", 0.9, "10.25%", AppColors.accentGold),
                  ],
                ),
              ),
            ),
          ).animate().slideY(begin: 0.1, end: 0, duration: 800.ms, curve: Curves.easeOutCubic).fadeIn(),

          // Floating Card 1: Success rate
          Positioned(
            top: 20,
            right: 10,
            child: GlassCard(
              borderRadius: 16,
              bgColor: Colors.white.withAlpha(40),
              animateOnHover: false,
              shadow: AppColors.premiumShadow,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.accentGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Approval Rate",
                          style: AppTextStyles.body(11, color: Colors.white70, weight: FontWeight.bold),
                        ),
                        Text(
                          "98.4%",
                          style: AppTextStyles.heading(16, color: Colors.white, weight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .slideY(begin: 0, end: -0.1, duration: 2.seconds, curve: Curves.easeInOut)
           .fadeIn(delay: 300.ms),

          // Floating Card 2: Advisors Online
          Positioned(
            bottom: 30,
            left: 10,
            child: GlassCard(
              borderRadius: 16,
              bgColor: Colors.white.withAlpha(40),
              animateOnHover: false,
              shadow: AppColors.premiumShadow,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.secondary,
                      child: Icon(Icons.support_agent, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expert Advisors",
                          style: AppTextStyles.body(11, color: Colors.white70, weight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(color: AppColors.accentGreen, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "24x7 Support",
                              style: AppTextStyles.heading(13, color: Colors.white, weight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ).animate(onPlay: (controller) => controller.repeat(reverse: true))
           .slideY(begin: 0, end: 0.1, duration: 2.2.seconds, curve: Curves.easeInOut)
           .fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildChartBar(String label, double value, String rateText, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.body(11, color: Colors.white70)),
            Text(rateText, style: AppTextStyles.body(11, color: Colors.white, weight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 6,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 6,
                  width: constraints.maxWidth * value,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
