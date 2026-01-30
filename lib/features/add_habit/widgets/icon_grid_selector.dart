import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../shared/utils/habit_icons.dart';

/// Icon Grid Selector for Habit Selection
class IconGridSelector extends StatefulWidget {
  final String? selectedIcon;
  final ValueChanged<String> onIconSelected;

  const IconGridSelector({
    Key? key,
    this.selectedIcon,
    required this.onIconSelected,
  }) : super(key: key);

  @override
  State<IconGridSelector> createState() => _IconGridSelectorState();
}

class _IconGridSelectorState extends State<IconGridSelector> {
  late String _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.selectedIcon ?? HabitIcons.icons.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose Icon',
          style: AppTypography.labelLarge,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: AppConstants.spacingMd,
            mainAxisSpacing: AppConstants.spacingMd,
          ),
          itemCount: HabitIcons.icons.length,
          itemBuilder: (context, index) {
            final iconConfig = HabitIcons.icons[index];
            final isSelected = _selectedIcon == iconConfig.id;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIcon = iconConfig.id;
                });
                widget.onIconSelected(iconConfig.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: iconConfig.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primary,
                          width: 3,
                        )
                      : null,
                ),
                child: Center(
                  child: Icon(
                    iconConfig.icon,
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
