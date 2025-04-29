
import 'package:edunourish/features/Parent/core/utils/assets.dart';
import 'package:edunourish/features/Parent/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ParentSlider extends StatelessWidget {
  final PageController _pageController = PageController();
  ParentSlider({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              height: screenHeight * 0.28,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(schoolNews),
                  );
                },
              ),
            ),
          ),
        ),
        // Page Indicator with clickable dots
        SmoothPageIndicator(
          controller: _pageController,
          count: 10,
          effect: ExpandingDotsEffect(
            dotWidth: 8,
            dotHeight: 8,
            activeDotColor: secondColor,
            dotColor: Colors.white,
          ),
          onDotClicked: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
