import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CounterWidget extends StatefulWidget {
  final int targetValue;
  final String suffix;
  final String prefix;
  final String label;
  final Duration duration;

  const CounterWidget({
    super.key,
    required this.targetValue,
    this.suffix = "",
    this.prefix = "",
    required this.label,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.targetValue.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Automatically start the animation
    // Ideally this triggers when visible on screen. We can trigger it on build
    // or when the widget is scrolled into view.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Format value: if it has a comma or plus, format nicely.
        final int value = _animation.value.toInt();
        final String formattedValue = _formatNumber(value);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${widget.prefix}$formattedValue${widget.suffix}",
              style: AppTextStyles.display(40, color: AppColors.secondary, weight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              style: AppTextStyles.body(14, color: AppColors.textLight, weight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return "${(number / 1000000).toStringAsFixed(1)}M";
    } else if (number >= 1000) {
      // Add thousands commas
      final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      return number.toString().replaceAllMapped(reg, (match) => '${match[1]},');
    }
    return number.toString();
  }
}
