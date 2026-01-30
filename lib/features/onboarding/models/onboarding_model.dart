/// Onboarding data model
class OnboardingSlide {
  final String title;
  final String description;
  final String icon;
  final int index;

  OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
    required this.index,
  });
}

/// Onboarding slides data
class OnboardingData {
  static final List<OnboardingSlide> slides = [
    OnboardingSlide(
      index: 0,
      title: 'Track Your Habits',
      description: 'Build consistency step by step',
      icon: 'check_circle',
    ),
    OnboardingSlide(
      index: 1,
      title: 'See Your Progress',
      description: 'Visualize your growth with beautiful charts',
      icon: 'chart_line',
    ),
    OnboardingSlide(
      index: 2,
      title: 'Build Better Habits',
      description: 'Small steps every day lead to big changes',
      icon: 'trophy',
    ),
  ];

  static int get totalSlides => slides.length;
}
