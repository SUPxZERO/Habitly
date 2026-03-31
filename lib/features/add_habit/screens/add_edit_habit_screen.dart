import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/shared/widgets/primary_button.dart';
import 'package:habitly/shared/widgets/custom_app_bar.dart';
import 'package:habitly/features/habits/models/habit_model.dart';
import 'package:habitly/features/habits/provider/habits_provider.dart';
import 'package:habitly/features/habits/validators/habit_validators.dart';
import 'package:habitly/features/add_habit/widgets/icon_grid_selector.dart';
import 'package:habitly/features/add_habit/widgets/frequency_selector.dart';
import 'package:habitly/features/add_habit/widgets/goal_type_selector.dart';
import 'package:habitly/features/add_habit/widgets/reminder_picker.dart';

/// Add/Edit Habit Screen
class AddEditHabitScreen extends StatefulWidget {
  final Habit? habit;

  const AddEditHabitScreen({super.key, this.habit});

  @override
  State<AddEditHabitScreen> createState() => _AddEditHabitScreenState();
}

class _AddEditHabitScreenState extends State<AddEditHabitScreen> {
  late TextEditingController _nameController;
  late String _selectedIcon;
  late String _selectedFrequency;
  late String _selectedGoalType;
  late int? _targetCount;
  late String? _reminderTime;
  late bool _remindersEnabled;

  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.habit != null;

    _nameController = TextEditingController(text: widget.habit?.name ?? '');
    _selectedIcon = widget.habit?.icon ?? 'water_drop';
    _selectedFrequency = widget.habit?.frequency ?? 'Daily';
    _selectedGoalType = widget.habit?.goalType ?? 'Yes/No';
    _targetCount = widget.habit?.targetCount;
    _reminderTime = widget.habit?.reminderTime;
    _remindersEnabled = widget.habit?.remindersEnabled ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (_formKey.currentState!.validate()) {
      final habitsProvider = context.read<HabitsProvider>();

      final habit = Habit(
        id: widget.habit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        icon: _selectedIcon,
        frequency: _selectedFrequency,
        goalType: _selectedGoalType,
        targetCount: _selectedGoalType == 'Count' ? _targetCount : null,
        reminderTime: _remindersEnabled ? _reminderTime : null,
        remindersEnabled: _remindersEnabled,
        createdAt: widget.habit?.createdAt ?? DateTime.now(),
      );

      bool success;
      if (_isEditing) {
        success = await habitsProvider.updateHabit(habit);
      } else {
        success = await habitsProvider.addHabit(habit);
      }

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Habit saved successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(habitsProvider.errorMessage ?? 'Something went wrong'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: HabitlyAppBar(
        title: _isEditing ? 'Edit Habit' : 'Add New Habit',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Habit Name', style: AppTypography.labelLarge),
                const SizedBox(height: AppConstants.spacingMd),
                TextFormField(
                  controller: _nameController,
                  validator: HabitValidators.validateName,
                  decoration: const InputDecoration(hintText: 'e.g. Drink 8 glasses of water'),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                IconGridSelector(
                  selectedIcon: _selectedIcon,
                  onIconSelected: (icon) => setState(() => _selectedIcon = icon),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                FrequencySelector(
                  selectedFrequency: _selectedFrequency,
                  onFrequencyChanged: (freq) => setState(() => _selectedFrequency = freq),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                GoalTypeSelector(
                  selectedGoalType: _selectedGoalType,
                  onGoalTypeChanged: (type) => setState(() => _selectedGoalType = type),
                  targetCount: _targetCount,
                  onTargetCountChanged: (count) => setState(() => _targetCount = count),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                ReminderPicker(
                  reminderTime: _reminderTime,
                  onReminderChanged: (time) => setState(() => _reminderTime = time),
                  remindersEnabled: _remindersEnabled,
                  onRemindersEnabledChanged: (val) => setState(() => _remindersEnabled = val),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                Consumer<HabitsProvider>(
                  builder: (context, provider, _) => PrimaryButton(
                    label: _isEditing ? 'Update Habit' : 'Create Habit',
                    isLoading: provider.isLoading,
                    onPressed: _handleSave,
                  ),
                ),
                if (_isEditing) ...[
                  const SizedBox(height: AppConstants.spacingMd),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _showDeleteDialog,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error, width: 2),
                      ),
                      child: const Text('Delete Habit'),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit?'),
        content: const Text('Are you sure? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteHabit();
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _deleteHabit() async {
    if (widget.habit == null) return;
    final habitsProvider = context.read<HabitsProvider>();
    final success = await habitsProvider.deleteHabit(widget.habit!.id);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Habit deleted'), backgroundColor: AppColors.success),
      );
      Navigator.pop(context);
    }
  }
}
