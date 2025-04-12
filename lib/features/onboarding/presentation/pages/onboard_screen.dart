import 'package:flutter/material.dart';
import 'package:plant_app/features/onboarding/presentation/widgets/onboard_item.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key, required this.pageController});
  static const String routeName = "onboard_screen";
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: pageController,
        children: [
          OnboardItem(
            image: "assets/images/onboard1.png",
            description1: "Discover Plants",
            description2:
                "Explore a wide variety of plants with detailed information",
          ),
          OnboardItem(
            image: "assets/images/onboard2.png",
            description1: "Plant Care Tips",
            description2:
                "Learn how to care for your plants and keep them healthy",
          ),
          OnboardItem(
            image: "assets/images/onboard4.png",
            description1: "Welcome",
            description2: "Make your home green with our plants",
          ),
        ],
      ),
    );
  }
}
