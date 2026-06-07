import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF0F172A); // Deep Slate Blue
  static const Color secondary = Color(0xFF2563EB); // Electric Indigo Blue
  static const Color accentTeal = Color(0xFF0D9488); // Safe Emerald/Teal
  static const Color accentGreen = Color(0xFF10B981); // Success Green
  static const Color accentGold = Color(0xFFF59E0B); // Gold/Orange for warning/rating
  static const Color bgLight = Color(0xFFF8FAFC); // Very light slate/white
  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textLight = Color(0xFF64748B); // Slate Grey
  static const Color textMuted = Color(0xFF94A3B8); // Muted Grey
  
  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF2563EB), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient heroGradient = LinearGradient(
    colors: [Color(0xFF0F172A), Color(0xFF1E1B4B)], // Slate to Indigo Dark
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient accentGradient = LinearGradient(
    colors: [Color(0xFF0D9488), Color(0xFF10B981)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient glassGradient = LinearGradient(
    colors: [Colors.white24, Colors.white10],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient cardGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8FAFC)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shadows
  static List<BoxShadow> premiumShadow = [
    BoxShadow(
      color: const Color(0xFF0F172A).withAlpha(15),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
    BoxShadow(
      color: const Color(0xFF0F172A).withAlpha(10),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> glowShadow = [
    BoxShadow(
      color: const Color(0xFF2563EB).withAlpha(60),
      blurRadius: 20,
      offset: const Offset(0, 4),
    ),
  ];
}

class AppTextStyles {
  static TextStyle display(double size, {Color color = AppColors.textDark, FontWeight weight = FontWeight.bold}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.2,
    );
  }

  static TextStyle heading(double size, {Color color = AppColors.textDark, FontWeight weight = FontWeight.w600}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.3,
    );
  }

  static TextStyle body(double size, {Color color = AppColors.textLight, FontWeight weight = FontWeight.normal}) {
    return GoogleFonts.outfit(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.5,
    );
  }

  static TextStyle button({Color color = Colors.white}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
      letterSpacing: 0.5,
    );
  }
}
