import 'package:flutter/material.dart';
import 'package:movie_app/core/init/lang/app_localizations.dart';

class TokenPackageCard extends StatelessWidget {
  final String originalAmount;
  final String discountedAmount;
  final String price;
  final String discountPercentage;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final VoidCallback onTap;

  const TokenPackageCard({
    super.key,
    required this.originalAmount,
    required this.discountedAmount,
    required this.price,
    required this.discountPercentage,
    required this.backgroundColor,
    this.backgroundGradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: backgroundGradient,
              color: backgroundGradient == null ? backgroundColor : null,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withAlpha((0.2 * 255).round()),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withAlpha((0.1 * 255).round()),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Text(
                  originalAmount,
                  style: TextStyle(
                    color: Colors.white.withAlpha((0.7 * 255).round()),
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  discountedAmount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  localizations.translate('token'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '₺$price',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  localizations.translate('perWeek'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  gradient: backgroundGradient,
                  color: backgroundGradient == null ? backgroundColor : null,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withAlpha((0.2 * 255).round()),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withAlpha((0.1 * 255).round()),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Text(
                  '+$discountPercentage',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 