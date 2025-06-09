import 'package:flutter/material.dart';
import 'package:movie_app/core/init/theme/app_colors.dart';
import 'package:movie_app/features/profile/presentation/widgets/bonus_icon.dart';
import 'package:movie_app/features/profile/presentation/widgets/token_package_card.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';

class LimitedOfferBottomSheet extends StatelessWidget {
  const LimitedOfferBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.instance;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final localizations = AppLocalizations.of(context);
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? colors.bottomSheetBackgroundDark : colors.bottomSheetBackgroundLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6F060B).withAlpha((0.3 * 255).round()),
                      const Color(0xFF6F060B).withAlpha(0),
                    ],
                    stops: const [0.2, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6F060B).withAlpha((0.2 * 255).round()),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6F060B).withAlpha((0.3 * 255).round()),
                      const Color(0xFF6F060B).withAlpha(0),
                    ],
                    stops: const [0.2, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6F060B).withAlpha((0.2 * 255).round()),
                      blurRadius: 100,
                      spreadRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    localizations.translate('limitedOffer'),
                    style: TextStyle(
                      color: isDark ? colors.bottomSheetTextDark : colors.bottomSheetTextLight,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.translate('earnBonusAndUnlock'),
                    style: TextStyle(
                      color: (isDark ? colors.bottomSheetTextDark : colors.bottomSheetTextLight).withAlpha((0.7 * 255).round()),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha((0.3 * 255).round()),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: Colors.white.withAlpha((0.1 * 255).round()),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha((0.2 * 255).round()),
                          blurRadius: 16,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          localizations.translate('bonusesYouWillGet'),
                          style: TextStyle(
                            color: isDark ? colors.bottomSheetTextDark : colors.bottomSheetTextLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BonusIcon(
                              iconPath: 'assets/icons/diamon1.png',
                              label: localizations.translate('premiumAccount'),
                            ),
                            BonusIcon(
                              iconPath: 'assets/icons/hearth1.png',
                              label: localizations.translate('moreMatches'),
                            ),
                            BonusIcon(
                              iconPath: 'assets/icons/mushroom.png',
                              label: localizations.translate('promotion'),
                            ),
                            BonusIcon(
                              iconPath: 'assets/icons/hearth2.png',
                              label: localizations.translate('moreLikes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    localizations.translate('selectTokenPackage'),
                    style: TextStyle(
                      color: isDark ? colors.bottomSheetTextDark : colors.bottomSheetTextLight,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TokenPackageCard(
                          originalAmount: '200',
                          discountedAmount: '330',
                          price: '99,99',
                          discountPercentage: '10%',
                          backgroundColor: const Color(0xFF6F060B),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TokenPackageCard(
                          originalAmount: '2.000',
                          discountedAmount: '3.375',
                          price: '799,99',
                          discountPercentage: '70%',
                          backgroundColor: const Color(0xFF5949E6),
                          backgroundGradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF5949E6),
                              Color(0xFFE50914),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TokenPackageCard(
                          originalAmount: '1.000',
                          discountedAmount: '1.350',
                          price: '399,99',
                          discountPercentage: '35%',
                          backgroundColor: const Color(0xFF6F060B),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        localizations.translate('seeAllTokens'),
                        style: TextStyle(
                          color: isDark ? colors.bottomSheetTextDark : colors.bottomSheetTextLight,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 