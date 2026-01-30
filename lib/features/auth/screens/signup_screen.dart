import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../config/routes/app_routes.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../widgets/auth_text_field.dart';
import '../provider/auth_provider.dart';
import '../validators/auth_validators.dart';

/// Sign Up Screen
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
      );

      if (success && mounted) {
        // Navigate to home screen
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully!'),
            backgroundColor: AppColors.success,
          ),
        );
        context.pushReplacementNamed(AppRouter.homeRoute);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Sign up failed'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: HabitlyAppBar(
        title: 'Create Account',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join Habitly',
                  style: AppTypography.headline2,
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  'Build better habits, one day at a time',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingXl),
                // Name Field
                AuthTextField(
                  label: 'Full Name',
                  hint: 'e.g. John Doe',
                  controller: _nameController,
                  validator: AuthValidators.validateName,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: AppConstants.spacingLg),
                // Email Field
                AuthTextField(
                  label: 'Email Address',
                  hint: 'e.g. john@example.com',
                  controller: _emailController,
                  validator: AuthValidators.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: AppConstants.spacingLg),
                // Password Field
                AuthTextField(
                  label: 'Password',
                  hint: 'Create a strong password',
                  controller: _passwordController,
                  validator: AuthValidators.validatePassword,
                  obscureText: true,
                ),
                const SizedBox(height: AppConstants.spacingMd),
                Text(
                  'Password must contain at least 8 characters, one uppercase letter, one lowercase letter, and one number',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: AppConstants.spacingLg),
                // Confirm Password Field
                AuthTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  validator: (value) => AuthValidators.validatePasswordConfirmation(
                    value,
                    _passwordController.text,
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: AppConstants.spacingXl),
                // Sign Up Button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return PrimaryButton(
                      label: 'Create Account',
                      isLoading: authProvider.isLoading,
                      onPressed: _handleSignUp,
                    );
                  },
                ),
                const SizedBox(height: AppConstants.spacingLg),
                // Login Link
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textMedium,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
