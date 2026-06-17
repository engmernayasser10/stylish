import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utilis/app_text_styles.dart';

class ForgotPasswordTitle extends StatelessWidget {
  const ForgotPasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot password?',
          style: AppTextStyles.bold36.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 36.h),
      ],
    );
  }
}
