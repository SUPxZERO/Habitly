import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../config/routes/app_routes.dart';
import '../../shared/widgets/habitly_card.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../provider/habits_provider.dart';
import '../widgets/habit_card.dart';
import '../models/habit_model.dart';

/// Home Screen - Today's habits and progress
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize mock habits on first load
    Future.microtask(() {
      context.read<HabitsProvider>().initializeMockHabits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date and Title
                    Text(
                      'Today',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getFormattedDate(),
                      style: AppTypography.headline3,
                    ),
                  ],
                ),
              ),
              // Today's Progress Card
              Consumer<HabitsProvider>(
                builder: (context, habitsProvider, _) {
                  final progress = habitsProvider.getTodayProgress();
                  final completedCount = habitsProvider.getTodayCompletedHabits().length;
                  final totalCount = habitsProvider.habits.length;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacingLg,
                    ),
                    child: HabitlyCard(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.all(AppConstants.spacingLg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Progress",
                                style: AppTypography.title,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${progress.toStringAsFixed(0)}%',
                                  style: AppTypography.labelLarge.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.spacingMd),
                          Text(
                            '$completedCount/$totalCount completed',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textMedium,
                            ),
                          ),
                          const SizedBox(height: AppConstants.spacingMd),
                          // Progress Bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: progress / 100,
                              minHeight: 8,
                              backgroundColor: AppColors.bgLight,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: AppConstants.spacingXl),
              // Your Habits Section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Habits',
                          style: AppTypography.headline4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: AppColors.textLight,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                  ],
                ),
              ),
              // Habits List
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingLg,
                ),
                child: Consumer<HabitsProvider>(
                  builder: (context, habitsProvider, _) {
                    if (habitsProvider.habits.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppConstants.spacingXl),
                          child: Text(
                            'No habits yet. Create your first habit!',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textMedium,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(
                        habitsProvider.habits.length,
                        (index) {
                          final habit = habitsProvider.habits[index];
                          final isCompleted =
                              habitsProvider.isCompletedToday(habit.id);

                          return HabitCard(
                            habit: habit,
                            isCompleted: isCompleted,
                            onCheckTap: () {
                              habitsProvider.toggleHabitCompletion(habit.id);
                            },
                            onTap: () {
                              // TODO: Navigate to habit details
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppConstants.spacingXl),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AppRouter.addHabitRoute);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: HabitlyBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          // TODO: Navigate to different tabs
        },
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    final day = days[now.weekday - 1];
    final date = now.day;
    final month = months[now.month - 1];

    return '$day, $month $date';
  }
}
