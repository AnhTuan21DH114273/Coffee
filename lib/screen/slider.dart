import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  final coffeeSlide = [
    Image.asset("assets/images/Slider_1.jpg",),
    Image.asset("assets/images/Slider_2.jpg",),
    Image.asset("assets/images/Slider_3.jpg",),
    Image.asset("assets/images/Slider_4.jpg",),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: 500,
              height: 140,
              child: CarouselSlider(
                items: coffeeSlide,
                options: CarouselOptions(
                    height: 550,
                    autoPlay: true,
                    enableInfiniteScroll: false,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index))),
            ),
            
            buildIndicator()
          ],
        ),
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: const SlideEffect(dotColor: Color(0xFFD9D9D9), activeDotColor: Color(0xFFB2AFAF)),
        activeIndex: activeIndex,
        count: coffeeSlide.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
