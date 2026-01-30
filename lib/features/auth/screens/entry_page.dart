import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../config/routes/app_routes.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/secondary_button.dart';

/// Entry Page - Splash/Login screen
class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              // Logo and Branding
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.gradientSuccess,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                  Text(
                    AppConstants.appName,
                    style: AppTypography.headline1,
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  Text(
                    AppConstants.appSlogan,
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
              // Action Buttons
              Column(
                children: [
                  PrimaryButton(
                    label: 'Get Started',
                    onPressed: () {
                      context.pushNamed(AppRouter.signUpRoute);
                    },
                  ),
                  const SizedBox(height: AppConstants.spacingMd),
                  SecondaryButton(
                    label: 'I already have an account',
                    onPressed: () {
                      context.pushNamed(AppRouter.loginRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
