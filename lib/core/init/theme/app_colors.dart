import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._init();
  static AppColors get instance => _instance;

  AppColors._init();

  // Brand Colors
  Color get primary => const Color(0xFFD32F2F); // Red 700
  Color get primaryLight => const Color(0xFFEF5350); // Red 400
  Color get primaryDark => const Color(0xFFB71C1C); // Red 900

  // Background Colors
  Color get backgroundDark => const Color(0xFF121212);
  Color get backgroundLight => const Color(0xFFE8ECF0); // Daha koyu bir gri-beyaz
  Color get surfaceDark => const Color(0xFF1E1E1E);
  Color get surfaceLight => const Color(0xFFDDE2E8); // Daha koyu bir surface rengi
  Color get elevatedDark => const Color(0xFF2A2A2A);
  Color get elevatedLight => const Color(0xFFD0D6DD); // Daha koyu bir elevated rengi

  // Text Colors
  Color get textPrimaryDark => const Color(0xFFF5F5F5);
  Color get textPrimaryLight => const Color(0xFF1A1F25); // Daha koyu, okunaklı bir siyah
  Color get textSecondaryDark => const Color(0xFFBDBDBD);
  Color get textSecondaryLight => const Color(0xFF2C3A47); // Daha koyu, okunaklı bir gri
  Color get textTertiaryDark => const Color(0xFF8F8F8F);
  Color get textTertiaryLight => const Color(0xFF3F4F5F); // Daha koyu bir gri

  // Input Colors
  Color get inputBackgroundDark => const Color(0xFF2A2A2A);
  Color get inputBackgroundLight => const Color(0xFFD8DEE6); // Form alanları için daha koyu background
  Color get inputBorderDark => const Color(0xFF444444);
  Color get inputBorderLight => const Color(0xFFBBC3CC); // Daha belirgin border rengi
  Color get inputHintDark => const Color(0xFFAAAAAA);
  Color get inputHintLight => const Color(0xFF6B7C8D); // Daha koyu bir hint rengi
  Color get inputFocusedDark => primary;
  Color get inputFocusedLight => primary;

  // Button Colors
  Color get buttonPrimaryDark => primary;
  Color get buttonPrimaryLight => primary;
  Color get buttonSecondaryDark => const Color(0xFF424242);
  Color get buttonSecondaryLight => const Color(0xFFBBC3CC); // Daha koyu bir secondary button rengi
  Color get buttonTextDark => Colors.white;
  Color get buttonTextLight => Colors.white;
  Color get buttonDisabledDark => const Color(0xFF424242);
  Color get buttonDisabledLight => const Color(0xFF9AA7B6); // Daha koyu bir disabled rengi

  // Icon Colors
  Color get iconPrimaryDark => const Color(0xFFE0E0E0);
  Color get iconPrimaryLight => const Color(0xFF2C3A47); // Daha koyu bir icon rengi
  Color get iconSecondaryDark => const Color(0xFFBDBDBD);
  Color get iconSecondaryLight => const Color(0xFF3F4F5F); // Daha koyu bir secondary icon rengi

  // Border Colors
  Color get borderDark => const Color(0xFF3D3D3D);
  Color get borderLight => const Color(0xFFBBC3CC); // Daha belirgin border rengi
  Color get dividerDark => const Color(0xFF2A2A2A);
  Color get dividerLight => const Color(0xFFBBC3CC); // Daha belirgin divider rengi

  // Bottom Sheet Colors
  Color get bottomSheetBackgroundDark => const Color(0xFF1C1C1E);
  Color get bottomSheetBackgroundLight => const Color(0xFFF5F5F7);
  Color get bottomSheetTextDark => Colors.white;
  Color get bottomSheetTextLight => const Color(0xFF1A1F25);

  // Status Colors
  Color get error => const Color(0xFFD32F2F);
  Color get errorLight => const Color(0xFFEF9A9A);
  Color get errorDark => const Color(0xFFC62828);
  Color get success => const Color(0xFF388E3C);
  Color get successLight => const Color(0xFFA5D6A7);
  Color get successDark => const Color(0xFF2E7D32);
  Color get warning => const Color(0xFFFFA000);
  Color get warningLight => const Color(0xFFFFCC80);
  Color get warningDark => const Color(0xFFF57C00);
  Color get info => const Color(0xFF1976D2);
  Color get infoLight => const Color(0xFF64B5F6);
  Color get infoDark => const Color(0xFF1565C0);

  // Overlay Colors
  Color get overlayDark => Colors.black.withAlpha((0.5 * 255).round());
  Color get overlayLight => Colors.black.withAlpha((0.3 * 255).round());
  Color get modalBarrierDark => Colors.black.withAlpha((0.6 * 255).round());
  Color get modalBarrierLight => Colors.black.withAlpha((0.4 * 255).round());

  // Gradient Colors
  List<Color> get gradientDark => [
        Colors.transparent,
        Colors.black.withAlpha((0.9 * 255).round()),
      ];
  List<Color> get gradientLight => [
        Colors.transparent,
        Colors.black.withAlpha((0.7 * 255).round()),
      ];

  // Social Colors
  Color get google => const Color(0xFFDB4437);
  Color get facebook => const Color(0xFF4267B2);
  Color get apple => const Color(0xFF000000);
}
