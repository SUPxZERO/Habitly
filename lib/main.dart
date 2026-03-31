import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habitly/config/theme/theme_provider.dart';
import 'package:habitly/features/auth/provider/auth_provider.dart';
import 'package:habitly/features/habits/provider/habits_provider.dart';
import 'package:habitly/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HabitsProvider()),
      ],
      child: const HabitlyApp(),
    ),
  );
}
