import 'package:flutter/material.dart';

import '../theme/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const AppButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          elevation: elevation ?? 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30.0),
          ),
          padding:
          padding ?? EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
        child: Text(
          text.toUpperCase(),
          style: textStyle ??
              TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
        ),
      ),
    );
  }
}