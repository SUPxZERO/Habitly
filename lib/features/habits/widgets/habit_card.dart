import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../models/habit_model.dart';
import '../../shared/utils/habit_icons.dart';

/// Habit Card Widget - Display individual habit in list
class HabitCard extends StatelessWidget {
  final Habit habit;
  final bool isCompleted;
  final VoidCallback? onTap;
  final VoidCallback? onCheckTap;

  const HabitCard({
    Key? key,
    required this.habit,
    required this.isCompleted,
    this.onTap,
    this.onCheckTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconConfig = HabitIcons.getIconById(habit.icon);
    final completedColor = isCompleted ? AppColors.success : AppColors.textLight;

    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Row(
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: iconConfig?.backgroundColor ?? AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    iconConfig?.icon ?? Icons.star_outline,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: AppTypography.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          habit.frequency,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (habit.goalType == 'Count') ...[
                          Text(
                            '${habit.targetCount ?? 0} ${habit.targetCount == 1 ? 'time' : 'times'}',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textLight,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.spacingMd),
              // Completion Checkbox & Streak
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: onCheckTap,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: completedColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                        color: isCompleted ? completedColor : Colors.transparent,
                      ),
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${habit.currentStreak}d',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textMedium,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
