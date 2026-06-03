import 'package:flutter/material.dart';
import 'package:stylish/Features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:stylish/generated/assets.dart';

class OnboardingData {
  static final List<OnboardingPageData> pages = [
    OnboardingPageData(
      imagePath: Assets.assetsImagesOnboard1!,
      title: 'Choose Products',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      accentColor: Colors.blue,
    ),
    OnboardingPageData(
      imagePath: Assets.assetsImagesOnboard2!,
      title: 'Make Payment',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      accentColor: Colors.green,
    ),
    OnboardingPageData(
      imagePath: Assets.assetsImagesOnboard3!,
      title: 'Get Your Order',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      accentColor: Colors.orange,
    ),
  ];
}
