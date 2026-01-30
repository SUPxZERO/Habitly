import 'package:flutter/material.dart';
import '../models/habit_model.dart';
import '../../shared/utils/logger.dart';

/// Habits Provider - Manages habit state and operations
class HabitsProvider extends ChangeNotifier {
  List<Habit> _habits = [];
  Habit? _selectedHabit;
  bool _isLoading = false;
  String? _errorMessage;

  // Mock completion data - tracks completions by habit ID and date
  Map<String, List<DateTime>> _completions = {};

  // Getters
  List<Habit> get habits => _habits;
  Habit? get selectedHabit => _selectedHabit;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, List<DateTime>> get completions => _completions;

  // Filter habits by frequency
  List<Habit> getHabitsByFrequency(String frequency) {
    return _habits.where((h) => h.frequency == frequency).toList();
  }

  /// Initialize with mock habits
  void initializeMockHabits() {
    _habits = [
      Habit(
        name: 'Morning Workout',
        icon: 'dumbbell',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: 'Exercise for 30 minutes',
        currentStreak: 7,
      ),
      Habit(
        name: 'Read 30 Minutes',
        icon: 'book',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: 'Reading in the evening',
        currentStreak: 8,
      ),
      Habit(
        name: 'Meditation',
        icon: 'brain',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: '10 minutes mindfulness',
        currentStreak: 22,
      ),
      Habit(
        name: 'Drink Water',
        icon: 'water_drop',
        frequency: 'Daily',
        goalType: 'Count',
        targetCount: 8,
        description: '8 glasses per day',
        currentStreak: 31,
      ),
      Habit(
        name: 'Healthy Breakfast',
        icon: 'fork_knife',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: 'Nutritious morning meal',
        currentStreak: 12,
      ),
      Habit(
        name: 'Sleep 8 Hours',
        icon: 'moon',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: '10:00 PM sleep time',
        currentStreak: 5,
      ),
      Habit(
        name: 'Code Practice',
        icon: 'pencil',
        frequency: 'Daily',
        goalType: 'Yes/No',
        description: 'Daily coding challenge',
        currentStreak: 19,
      ),
    ];

    // Mock completion data for today
    final today = DateTime.now();
    for (int i = 0; i < 3; i++) {
      _completions[_habits[i].id] = [today];
    }

    notifyListeners();
    AppLogger.info('Mock habits initialized: ${_habits.length} habits');
  }

  /// Add new habit
  Future<bool> addHabit(Habit habit) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));

      _habits.add(habit);
      _completions[habit.id] = [];

      AppLogger.info('Habit added: ${habit.name}');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Add habit error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update existing habit
  Future<bool> updateHabit(Habit habit) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 500));

      final index = _habits.indexWhere((h) => h.id == habit.id);
      if (index != -1) {
        _habits[index] = habit;
        AppLogger.info('Habit updated: ${habit.name}');
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Update habit error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Delete habit
  Future<bool> deleteHabit(String habitId) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await Future.delayed(const Duration(milliseconds: 300));

      _habits.removeWhere((h) => h.id == habitId);
      _completions.remove(habitId);

      AppLogger.info('Habit deleted: $habitId');
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      AppLogger.error('Delete habit error: $e');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Toggle habit completion for today
  void toggleHabitCompletion(String habitId) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    if (!_completions.containsKey(habitId)) {
      _completions[habitId] = [];
    }

    final habitCompletions = _completions[habitId]!;
    final alreadyCompleted = habitCompletions.any(
      (date) => DateTime(date.year, date.month, date.day) == todayOnly,
    );

    if (alreadyCompleted) {
      habitCompletions.removeWhere(
        (date) => DateTime(date.year, date.month, date.day) == todayOnly,
      );
    } else {
      habitCompletions.add(today);
    }

    notifyListeners();
    AppLogger.info('Habit toggled: $habitId');
  }

  /// Check if habit is completed today
  bool isCompletedToday(String habitId) {
    if (!_completions.containsKey(habitId)) return false;

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    return _completions[habitId]!.any(
      (date) => DateTime(date.year, date.month, date.day) == todayOnly,
    );
  }

  /// Get completion count for habit (all time)
  int getCompletionCount(String habitId) {
    return _completions[habitId]?.length ?? 0;
  }

  /// Select habit for details view
  void selectHabit(Habit habit) {
    _selectedHabit = habit;
    notifyListeners();
  }

  /// Clear selection
  void clearSelection() {
    _selectedHabit = null;
    notifyListeners();
  }

  /// Get today's progress (percentage of habits completed)
  double getTodayProgress() {
    if (_habits.isEmpty) return 0;

    final completedCount = _habits
        .where((h) => isCompletedToday(h.id))
        .length;

    return (completedCount / _habits.length) * 100;
  }

  /// Get today's completed habits
  List<Habit> getTodayCompletedHabits() {
    return _habits.where((h) => isCompletedToday(h.id)).toList();
  }
}
