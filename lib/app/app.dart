import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/theme/app_theme.dart';
import '../config/theme/theme_provider.dart';
import '../config/constants/app_constants.dart';
import '../config/routes/app_routes.dart';
import '../features/auth/provider/auth_provider.dart';

/// Main Habitly App Widget
class HabitlyApp extends StatelessWidget {
  const HabitlyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp.router(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
