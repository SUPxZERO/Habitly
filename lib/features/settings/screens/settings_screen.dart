import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:habitly/config/theme/app_colors.dart';
import 'package:habitly/config/theme/typography.dart';
import 'package:habitly/config/theme/theme_provider.dart';
import 'package:habitly/config/constants/app_constants.dart';
import 'package:habitly/config/routes/app_routes.dart';
import 'package:habitly/shared/widgets/custom_app_bar.dart';
import 'package:habitly/shared/widgets/bottom_nav_bar.dart';

/// Settings Screen - App preferences and settings
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final int _currentNavIndex = 3; // Using profile tab for settings for now
  bool _notificationsEnabled = true;
  bool _dailyReminders = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: const HabitlyAppBar(
        title: 'Settings',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Notifications Section
              _buildSettingsSection(
                title: 'Notifications',
                children: [
                  _buildSettingsTile(
                    title: 'Notifications',
                    description: 'Receive habit reminders and updates',
                    trailing: Transform.scale(
                      scale: 0.8,
                      child: Switch(
                        value: _notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                        },
                        activeThumbColor: AppColors.success,
                      ),
                    ),
                  ),
                  if (_notificationsEnabled) ...[
                    const SizedBox(height: AppConstants.spacingMd),
                    _buildSettingsTile(
                      title: 'Daily Reminders',
                      description: 'Get reminded about your daily habits',
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          value: _dailyReminders,
                          onChanged: (value) {
                            setState(() {
                              _dailyReminders = value;
                            });
                          },
                          activeThumbColor: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ],
              ),

              // Appearance Section
              _buildSettingsSection(
                title: 'Appearance',
                children: [
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, _) {
                      return _buildSettingsTile(
                        title: 'Dark Mode',
                        description: 'Easier on the eyes',
                        trailing: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: themeProvider.isDarkMode,
                            onChanged: (value) {
                              themeProvider.toggleTheme();
                            },
                            activeThumbColor: AppColors.success,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              // // About Section
              // _buildSettingsSection(
              //   title: 'About',
              //   children: [
              //     _buildSettingsTile(
              //       title: 'App Version',
              //       description: '1.0.0',
              //       trailing: const SizedBox.shrink(),
              //     ),
              //     const SizedBox(height: AppConstants.spacingMd),
              //     _buildSettingsTile(
              //       title: 'Privacy Policy',
              //       description: 'Read our privacy policy',
              //       trailing: const Icon(
              //         Icons.arrow_forward_ios,
              //         size: 16,
              //         color: AppColors.textMedium,
              //       ),
              //       onTap: () {
              //         // TODO: Open privacy policy
              //       },
              //     ),
              //     const SizedBox(height: AppConstants.spacingMd),
              //     _buildSettingsTile(
              //       title: 'Terms of Service',
              //       description: 'Read our terms',
              //       trailing: const Icon(
              //         Icons.arrow_forward_ios,
              //         size: 16,
              //         color: AppColors.textMedium,
              //       ),
              //       onTap: () {
              //         // TODO: Open terms
              //       },
              //     ),
              //   ],
              // ),

              // Logout Section
              Padding(
                padding: const EdgeInsets.all(AppConstants.spacingLg),
                child: Column(
                  children: [
                    const SizedBox(height: AppConstants.spacingMd),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _showLogoutDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.spacingMd,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout, size: 20),
                            const SizedBox(width: AppConstants.spacingSm),
                            Text(
                              'Log Out',
                              style: AppTypography.labelLarge.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: HabitlyBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.pushNamed(AppRouter.homeRoute);
              break;
            case 1:
              context.pushNamed(AppRouter.habitsRoute);
              break;
            case 2:
              context.pushNamed(AppRouter.calendarRoute);
              break;
            case 3:
              context.pushNamed(AppRouter.profileRoute);
              break;
          }
        },
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.headline3.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Container(
            decoration: BoxDecoration(
              color: AppColors.bgWhite,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String description,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMd,
          vertical: AppConstants.spacingMd,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelLarge,
                  ),
                  const SizedBox(height: AppConstants.spacingSm),
                  Text(
                    description,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.spacingMd),
            trailing,
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out?'),
        content: const Text(
          'Are you sure you want to log out? Your local data will be preserved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pushReplacementNamed(AppRouter.entryRoute);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
