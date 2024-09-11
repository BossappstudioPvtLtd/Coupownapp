import 'dart:async';
import 'package:flutter/material.dart';

class ImageSliderPage extends StatefulWidget {
  // List of image paths
  final List<String> imageUrls = [
    'assets/add/bamm.png',
    'assets/add/Banner8.png',
    'assets/add/Banner6 (1).png',
    'assets/add/Banner 4.png',
    'assets/add/banner1 (1).png',
    'assets/add/Banner2.png',
    'assets/add/Banner6-1.png',
  ];

  ImageSliderPage({super.key});

  @override
  _ImageSliderPageState createState() => _ImageSliderPageState();
}

class _ImageSliderPageState extends State<ImageSliderPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Automatically slide the images every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++; // Move to the next page
      } else {
        _currentPage = 0; // Loop back to the first image
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double sliderHeight = screenWidth * 0.4;

    return SizedBox(
      height: sliderHeight,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding based on screen width
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling
                itemCount: widget.imageUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // Adjust margin based on screen width
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04), // Adjust border radius based on screen width
                      child: Image.asset(
                        widget.imageUrls[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
            // Optionally, you can add indicator dots here
          ],
        ),
      ),
    );
  }
}
