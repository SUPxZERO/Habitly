import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/config/routes/app_routes.dart';
import 'package:habitly/shared/widgets/custom_app_bar.dart';
import 'package:habitly/shared/widgets/bottom_nav_bar.dart';
import 'package:habitly/features/profile/widgets/profile_widgets.dart';

/// Profile Screen - User profile and statistics
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final int _currentNavIndex = 3; // Profile is index 3
  final int _dayStreak = 127;
  final int _completedCount = 842;
  final int _bestStreak = 24;
  final int _completionRate = 89;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: HabitlyAppBar(
        title: 'Profile',
        showBackButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.spacingMd),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(AppRouter.settingsRoute);
                },
                child: const Icon(Icons.settings_outlined),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              const ProfileHeader(
                name: 'Alex Johnson',
                username: 'alexjohn',
                avatarUrl: 'https://example.com/avatar.jpg',
                quote: 'Build better habits, one day at a time',
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Statistics Grid
              const Text(
                'Your Statistics',
                style: AppTypography.headline2,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              StatisticsGrid(
                dayStreak: _dayStreak,
                completedCount: _completedCount,
                bestStreak: _bestStreak,
                completionRate: _completionRate,
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Achievements Section
              const Text(
                'Achievements',
                style: AppTypography.headline2,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _buildAchievementItem(
                icon: '🥇',
                title: 'First Habit',
                description: 'Created your first habit',
                isUnlocked: true,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _buildAchievementItem(
                icon: '🔥',
                title: '7-Day Streak',
                description: 'Completed a habit 7 days in a row',
                isUnlocked: true,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              _buildAchievementItem(
                icon: '💯',
                title: 'Perfect Week',
                description: 'Completed all habits for a week',
                isUnlocked: false,
              ),
              const SizedBox(height: AppConstants.spacingXl),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HabitlyBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          // Navigate to different tabs
          switch (index) {
            case 0:
              context.pushNamed(AppRouter.homeRoute);
              break;
            case 1:
              context.pushNamed(AppRouter.habitsRoute);
              break;
            case 2:
              context.pushNamed(AppRouter.calendarRoute);
              break;
            case 3:
              // Already here
              break;
          }
        },
      ),
    );
  }

  Widget _buildAchievementItem({
    required String icon,
    required String title,
    required String description,
    required bool isUnlocked,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: isUnlocked
            ? AppColors.primary.withOpacity(0.1)
            : AppColors.bgLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked ? AppColors.primary : AppColors.divider,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: AppConstants.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelLarge.copyWith(
                    color: isUnlocked ? AppColors.textDark : AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  description,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 24,
            )
          else
            const Icon(
              Icons.lock,
              color: AppColors.textLight,
              size: 24,
            ),
        ],
      ),
    );
  }
}
