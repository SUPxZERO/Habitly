import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/shared/widgets/habitly_card.dart';

/// Statistics Grid - Shows 4 key statistics cards
class StatisticsGrid extends StatelessWidget {
  final int dayStreak;
  final int completedCount;
  final int bestStreak;
  final int completionRate;

  const StatisticsGrid({
    Key? key,
    required this.dayStreak,
    required this.completedCount,
    required this.bestStreak,
    required this.completionRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppConstants.spacingMd,
      mainAxisSpacing: AppConstants.spacingMd,
      children: [
        _StatisticCard(
          icon: '🔥',
          label: 'Day Streak',
          value: dayStreak,
          color: AppColors.warning,
        ),
        _StatisticCard(
          icon: '✅',
          label: 'Completed',
          value: completedCount,
          color: AppColors.success,
        ),
        _StatisticCard(
          icon: '⭐',
          label: 'Best Streak',
          value: bestStreak,
          color: AppColors.primary,
        ),
        _StatisticCard(
          icon: '📊',
          label: 'Completion %',
          value: completionRate,
          color: AppColors.secondary,
          isSuffix: true,
        ),
      ],
    );
  }
}

class _StatisticCard extends StatelessWidget {
  final String icon;
  final String label;
  final int value;
  final Color color;
  final bool isSuffix;

  const _StatisticCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.isSuffix = false,
  });

  @override
  Widget build(BuildContext context) {
    return HabitlyCard(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$value${isSuffix ? '%' : ''}',
                  style: AppTypography.headline2.copyWith(color: color),
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  label,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Profile Header - User info section
class ProfileHeader extends StatelessWidget {
  final String name;
  final String username;
  final String avatarUrl;
  final String quote;

  const ProfileHeader({
    Key? key,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.quote,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  _getInitials(name),
                  style: AppTypography.headline1.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            // User Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTypography.headline2,
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    '@$username',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingLg),
        // Quote
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            '💭 "$quote"',
            style: AppTypography.bodySmall.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  String _getInitials(String name) {
    return name
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map((part) => part[0])
        .take(2)
        .join()
        .toUpperCase();
  }
}
