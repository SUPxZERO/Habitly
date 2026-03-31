import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/config/routes/app_routes.dart';
import 'package:habitly/shared/widgets/custom_app_bar.dart';
import 'package:habitly/shared/widgets/bottom_nav_bar.dart';
import 'package:habitly/features/calendar/widgets/month_calendar.dart';

/// Calendar Screen - Monthly calendar view of habit completions
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final int _currentNavIndex = 2; // Calendar is index 2
  late DateTime _selectedDate;
  final Set<DateTime> _completedDates = {};
  final Set<DateTime> _missedDates = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock completed dates for current month
    final now = DateTime.now();
    final completedDays = [1, 2, 4, 5, 6, 8, 9, 11, 13, 15, 16, 18];
    final missedDays = [3, 7, 10, 12, 14, 17];

    for (int day in completedDays) {
      _completedDates.add(DateTime(now.year, now.month, day));
    }
    for (int day in missedDays) {
      _missedDates.add(DateTime(now.year, now.month, day));
    }
  }

  @override
  Widget build(BuildContext context) {
    final completedToday = _completedDates.any((date) =>
        date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: const HabitlyAppBar(
        title: 'Calendar',
        showBackButton: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calendar
              MonthCalendar(
                completedDates: _completedDates,
                missedDates: _missedDates,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Legend
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Legend',
                      style: AppTypography.labelLarge,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    const Row(
                      children: [
                        _LegendItem(
                          color: AppColors.success,
                          label: 'Completed',
                        ),
                        SizedBox(width: AppConstants.spacingLg),
                        _LegendItem(
                          color: AppColors.error,
                          label: 'Missed',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Selected Date Details
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.spacingLg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(_selectedDate),
                      style: AppTypography.headline2,
                    ),
                    const SizedBox(height: AppConstants.spacingMd),
                    if (completedToday)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          AppConstants.spacingMd,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.success,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.success,
                              size: 24,
                            ),
                            const SizedBox(width: AppConstants.spacingMd),
                            Text(
                              'All habits completed today!',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          AppConstants.spacingMd,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.warning,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info,
                              color: AppColors.warning,
                              size: 24,
                            ),
                            const SizedBox(width: AppConstants.spacingMd),
                            Text(
                              'Some habits pending',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.warning,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
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
              // Already here
              break;
            case 3:
              context.pushNamed(AppRouter.profileRoute);
              break;
          }
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
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
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: AppConstants.spacingSm),
        Text(
          label,
          style: AppTypography.labelSmall,
        ),
      ],
    );
  }
}
