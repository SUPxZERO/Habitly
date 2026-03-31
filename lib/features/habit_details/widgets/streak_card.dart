import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/shared/widgets/habitly_card.dart';

/// Streak Card - Shows current and best streak with fire icon
class StreakCard extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
  });

  @override
  Widget build(BuildContext context) {
    return HabitlyCard(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StreakItem(
              label: 'Current Streak',
              value: currentStreak,
              icon: '🔥',
              color: AppColors.warning,
            ),
            Container(
              width: 1,
              height: 60,
              color: AppColors.divider,
            ),
            _StreakItem(
              label: 'Best Streak',
              value: bestStreak,
              icon: '⭐',
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  final String label;
  final int value;
  final String icon;
  final Color color;

  const _StreakItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(fontSize: 28),
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Text(
          '$value',
          style: AppTypography.headline1.copyWith(color: color),
        ),
        const SizedBox(height: AppConstants.spacingSm),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
