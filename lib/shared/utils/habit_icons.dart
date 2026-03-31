import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter/material.dart';
import 'package:habitly/config/theme/app_colors.dart';

/// Habit Icon Configuration
class HabitIconConfig {
  final String id;
  final IconData icon;
  final Color backgroundColor;

  const HabitIconConfig({
    required this.id,
    required this.icon,
    required this.backgroundColor,
  });
}

/// Available icons for habits
class HabitIcons {
  static const List<HabitIconConfig> icons = [
    HabitIconConfig(
      id: 'water_drop',
      icon: PhosphorIcons.drop,
      backgroundColor: AppColors.accentBlue,
    ),
    HabitIconConfig(
      id: 'dumbbell',
      icon: PhosphorIcons.barbell, // Changed from dumbbell to barbell if needed, or check availability
      backgroundColor: AppColors.accentPurple,
    ),
    HabitIconConfig(
      id: 'book',
      icon: PhosphorIcons.book,
      backgroundColor: AppColors.accentGreen,
    ),
    HabitIconConfig(
      id: 'moon',
      icon: PhosphorIcons.moon,
      backgroundColor: AppColors.accentBlue,
    ),
    HabitIconConfig(
      id: 'fork_knife',
      icon: PhosphorIcons.fork_knife,
      backgroundColor: AppColors.accentOrange,
    ),
    HabitIconConfig(
      id: 'heart',
      icon: PhosphorIcons.heart,
      backgroundColor: AppColors.accentPink,
    ),
    HabitIconConfig(
      id: 'brain',
      icon: PhosphorIcons.brain,
      backgroundColor: AppColors.accentYellow,
    ),
    HabitIconConfig(
      id: 'music_note',
      icon: PhosphorIcons.music_note,
      backgroundColor: AppColors.accentPurple,
    ),
    HabitIconConfig(
      id: 'camera',
      icon: PhosphorIcons.camera,
      backgroundColor: AppColors.accentGreen,
    ),
    HabitIconConfig(
      id: 'pencil',
      icon: PhosphorIcons.pencil,
      backgroundColor: AppColors.accentBlue,
    ),
    HabitIconConfig(
      id: 'tree',
      icon: PhosphorIcons.tree,
      backgroundColor: AppColors.accentGreen,
    ),
    HabitIconConfig(
      id: 'plus',
      icon: PhosphorIcons.plus,
      backgroundColor: AppColors.accentOrange,
    ),
  ];

  static HabitIconConfig getIconById(String id) {
    return icons.firstWhere(
      (icon) => icon.id == id,
      orElse: () => icons.first,
    );
  }
}
