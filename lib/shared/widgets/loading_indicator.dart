import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

/// Loading Indicator for Habitly
class HabitlyLoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const HabitlyLoadingIndicator({
    Key? key,
    this.size = 40,
    this.color,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: const TextStyle(
                color: AppColors.textMedium,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
