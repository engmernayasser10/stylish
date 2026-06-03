import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:stylish/core/utilis/app_text_styles.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingPageData pageData;

  const OnboardingPageContent({super.key, required this.pageData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Center(
            child: Image.asset(
              pageData.imagePath,
              fit: BoxFit.contain,
              width: 500.w,
              height: 300.h,
            ),
          ),

          SizedBox(height: 20.h),

          // Title
          Text(
            pageData.title,
            style: AppTextStyles.extraBold24.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              pageData.description()!,
              style: AppTextStyles.bold14.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
