import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coupown/Const/app_colors.dart'; // Ensure you have this file and it contains appColorAccent

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> imgList = [
    "assets/images/Banner.png",
    "assets/images/Banner1.png",
    "assets/images/Banner3.png",
    "assets/images/Banner6.png",
    "assets/images/Banner7.png",
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: imgList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final imgUrl = imgList[index];
            return Material(
              child: Container(
                width:double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 160.0,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            viewportFraction: 0.8,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10.0),
        CarouselIndicator(
          itemCount: imgList.length,
          currentIndex: _currentIndex,
        ),
      ],
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const CarouselIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (int index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: (index == currentIndex) ? 30 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (index == currentIndex)
                ? appColorAccent // Ensure this color is defined in your app_colors.dart
                : Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
