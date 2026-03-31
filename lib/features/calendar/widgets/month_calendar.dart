import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';

/// Month Calendar - Interactive month view with navigation
class MonthCalendar extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Set<DateTime> completedDates;
  final Set<DateTime> missedDates;

  const MonthCalendar({
    Key? key,
    required this.onDateSelected,
    this.completedDates = const {},
    this.missedDates = const {},
  }) : super(key: key);

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth =
          DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth =
          DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Month/Year Header
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
            vertical: AppConstants.spacingMd,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: _previousMonth,
                icon: const Icon(Icons.chevron_left),
                color: AppColors.primary,
              ),
              Text(
                _getMonthYear(_currentMonth),
                style: AppTypography.headline2,
              ),
              IconButton(
                onPressed: _nextMonth,
                icon: const Icon(Icons.chevron_right),
                color: AppColors.primary,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Weekday Labels
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _WeekdayLabel('Mon'),
              _WeekdayLabel('Tue'),
              _WeekdayLabel('Wed'),
              _WeekdayLabel('Thu'),
              _WeekdayLabel('Fri'),
              _WeekdayLabel('Sat'),
              _WeekdayLabel('Sun'),
            ],
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Calendar Grid
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingLg,
          ),
          child: _buildCalendarGrid(),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday;

    final weeks = <List<DateTime>>[];
    var currentWeek = <DateTime>[];

    // Add empty slots for offset (from previous month)
    for (int i = 1; i < firstWeekday; i++) {
      currentWeek.add(firstDay.subtract(Duration(days: firstWeekday - i)));
    }

    // Add days of month
    for (int day = 1; day <= daysInMonth; day++) {
      currentWeek.add(DateTime(_currentMonth.year, _currentMonth.month, day));

      if (currentWeek.length == 7) {
        weeks.add(currentWeek);
        currentWeek = [];
      }
    }

    // Add remaining slots (from next month)
    if (currentWeek.isNotEmpty) {
      final daysToAdd = 7 - currentWeek.length;
      for (int i = 1; i <= daysToAdd; i++) {
        currentWeek.add(lastDay.add(Duration(days: i)));
      }
      weeks.add(currentWeek);
    }

    return Column(
      children: weeks.map((week) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: week
              .map((date) => _CalendarDay(
                    date: date,
                    isCurrentMonth: date.month == _currentMonth.month,
                    isCompleted:
                        widget.completedDates.any((d) => _isSameDay(d, date)),
                    isMissed:
                        widget.missedDates.any((d) => _isSameDay(d, date)),
                    onTap: () {
                      widget.onDateSelected(date);
                    },
                  ))
              .toList(),
        );
      }).toList(),
    );
  }

  String _getMonthYear(DateTime date) {
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
    return '${months[date.month - 1]} ${date.year}';
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

class _WeekdayLabel extends StatelessWidget {
  final String label;

  const _WeekdayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.labelSmall.copyWith(
        color: AppColors.textMedium,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final DateTime date;
  final bool isCurrentMonth;
  final bool isCompleted;
  final bool isMissed;
  final VoidCallback onTap;

  const _CalendarDay({
    required this.date,
    required this.isCurrentMonth,
    required this.isCompleted,
    required this.isMissed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = AppColors.bgLight;
    Color textColor = AppColors.textDark;

    if (!isCurrentMonth) {
      textColor = AppColors.textLight;
      backgroundColor = AppColors.bgLight.withOpacity(0.5);
    } else if (isCompleted) {
      backgroundColor = AppColors.success;
      textColor = Colors.white;
    } else if (isMissed) {
      backgroundColor = AppColors.error.withOpacity(0.2);
      textColor = AppColors.error;
    }

    final isToday = _isSameDay(date, DateTime.now());

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: isToday && isCurrentMonth
              ? Border.all(color: AppColors.primary, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            date.day.toString(),
            style: AppTypography.labelSmall.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
