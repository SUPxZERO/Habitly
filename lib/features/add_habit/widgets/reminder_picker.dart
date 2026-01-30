import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';

/// Reminder Picker Widget
class ReminderPicker extends StatefulWidget {
  final String? reminderTime;
  final ValueChanged<String?> onReminderChanged;
  final bool remindersEnabled;
  final ValueChanged<bool> onRemindersEnabledChanged;

  const ReminderPicker({
    Key? key,
    this.reminderTime,
    required this.onReminderChanged,
    this.remindersEnabled = false,
    required this.onRemindersEnabledChanged,
  }) : super(key: key);

  @override
  State<ReminderPicker> createState() => _ReminderPickerState();
}

class _ReminderPickerState extends State<ReminderPicker> {
  late bool _remindersEnabled;
  late String _reminderTime;

  @override
  void initState() {
    super.initState();
    _remindersEnabled = widget.remindersEnabled;
    _reminderTime = widget.reminderTime ?? '09:00';
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_reminderTime.split(':')[0]),
        minute: int.parse(_reminderTime.split(':')[1]),
      ),
    );

    if (picked != null) {
      final formattedTime =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      setState(() {
        _reminderTime = formattedTime;
      });
      widget.onReminderChanged(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Reminder (Optional)',
              style: AppTypography.labelLarge,
            ),
            Switch(
              value: _remindersEnabled,
              activeColor: AppColors.secondary,
              onChanged: (value) {
                setState(() {
                  _remindersEnabled = value;
                });
                widget.onRemindersEnabledChanged(value);
                if (!value) {
                  widget.onReminderChanged(null);
                }
              },
            ),
          ],
        ),
        if (_remindersEnabled) ...[
          const SizedBox(height: AppConstants.spacingMd),
          GestureDetector(
            onTap: _pickTime,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingMd,
                vertical: AppConstants.spacingMd,
              ),
              decoration: BoxDecoration(
                color: AppColors.bgLight,
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _reminderTime,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),
                  const Icon(
                    Icons.access_time,
                    color: AppColors.textMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
