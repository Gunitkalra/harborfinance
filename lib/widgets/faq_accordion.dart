import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/landing_models.dart';

class FaqAccordionItem extends StatefulWidget {
  final FaqModel faq;
  final bool isExpanded;
  final VoidCallback onTap;

  const FaqAccordionItem({
    super.key,
    required this.faq,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<FaqAccordionItem> createState() => _FaqAccordionItemState();
}

class _FaqAccordionItemState extends State<FaqAccordionItem> with SingleTickerProviderStateMixin {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: widget.isExpanded ? Colors.white : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isExpanded 
                  ? AppColors.secondary.withAlpha(50) 
                  : (_isHovered ? AppColors.textLight.withAlpha(60) : AppColors.textLight.withAlpha(20)),
              width: 1.5,
            ),
            boxShadow: widget.isExpanded ? AppColors.premiumShadow : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.faq.question,
                        style: AppTextStyles.heading(
                          16,
                          color: widget.isExpanded ? AppColors.secondary : AppColors.textDark,
                          weight: widget.isExpanded ? FontWeight.bold : FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    AnimatedRotation(
                      turns: widget.isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.isExpanded ? AppColors.secondary : AppColors.textLight,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              // Answer Content with Animated Size/Fade transition
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity, height: 0),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
                  child: Text(
                    widget.faq.answer,
                    style: AppTextStyles.body(15, color: AppColors.textLight),
                  ),
                ),
                crossFadeState: widget.isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
                sizeCurve: Curves.easeInOutCubic,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
