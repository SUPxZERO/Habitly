import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';

/// Custom App Bar for Habitly
class HabitlyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double elevation;
  final TextStyle? titleStyle;
  final bool centerTitle;

  const HabitlyAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.elevation = 0,
    this.titleStyle,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: titleStyle ?? AppTypography.headline3,
      ),
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.bgWhite,
      elevation: elevation,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textDark,
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      iconTheme: const IconThemeData(color: AppColors.textDark),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
