import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../shared/widgets/primary_button.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../widgets/auth_text_field.dart';
import '../provider/auth_provider.dart';
import '../validators/auth_validators.dart';

/// Forgot Password Screen
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.resetPassword(_emailController.text.trim());

      if (success && mounted) {
        setState(() {
          _emailSent = true;
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Reset failed'),
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
        title: 'Reset Password',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_emailSent)
                _buildSuccessState()
              else
                _buildResetForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResetForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reset Your Password',
            style: AppTypography.headline2,
          ),
          const SizedBox(height: AppConstants.spacingMd),
          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Email Field
          AuthTextField(
            label: 'Email Address',
            hint: 'e.g. john@example.com',
            controller: _emailController,
            validator: AuthValidators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppConstants.spacingXl),
          // Reset Button
          Consumer<AuthProvider>(
            builder: (context, authProvider, _) {
              return PrimaryButton(
                label: 'Send Reset Link',
                isLoading: authProvider.isLoading,
                onPressed: _handleReset,
              );
            },
          ),
          const SizedBox(height: AppConstants.spacingLg),
          // Back to Login Link
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                'Back to Log In',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppConstants.spacingXl),
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
          'Check Your Email',
          style: AppTypography.headline2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingMd),
        Text(
          'We\'ve sent a password reset link to ${_emailController.text}',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textMedium,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingXl),
        Text(
          'Click the link in the email to reset your password. If you don\'t see the email, check your spam folder.',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textLight,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppConstants.spacingXl),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back to Log In'),
          ),
        ),
      ],
    );
  }
}
