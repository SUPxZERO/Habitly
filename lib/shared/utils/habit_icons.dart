import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

/// Habit Icon Configuration
class HabitIconConfig {
  final String id;
  final IconData icon;
  final Color backgroundColor;

  HabitIconConfig({
    required this.id,
    required this.icon,
    required this.backgroundColor,
  });
}

/// Available icons for habits
class HabitIcons {
  static final List<HabitIconConfig> icons = [
    HabitIconConfig(
      id: 'water_drop',
      icon: PhosphorIcons.drop,
      backgroundColor: AppColors.secondaryLight,
    ),
    HabitIconConfig(
      id: 'dumbbell',
      icon: PhosphorIcons.dumbbell,
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
      icon: PhosphorIcons.note,
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
      backgroundColor: AppColors.secondaryLight,
    ),
    HabitIconConfig(
      id: 'plus',
      icon: PhosphorIcons.plus,
      backgroundColor: AppColors.accentOrange,
    ),
  ];

  static HabitIconConfig? getIconById(String id) {
    try {
      return icons.firstWhere((icon) => icon.id == id);
    } catch (e) {
      return icons.first; // Return first as default
    }
  }
}
