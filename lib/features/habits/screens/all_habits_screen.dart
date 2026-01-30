import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../config/routes/app_routes.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/bottom_nav_bar.dart';
import '../provider/habits_provider.dart';
import '../widgets/habit_card.dart';
import '../widgets/habit_tab_bar.dart';

/// All Habits Screen - List of all habits with filtering
class AllHabitsScreen extends StatefulWidget {
  const AllHabitsScreen({Key? key}) : super(key: key);

  @override
  State<AllHabitsScreen> createState() => _AllHabitsScreenState();
}

class _AllHabitsScreenState extends State<AllHabitsScreen> {
  int _selectedTabIndex = 0;
  int _currentNavIndex = 1;

  final List<String> _tabs = ['All', 'Daily', 'Weekly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: HabitlyAppBar(
        title: 'All Habits',
        showBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Bar
            Padding(
              padding: const EdgeInsets.only(left: AppConstants.spacingLg),
              child: HabitTabBar(
                tabs: _tabs,
                selectedIndex: _selectedTabIndex,
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
            ),
            // Habits List
            Expanded(
              child: Consumer<HabitsProvider>(
                builder: (context, habitsProvider, _) {
                  List<dynamic> filteredHabits;

                  if (_selectedTabIndex == 0) {
                    // All
                    filteredHabits = habitsProvider.habits;
                  } else if (_selectedTabIndex == 1) {
                    // Daily
                    filteredHabits =
                        habitsProvider.getHabitsByFrequency('Daily');
                  } else {
                    // Weekly
                    filteredHabits =
                        habitsProvider.getHabitsByFrequency('Weekly');
                  }

                  if (filteredHabits.isEmpty) {
                    return Center(
                      child: Text(
                        'No ${_tabs[_selectedTabIndex].toLowerCase()} habits',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.spacingLg),
                    itemCount: filteredHabits.length,
                    itemBuilder: (context, index) {
                      final habit = filteredHabits[index];
                      final isCompleted =
                          habitsProvider.isCompletedToday(habit.id);

                      return HabitCard(
                        habit: habit,
                        isCompleted: isCompleted,
                        onCheckTap: () {
                          habitsProvider.toggleHabitCompletion(habit.id);
                        },
                        onTap: () {
                          // TODO: Navigate to habit details
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add habit screen
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: HabitlyBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
          // TODO: Navigate to different tabs
        },
      ),
    );
  }
}
