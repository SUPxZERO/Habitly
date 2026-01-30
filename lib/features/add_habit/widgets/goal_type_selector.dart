import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';

/// Goal Type Selector - Yes/No or Count based
class GoalTypeSelector extends StatefulWidget {
  final String? selectedGoalType;
  final ValueChanged<String> onGoalTypeChanged;
  final int? targetCount;
  final ValueChanged<int?>? onTargetCountChanged;

  const GoalTypeSelector({
    Key? key,
    this.selectedGoalType,
    required this.onGoalTypeChanged,
    this.targetCount,
    this.onTargetCountChanged,
  }) : super(key: key);

  @override
  State<GoalTypeSelector> createState() => _GoalTypeSelectorState();
}

class _GoalTypeSelectorState extends State<GoalTypeSelector> {
  late String _selectedGoalType;
  late TextEditingController _countController;

  @override
  void initState() {
    super.initState();
    _selectedGoalType = widget.selectedGoalType ?? 'Yes/No';
    _countController = TextEditingController(
      text: widget.targetCount?.toString() ?? '1',
    );
  }

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Goal Type',
          style: AppTypography.labelLarge,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Row(
          children: [
            Expanded(
              child: _buildGoalTypeButton('Yes/No'),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: _buildGoalTypeButton('Count'),
            ),
          ],
        ),
        if (_selectedGoalType == 'Count') ...[
          const SizedBox(height: AppConstants.spacingLg),
          Text(
            'Target Count',
            style: AppTypography.labelLarge,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          TextField(
            controller: _countController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final count = int.tryParse(value) ?? 1;
              widget.onTargetCountChanged?.call(count);
            },
            decoration: InputDecoration(
              hintText: 'e.g. 8 (for 8 glasses of water)',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
                vertical: AppConstants.spacingMd,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGoalTypeButton(String goalType) {
    final isSelected = _selectedGoalType == goalType;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGoalType = goalType;
        });
        widget.onGoalTypeChanged(goalType);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            goalType,
            style: AppTypography.labelLarge.copyWith(
              color: isSelected ? Colors.white : AppColors.textMedium,
            ),
          ),
        ),
      ),
    );
  }
}
