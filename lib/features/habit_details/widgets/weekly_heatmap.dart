import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/shared/widgets/habitly_card.dart';

/// Weekly Heatmap - Shows completion status for each day of the week
class WeeklyHeatmap extends StatelessWidget {
  final List<bool> completions; // 7 items for M-S
  final List<String> days;

  const WeeklyHeatmap({
    Key? key,
    required this.completions,
    this.days = const ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HabitlyCard(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This Week',
              style: AppTypography.labelLarge,
            ),
            const SizedBox(height: AppConstants.spacingMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                7,
                (index) => _HeatmapCell(
                  day: days[index],
                  isCompleted: index < completions.length
                      ? completions[index]
                      : false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeatmapCell extends StatelessWidget {
  final String day;
  final bool isCompleted;

  const _HeatmapCell({
    required this.day,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.success : AppColors.bgLight,
            borderRadius: BorderRadius.circular(8),
            border: isCompleted ? null : Border.all(color: AppColors.divider),
          ),
          child: isCompleted
              ? const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                )
              : null,
        ),
        const SizedBox(height: AppConstants.spacingSm),
        Text(
          day,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.textMedium,
          ),
        ),
      ],
    );
  }
}
