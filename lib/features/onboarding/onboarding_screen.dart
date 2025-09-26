import 'package:alaram_app/features/onboarding/screeen1.dart';
import 'package:alaram_app/features/onboarding/screen2.dart';
import 'package:alaram_app/features/onboarding/screen3.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../location_screen/location_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  // Your onboarding screens
  final List<Widget> screens = [
    const OnboardingScreen1(),
    const OnboardingScreen2(),
    const OnboardingScreen3(),
  ];

  // Finish onboarding: save flag and navigate
  Future<void> _finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LocationScreen()),
    );
  }

  @override
  void initState() {
    super.initState();

    // Listen to page changes and detect last page
    _pageController.addListener(() {
      if (_pageController.page != null &&
          _pageController.page! >= screens.length - 1) {
        // Automatically finish onboarding when last screen is reached
        _finishOnboarding();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: screens.length,
        itemBuilder: (context, index) => screens[index],
      ),
      // No bottom sheet, no buttons, no dots
    );
  }
}
