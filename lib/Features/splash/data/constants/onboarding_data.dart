import 'package:stylish/generated/assets.dart';

class OnboardingPageData {
  final String image;
  final String title;
  final String description;

  OnboardingPageData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingData {
  static final List<OnboardingPageData> pages = [
    OnboardingPageData(
      image: 'assets/images/onboard1.png',
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingPageData(
      image: Assets.assetsImagesOnboard2!,
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingPageData(
      image: Assets.assetsImagesOnboard3!,
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];
}
