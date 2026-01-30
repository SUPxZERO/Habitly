import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/typography.dart';
import '../../config/constants/app_constants.dart';
import '../../shared/widgets/primary_button.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_slide_widget.dart';
import '../provider/onboarding_provider.dart';

/// Onboarding Screen
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final Map<String, IconData> _iconMap = {
    'check_circle': Icons.check_circle_outline,
    'chart_line': Icons.show_chart,
    'trophy': Icons.emoji_events_outlined,
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < OnboardingData.totalSlides - 1) {
      _pageController.nextPage(
        duration: AppConstants.durationMedium,
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() {
    OnboardingProvider.setOnboardingComplete();
    // TODO: Navigate to Entry Page or Home
    Navigator.of(context).pop();
  }

  void _skipOnboarding() {
    OnboardingProvider.setOnboardingComplete();
    // TODO: Navigate to Entry Page
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skipOnboarding,
                child: Text(
                  'Skip',
                  style: AppTypography.labelLarge.copyWith(
                    color: AppColors.textMedium,
                  ),
                ),
              ),
            ),
            // Page View
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingData.slides.length,
                itemBuilder: (context, index) {
                  final slide = OnboardingData.slides[index];
                  return OnboardingSlideWidget(
                    title: slide.title,
                    description: slide.description,
                    icon: _iconMap[slide.icon] ?? Icons.star_outline,
                  );
                },
              ),
            ),
            // Page Indicator and Button
            Padding(
              padding: const EdgeInsets.all(AppConstants.spacingLg),
              child: Column(
                children: [
                  // Smooth Page Indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: OnboardingData.slides.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: AppColors.border,
                      activeDotColor: AppColors.primary,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingLg),
                  // Next/Get Started Button
                  PrimaryButton(
                    label: _currentPage == OnboardingData.totalSlides - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: _goToNextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
