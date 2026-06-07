import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../models/landing_models.dart';
import '../services/dummy_data.dart';
import '../utils/responsive.dart';

class InteractiveTimeline extends StatefulWidget {
  const InteractiveTimeline({super.key});

  @override
  State<InteractiveTimeline> createState() => _InteractiveTimelineState();
}

class _InteractiveTimelineState extends State<InteractiveTimeline> {
  int _activeStepIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);
    final List<TimelineStepModel> steps = DummyData.timelineSteps;

    return Column(
      children: [
        // Timeline Header/Navigator
        if (isMobile)
          _buildVerticalTimeline(steps)
        else
          _buildHorizontalTimeline(steps),
        
        const SizedBox(height: 32),
        
        // Active Step Detail View (Glassmorphism card)
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.secondary.withAlpha(25),
              width: 1.5,
            ),
            boxShadow: AppColors.premiumShadow,
          ),
          padding: const EdgeInsets.all(28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.secondary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  steps[_activeStepIndex].icon,
                  color: AppColors.secondary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "STEP ${steps[_activeStepIndex].stepNumber}",
                          style: AppTextStyles.body(12, color: AppColors.secondary, weight: FontWeight.w800),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: AppColors.textLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Direct Approval Path",
                          style: AppTextStyles.body(12, color: AppColors.textLight, weight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      steps[_activeStepIndex].title,
                      style: AppTextStyles.heading(22, color: AppColors.textDark),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      steps[_activeStepIndex].description,
                      style: AppTextStyles.body(15, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate(key: ValueKey(_activeStepIndex))
            .fadeIn(duration: 350.ms)
            .slideY(begin: 0.1, end: 0.0, curve: Curves.easeOutQuad),
      ],
    );
  }

  Widget _buildHorizontalTimeline(List<TimelineStepModel> steps) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final step = steps[index];
          final bool isActive = _activeStepIndex == index;
          final bool isPassed = index < _activeStepIndex;

          return Expanded(
            child: Row(
              children: [
                // Node
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => _activeStepIndex = index),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: isActive ? 60 : 48,
                          height: isActive ? 60 : 48,
                          decoration: BoxDecoration(
                            color: isActive 
                                ? AppColors.secondary 
                                : (isPassed ? AppColors.accentGreen : Colors.white),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive 
                                  ? AppColors.secondary 
                                  : (isPassed ? AppColors.accentGreen : AppColors.textMuted.withAlpha(100)),
                              width: 3,
                            ),
                            boxShadow: isActive ? AppColors.glowShadow : null,
                          ),
                          alignment: Alignment.center,
                          child: isPassed
                              ? const Icon(Icons.check, color: Colors.white, size: 20)
                              : Text(
                                  step.stepNumber,
                                  style: AppTextStyles.heading(
                                    isActive ? 18 : 16,
                                    color: isActive ? Colors.white : AppColors.textLight,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          step.title,
                          style: AppTextStyles.heading(
                            13,
                            color: isActive ? AppColors.textDark : AppColors.textLight,
                            weight: isActive ? FontWeight.bold : FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                // Connector line (except for last node)
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 3,
                      color: isPassed 
                          ? AppColors.accentGreen 
                          : AppColors.textMuted.withAlpha(50),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildVerticalTimeline(List<TimelineStepModel> steps) {
    return Column(
      children: List.generate(steps.length, (index) {
        final step = steps[index];
        final bool isActive = _activeStepIndex == index;
        final bool isPassed = index < _activeStepIndex;

        return InkWell(
          onTap: () => setState(() => _activeStepIndex = index),
          hoverColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: isActive ? 48 : 38,
                      height: isActive ? 48 : 38,
                      decoration: BoxDecoration(
                        color: isActive 
                            ? AppColors.secondary 
                            : (isPassed ? AppColors.accentGreen : Colors.white),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive 
                              ? AppColors.secondary 
                              : (isPassed ? AppColors.accentGreen : AppColors.textMuted.withAlpha(100)),
                          width: 2.5,
                        ),
                        boxShadow: isActive ? AppColors.glowShadow : null,
                      ),
                      alignment: Alignment.center,
                      child: isPassed
                          ? const Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              step.stepNumber,
                              style: AppTextStyles.heading(
                                isActive ? 16 : 14,
                                color: isActive ? Colors.white : AppColors.textLight,
                                weight: FontWeight.bold,
                              ),
                            ),
                    ),
                    if (index < steps.length - 1)
                      Container(
                        width: 2,
                        height: 24,
                        color: isPassed 
                            ? AppColors.accentGreen 
                            : AppColors.textMuted.withAlpha(50),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: AppTextStyles.heading(
                          16,
                          color: isActive ? AppColors.secondary : AppColors.textDark,
                          weight: isActive ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                      if (isActive) ...[
                        const SizedBox(height: 4),
                        Text(
                          step.description,
                          style: AppTextStyles.body(13, color: AppColors.textLight),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
