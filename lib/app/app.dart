import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/theme_provider.dart';
import 'config/constants/app_constants.dart';
import 'features/auth/screens/entry_page.dart';

/// Main Habitly App Widget
class HabitlyApp extends StatelessWidget {
  const HabitlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const EntryPage(),
        );
      },
    );
  }
}
