import 'package:uuid/uuid.dart';

/// Habit Model - Core data structure for habits
class Habit {
  final String id;
  final String name;
  final String icon;
  final String frequency; // 'Daily' or 'Weekly'
  final String goalType; // 'Yes/No' or 'Count'
  final int? targetCount; // For count-based habits
  final String? reminderTime; // HH:MM format
  final bool remindersEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final int currentStreak;

  Habit({
    String? id,
    required this.name,
    required this.icon,
    required this.frequency,
    required this.goalType,
    this.targetCount,
    this.reminderTime,
    this.remindersEnabled = false,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.description = '',
    this.currentStreak = 0,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  Habit copyWith({
    String? id,
    String? name,
    String? icon,
    String? frequency,
    String? goalType,
    int? targetCount,
    String? reminderTime,
    bool? remindersEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    int? currentStreak,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      frequency: frequency ?? this.frequency,
      goalType: goalType ?? this.goalType,
      targetCount: targetCount ?? this.targetCount,
      reminderTime: reminderTime ?? this.reminderTime,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'frequency': frequency,
      'goalType': goalType,
      'targetCount': targetCount,
      'reminderTime': reminderTime,
      'remindersEnabled': remindersEnabled,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'currentStreak': currentStreak,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
      frequency: map['frequency'],
      goalType: map['goalType'],
      targetCount: map['targetCount'],
      reminderTime: map['reminderTime'],
      remindersEnabled: map['remindersEnabled'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      description: map['description'] ?? '',
      currentStreak: map['currentStreak'] ?? 0,
    );
  }
}
