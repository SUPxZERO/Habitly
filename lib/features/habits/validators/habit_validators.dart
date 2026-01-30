/// Habit Validation Rules
class HabitValidators {
  /// Validates habit name - min 3 chars, max 50 chars
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Habit name is required';
    }
    if (value.trim().length < 3) {
      return 'Habit name must be at least 3 characters';
    }
    if (value.length > 50) {
      return 'Habit name must be less than 50 characters';
    }
    return null;
  }

  /// Validates target count - must be positive integer
  static String? validateTargetCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Target count is required';
    }
    final count = int.tryParse(value);
    if (count == null || count <= 0) {
      return 'Target must be a positive number';
    }
    if (count > 999) {
      return 'Target must be less than 999';
    }
    return null;
  }
}
