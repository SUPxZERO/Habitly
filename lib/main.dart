import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/theme/theme_provider.dart';
import 'features/auth/provider/auth_provider.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const HabitlyApp(),
    ),
  );
}

