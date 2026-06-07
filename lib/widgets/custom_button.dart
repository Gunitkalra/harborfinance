import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;
  final IconData? icon;
  final double? width;
  final double height;
  final bool glowEffect;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.icon,
    this.width,
    this.height = 54.0,
    this.glowEffect = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Primary vs Secondary Button styling
    final Color buttonColor = widget.isSecondary 
        ? Colors.transparent 
        : (_isHovered ? AppColors.accentTeal : AppColors.secondary);
        
    final Color textColor = widget.isSecondary 
        ? (_isHovered ? AppColors.secondary : AppColors.textDark) 
        : Colors.white;

    final Border? border = widget.isSecondary 
        ? Border.all(
            color: _isHovered ? AppColors.secondary : AppColors.textLight.withAlpha(80), 
            width: 2,
          ) 
        : null;

    final List<BoxShadow>? shadows = (widget.glowEffect && !widget.isSecondary) 
        ? [
            BoxShadow(
              color: buttonColor.withAlpha(100),
              blurRadius: _isHovered ? 24 : 12,
              offset: const Offset(0, 4),
            )
          ]
        : null;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutBack,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(12),
              border: border,
              boxShadow: shadows,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: AppTextStyles.button(color: textColor),
                ),
                if (widget.icon != null) ...[
                  const SizedBox(width: 8),
                  AnimatedSlide(
                    offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                    duration: const Duration(milliseconds: 150),
                    child: Icon(
                      widget.icon,
                      color: textColor,
                      size: 20,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
