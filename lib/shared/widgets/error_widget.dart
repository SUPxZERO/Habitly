import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';

/// Error Widget for Habitly
class HabitlyErrorWidget extends StatelessWidget {
  final String message;
  final String? errorCode;
  final VoidCallback? onRetry;
  final bool showRetryButton;

  const HabitlyErrorWidget({
    Key? key,
    required this.message,
    this.errorCode,
    this.onRetry,
    this.showRetryButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Oops!',
              style: AppTypography.headline2,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium,
            ),
            if (errorCode != null) ...[
              const SizedBox(height: 8),
              Text(
                'Error Code: $errorCode',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
