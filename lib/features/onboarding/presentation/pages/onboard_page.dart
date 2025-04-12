import 'package:flutter/material.dart';
import 'package:plant_app/features/onboarding/presentation/pages/onboard_screen.dart';
import 'package:plant_app/features/onboarding/presentation/widgets/dots_indicator.dart';
import 'package:plant_app/features/onboarding/presentation/widgets/next_animated_button.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  PageController? pageController;
  double currentPage = 0.0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {
          currentPage = pageController!.page ?? 0.0;
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 171, 210, 249), // أزرق فاتح جدًا
              Color(0xFFF5F7DC), // أصفر شفاف
              Color(0xFFDFFFE0), // أخضر فاتح جدًا
            ],
          ),
        ),
        child: Stack(
          children: [
            OnboardScreen(pageController: pageController!),
            Positioned(
              child: Center(
                child: Dotsindicator(
                    dotIndex:
                        pageController!.hasClients ? pageController?.page : 0),
              ),
            ),
            Visibility(
              visible: pageController!.hasClients == true &&
                      pageController?.page == 2
                  ? false
                  : true,
              child: Positioned(
                top: 60,
                right: 20,
                child: Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            pageController!.hasClients == true &&
                    pageController?.page != null &&
                    pageController!.page! <= 1
                ? Positioned(
                    bottom: 120,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: NextAnimatedButton(
                        onTap: () {
                          if (pageController!.page! < 2) {
                            pageController?.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          }
                        },
                        text: "Next",
                      ),
                    ),
                  )
                : Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NextAnimatedButton(
                          text: "Login",
                          onTap: () {
                            Navigator.pushNamed(context, "LoginPage");
                          },
                        ),
                        const SizedBox(height: 16), // مسافة بين الزرين
                        NextAnimatedButton(
                          text: "Sign up",
                          onTap: () {
                            Navigator.pushNamed(context, "RegisterationPage");
                          },
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
