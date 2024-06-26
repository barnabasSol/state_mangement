import 'package:flutter/material.dart';
import 'package:intro_fiddle/pages/intro_page_one.dart';
import 'package:intro_fiddle/pages/intro_page_three.dart';
import 'package:intro_fiddle/pages/intro_page_two.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final screenCount = 3;
  bool isLastPage = false;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                isLastPage = index == screenCount - 1;
              });
            },
            controller: _pageController,
            children: const [
              IntroPageOne(),
              IntroPageTwo(),
              IntroPageThree(),
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      screenCount - 1,
                      duration: const Duration(
                        seconds: 1,
                      ),
                      curve: Curves.ease,
                    );
                  },
                  child: const Chip(
                    label: Text('Skip'),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _pageController,
                  count: screenCount,
                  effect: const ScrollingDotsEffect(
                    spacing: 27,
                    dotWidth: 32,
                  ),
                ),
                !isLastPage
                    ? GestureDetector(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Chip(
                          label: Text('Next'),
                        ),
                      )
                    : const Chip(
                        label: Text('Done'),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
