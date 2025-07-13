import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/onboarding_page_widget.dart';
import './widgets/page_indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      "title": "Skip the Queue",
      "description":
          "Order your favorite meals in advance and skip the long canteen queues. Save time and enjoy your food faster.",
      "animationUrl":
          "https://lottie.host/4d5e6f7g-8h9i-0j1k-2l3m-4n5o6p7q8r9s/data.json",
      "backgroundColor": Color(0xFFFFF3E0),
    },
    {
      "title": "Pick Your Time",
      "description":
          "Choose your preferred pickup time with our smart scheduling system. Plan your meals around your busy college schedule.",
      "animationUrl":
          "https://lottie.host/1a2b3c4d-5e6f-7g8h-9i0j-1k2l3m4n5o6p/data.json",
      "backgroundColor": Color(0xFFE8F5E8),
    },
    {
      "title": "Get Notified When Ready",
      "description":
          "Receive instant notifications when your order is ready for pickup. Never miss your meal or wait unnecessarily.",
      "animationUrl":
          "https://lottie.host/7q8r9s0t-1u2v-3w4x-5y6z-7a8b9c0d1e2f/data.json",
      "backgroundColor": Color(0xFFE3F2FD),
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _skipOnboarding() {
    _navigateToAuth();
  }

  // void _navigateToAuth() {
  //   Navigator.pushReplacementNamed(context, '/authentication-screen');
  // }

  void _navigateToAuth() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isFirstTime', false); // Mark onboarding as completed

  Navigator.pushReplacementNamed(context, '/authentication-screen');
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return OnboardingPageWidget(
                    title: _onboardingData[index]["title"] as String,
                    description:
                        _onboardingData[index]["description"] as String,
                    animationUrl:
                        _onboardingData[index]["animationUrl"] as String,
                    backgroundColor:
                        _onboardingData[index]["backgroundColor"] as Color,
                  );
                },
              ),
            ),

            // Bottom navigation area
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
              child: Column(
                children: [
                  // Page indicator
                  PageIndicatorWidget(
                    currentPage: _currentPage,
                    totalPages: _onboardingData.length,
                  ),

                  SizedBox(height: 4.h),

                  // Navigation button
                  SizedBox(
                    width: double.infinity,
                    height: 6.h,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: AppTheme.lightTheme.elevatedButtonTheme.style
                          ?.copyWith(
                        backgroundColor: WidgetStateProperty.all(
                          AppTheme.lightTheme.colorScheme.primary,
                        ),
                      ),
                      child: Text(
                        _currentPage == _onboardingData.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style:
                            AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
