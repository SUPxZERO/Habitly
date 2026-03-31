import 'package:go_router/go_router.dart';
import 'package:habitly/features/auth/screens/entry_page.dart';
import 'package:habitly/features/auth/screens/signup_screen.dart';
import 'package:habitly/features/auth/screens/login_screen.dart';
import 'package:habitly/features/auth/screens/forgot_password_screen.dart';
import 'package:habitly/features/onboarding/screens/onboarding_screen.dart';
import 'package:habitly/features/home/screens/home_screen.dart';
import 'package:habitly/features/habits/screens/all_habits_screen.dart';
import 'package:habitly/features/add_habit/screens/add_edit_habit_screen.dart';
import 'package:habitly/features/habit_details/screens/habit_details_screen.dart';
import 'package:habitly/features/calendar/screens/calendar_screen.dart';
import 'package:habitly/features/profile/screens/profile_screen.dart';
import 'package:habitly/features/settings/screens/settings_screen.dart';
import 'package:habitly/features/habits/models/habit_model.dart';

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
  static const String habitDetailsRoute = '/habit-details';
  static const String calendarRoute = '/calendar';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: entryRoute,
    routes: [
      GoRoute(
        path: entryRoute,
        name: entryRoute,
        builder: (context, state) => const EntryPage(),
      ),
      GoRoute(
        path: signUpRoute,
        name: signUpRoute,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: loginRoute,
        name: loginRoute,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: onboardingRoute,
        name: onboardingRoute,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: homeRoute,
        name: homeRoute,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: habitsRoute,
        name: habitsRoute,
        builder: (context, state) => const AllHabitsScreen(),
      ),
      GoRoute(
        path: addHabitRoute,
        name: addHabitRoute,
        builder: (context, state) => const AddEditHabitScreen(),
      ),
      GoRoute(
        path: '$editHabitRoute/:id',
        name: editHabitRoute,
        builder: (context, state) => const AddEditHabitScreen(),
      ),
      GoRoute(
        path: '$habitDetailsRoute/:id',
        name: habitDetailsRoute,
        builder: (context, state) {
          final habit = Habit(
            id: state.pathParameters['id'] ?? '1',
            name: 'Example Habit',
            icon: 'water_drop',
            frequency: 'Daily',
            goalType: 'Yes/No',
          );
          return HabitDetailsScreen(habit: habit);
        },
      ),
      GoRoute(
        path: calendarRoute,
        name: calendarRoute,
        builder: (context, state) => const CalendarScreen(),
      ),
      GoRoute(
        path: profileRoute,
        name: profileRoute,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: settingsRoute,
        name: settingsRoute,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
