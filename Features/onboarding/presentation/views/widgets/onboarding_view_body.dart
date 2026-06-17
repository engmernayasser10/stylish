import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/utilis/app_colors.dart';
import 'package:stylish/core/utilis/app_text_styles.dart';

class OnboardingPageData {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color accentColor;

  const OnboardingPageData({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.accentColor,
  });

  String? get image => null;

  String? description() => null;
}

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  static const List<OnboardingPageData> _pages = [
    OnboardingPageData(
      title: 'Choose Products',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      imagePath: 'assets/images/fashion shop-rafiki 1.png',
      accentColor: Color.fromARGB(255, 255, 255, 255),
    ),
    OnboardingPageData(
      title: 'Make Payment',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      imagePath: 'assets/images/Sales consulting-pana 1.png',
      accentColor: Color.fromARGB(255, 255, 255, 255),
    ),
    OnboardingPageData(
      title: 'Get Your Order',
      subtitle:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      imagePath: 'assets/images/Shopping bag-rafiki 1.png',
      accentColor: Color.fromARGB(255, 255, 255, 255),
    ),
  ];

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleNext() {
    if (_currentIndex < _pages.length - 1) {
      _goToPage(_currentIndex + 1);
    } else {
      context.go(AppRoutes.kSplashView);
    }
  }

  void _handlePrev() {
    if (_currentIndex > 0) {
      _goToPage(_currentIndex - 1);
    }
  }

  void _handleSkip() {
    _goToPage(_pages.length - 1);
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => Container(
          width: index == _currentIndex ? 20.w : 8.w,
          height: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: index == _currentIndex ? AppColors.primary : AppColors.grey4,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(OnboardingPageData page) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 28.h),
          Container(
            width: 260.w,
            height: 260.w,
            decoration: BoxDecoration(
              color: page.accentColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Center(
              child: Container(
                width: 300.w,
                height: 300.w,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24.r),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.08),
                  //     blurRadius: 24,
                  //     offset: const Offset(0, 16),
                  //   ),
                  // ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      page.imagePath,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 28.h),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.extraBold24
                .copyWith(color: AppColors.onBackground),
          ),
          SizedBox(height: 16.h),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular16
                .copyWith(color: AppColors.textGrey, height: 1.6),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentIndex + 1}/${_pages.length}',
                style: AppTextStyles.bold18
                    .copyWith(color: AppColors.onBackground),
              ),
              TextButton(
                onPressed: _handleSkip,
                child: Text(
                  'Skip',
                  style: AppTextStyles.bold16
                      .copyWith(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildOnboardingPage(_pages[index]);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPageIndicator(),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: _currentIndex == 0 ? 0 : 1,
                    child: TextButton(
                      onPressed: _currentIndex == 0 ? null : _handlePrev,
                      child: Text(
                        'Prev',
                        style: AppTextStyles.bold16.copyWith(
                          color: _currentIndex == 0
                              ? AppColors.grey4
                              : AppColors.onBackground,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _handleNext,
                    child: Text(
                      _currentIndex == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      style: AppTextStyles.bold16
                          .copyWith(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
