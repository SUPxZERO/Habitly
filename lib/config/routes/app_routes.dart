import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/auth/screens/entry_page.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/habits/screens/all_habits_screen.dart';
import '../../features/add_habit/screens/add_edit_habit_screen.dart';
import '../../features/habits/models/habit_model.dart';

/// App Router Configuration
class AppRouter {
  static const String entryRoute = '/';
  static const String signUpRoute = '/signup';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String onboardingRoute = '/onboarding';
  static const String homeRoute = '/home';
  static const String habitsRoute = '/habits';
  static const String addHabitRoute = '/add-habit';
  static const String editHabitRoute = '/edit-habit';

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: entryRoute,
        name: 'entry',
        builder: (context, state) => const EntryPage(),
      ),
      GoRoute(
        path: signUpRoute,
        name: 'signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: forgotPasswordRoute,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: onboardingRoute,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: homeRoute,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: habitsRoute,
        name: 'habits',
        builder: (context, state) => const AllHabitsScreen(),
      ),
      GoRoute(
        path: addHabitRoute,
        name: 'add-habit',
        builder: (context, state) => const AddEditHabitScreen(),
      ),
      GoRoute(
        path: '$editHabitRoute/:id',
        name: 'edit-habit',
        builder: (context, state) {
          // TODO: Parse habit ID from route and fetch habit data
          return const AddEditHabitScreen();
        },
      ),
    ],
  );
}
