import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/dummy_data.dart';

class LogoCarousel extends StatefulWidget {
  const LogoCarousel({super.key});

  @override
  State<LogoCarousel> createState() => _LogoCarouselState();
}

class _LogoCarouselState extends State<LogoCarousel> {
  late final ScrollController _scrollController;
  Timer? _timer;
  double _scrollSpeed = 1.0; // pixels per frame/timer tick

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Start auto-scroll after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!_scrollController.hasClients) return;

      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double currentScroll = _scrollController.offset;
      
      // Infinite loop mechanism:
      // If we reach near the end of the cloned list, reset back to 0 seamlessly
      if (currentScroll >= maxScroll - 2) {
        _scrollController.jumpTo(0.0);
      } else {
        _scrollController.jumpTo(currentScroll + _scrollSpeed);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Duplicate the logos list multiple times to ensure seamless infinite scrolling
    final List<String> tripleList = [
      ...DummyData.partnerLogos,
      ...DummyData.partnerLogos,
      ...DummyData.partnerLogos,
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _scrollSpeed = 0.2), // slow down on hover
      onExit: (_) => setState(() => _scrollSpeed = 1.0),  // speed back up
      child: SizedBox(
        height: 70,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(), // Handled by auto scroll
          itemCount: tripleList.length,
          itemBuilder: (context, index) {
            final logoName = tripleList[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.textLight.withAlpha(25),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // A mock colorful bank icon
                    Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance,
                        size: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      logoName,
                      style: AppTextStyles.body(14, color: AppColors.textDark, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
