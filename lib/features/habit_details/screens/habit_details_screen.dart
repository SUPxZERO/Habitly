import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/config/routes/app_routes.dart';
import 'package:habitly/shared/widgets/custom_app_bar.dart';
import 'package:habitly/shared/widgets/primary_button.dart';
import 'package:habitly/shared/widgets/progress_ring.dart';
import 'package:habitly/features/habits/models/habit_model.dart';
import 'package:habitly/features/habit_details/widgets/streak_card.dart';
import 'package:habitly/features/habit_details/widgets/weekly_heatmap.dart';

/// Habit Details Screen - Shows detailed view of a single habit
class HabitDetailsScreen extends StatefulWidget {
  final Habit habit;

  const HabitDetailsScreen({
    super.key,
    required this.habit,
  });

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailsScreenState();
}

class _HabitDetailsScreenState extends State<HabitDetailsScreen> {
  late int _currentStreak;
  late int _bestStreak;
  late List<bool> _weeklyCompletions;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Calculate current streak (mock data)
    _currentStreak = widget.habit.currentStreak;
    _bestStreak = 24;

    // Mock weekly completions for this week
    _weeklyCompletions = [true, true, false, true, true, true, false];
  }

  @override
  Widget build(BuildContext context) {
    const double progress = 0.75; // Example: 75% complete this week

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: HabitlyAppBar(
        title: widget.habit.name,
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Habit Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.getPastelColor(widget.habit.icon).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check_circle,
                          color: AppColors.getPastelColor(widget.habit.icon),
                          size: 48,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      widget.habit.name,
                      style: AppTypography.headline1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppConstants.spacingSm),
                    Text(
                      '${widget.habit.frequency} Habit',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Progress Ring
              const Center(
                child: ProgressRing(
                  progress: progress,
                  size: 200,
                  progressColor: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Streak Card
              StreakCard(
                currentStreak: _currentStreak,
                bestStreak: _bestStreak,
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Weekly Heatmap
              WeeklyHeatmap(
                completions: _weeklyCompletions,
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Description
              const Text(
                'About this habit',
                style: AppTypography.labelLarge,
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Text(
                widget.habit.frequency == 'Daily'
                    ? 'You commit to this habit every day. Stay consistent to build a strong routine!'
                    : 'You commit to this habit weekly. Choose the best days to practice.',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Goal Information
              if (widget.habit.goalType == 'Count')
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Daily Goal',
                      style: AppTypography.labelLarge,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    Text(
                      '${widget.habit.targetCount} ${_getGoalUnit(widget.habit.name)}',
                      style: AppTypography.headline2,
                    ),
                    const SizedBox(height: AppConstants.spacingXl),
                  ],
                ),

              // Action Buttons
              PrimaryButton(
                label: 'Edit Habit',
                onPressed: () {
                  context.pushNamed(
                    AppRouter.editHabitRoute,
                    pathParameters: {'id': widget.habit.id},
                  );
                },
              ),
              const SizedBox(height: AppConstants.spacingMd),
            ],
          ),
        ),
      ),
    );
  }

  String _getGoalUnit(String habitName) {
    final name = habitName.toLowerCase();
    if (name.contains('water')) return 'glasses';
    if (name.contains('read')) return 'minutes';
    if (name.contains('exercise')) return 'minutes';
    if (name.contains('sleep')) return 'hours';
    return 'units';
  }
}
