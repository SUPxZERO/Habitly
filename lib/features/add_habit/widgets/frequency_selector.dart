import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';

/// Frequency Selector - Daily or Weekly
class FrequencySelector extends StatefulWidget {
  final String? selectedFrequency;
  final ValueChanged<String> onFrequencyChanged;

  const FrequencySelector({
    Key? key,
    this.selectedFrequency,
    required this.onFrequencyChanged,
  }) : super(key: key);

  @override
  State<FrequencySelector> createState() => _FrequencySelectorState();
}

class _FrequencySelectorState extends State<FrequencySelector> {
  late String _selectedFrequency;

  @override
  void initState() {
    super.initState();
    _selectedFrequency = widget.selectedFrequency ?? 'Daily';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Frequency',
          style: AppTypography.labelLarge,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Row(
          children: [
            Expanded(
              child: _buildFrequencyButton('Daily'),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            Expanded(
              child: _buildFrequencyButton('Weekly'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFrequencyButton(String frequency) {
    final isSelected = _selectedFrequency == frequency;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFrequency = frequency;
        });
        widget.onFrequencyChanged(frequency);
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
            frequency,
            style: AppTypography.labelLarge.copyWith(
              color: isSelected ? Colors.white : AppColors.textMedium,
            ),
          ),
        ),
      ),
    );
  }
}
