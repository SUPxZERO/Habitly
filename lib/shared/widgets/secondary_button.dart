import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';

/// Secondary Button - Outlined variant
class SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final Color? borderColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  const SecondaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.height = 56,
    this.borderRadius = 30,
    this.borderColor,
    this.textColor,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  @override
  Widget build(BuildContext context) {
    final borderColor = widget.borderColor ?? AppColors.primary;
    final textColor = widget.textColor ?? AppColors.primary;

    return GestureDetector(
      onTap: widget.enabled && !widget.isLoading ? widget.onPressed : null,
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.transparent,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.enabled && !widget.isLoading ? widget.onPressed : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(textColor),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.prefixIcon != null) ...[
                          widget.prefixIcon!,
                          const SizedBox(width: 8),
                        ],
                        Text(
                          widget.label,
                          style: widget.textStyle ??
                              AppTypography.buttonLarge.copyWith(
                                color: textColor,
                              ),
                        ),
                        if (widget.suffixIcon != null) ...[
                          const SizedBox(width: 8),
                          widget.suffixIcon!,
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
