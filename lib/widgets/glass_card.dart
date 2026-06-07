import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final double blur;
  final Color bordercolor;
  final Color bgColor;
  final List<BoxShadow>? shadow;
  final bool animateOnHover;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.blur = 20.0,
    this.bordercolor = Colors.white24,
    this.bgColor = const Color(0x0AFFFFFF),
    this.shadow,
    this.animateOnHover = true,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Widget cardContent = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
        child: Container(
          decoration: BoxDecoration(
            color: _isHovered && widget.animateOnHover
                ? widget.bgColor.withAlpha(50) // Brighter on hover
                : widget.bgColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered && widget.animateOnHover
                  ? widget.bordercolor.withAlpha(150)
                  : widget.bordercolor,
              width: 1.5,
            ),
            boxShadow: widget.shadow,
          ),
          child: widget.child,
        ),
      ),
    );

    if (widget.animateOnHover) {
      return MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: cardContent,
          ),
        ),
      );
    }

    return cardContent;
  }
}
