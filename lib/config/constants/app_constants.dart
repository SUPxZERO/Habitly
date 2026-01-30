/// App-wide constants and configuration
class AppConstants {
  // App Info
  static const String appName = 'Habitly';
  static const String appSlogan = 'Build better habits, one day at a time';
  static const String appVersion = '1.0.0';

  // Spacing/Padding
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border Radius
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 20.0;
  static const double radiusXl = 30.0;

  // Icon Sizes
  static const double iconSizeSm = 16.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;

  // Button Heights
  static const double buttonHeightSmall = 40.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;

  // Card Sizes
  static const double cardElevation = 2.0;
  static const double cardBorderRadius = 20.0;

  // Animation Durations
  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 300);
  static const Duration durationLong = Duration(milliseconds: 500);

  // Habit Related
  static const List<String> habitFrequencies = ['Daily', 'Weekly'];
  static const List<String> habitGoalTypes = ['Yes/No', 'Count'];
  static const List<String> weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const List<String> weekDaysFull = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // Theme
  static const String lightThemeKey = 'light';
  static const String darkThemeKey = 'dark';

  // Shared Preferences Keys
  static const String themeKey = 'theme_mode';
  static const String userAuthKey = 'user_authenticated';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';
  static const String habitsDataKey = 'habits_data';
  static const String habitLogsKey = 'habit_logs';
}
