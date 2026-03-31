import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';

/// Onboarding slide widget
class OnboardingSlideWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingSlideWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 64,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: AppTypography.headline1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
