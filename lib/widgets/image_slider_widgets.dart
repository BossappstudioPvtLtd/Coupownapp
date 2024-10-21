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
    "assets/images/banner1.png",
    "assets/images/Banner3.png",
    "assets/images/Banner6.png",
    "assets/images/Banner7.png",
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;final screenHeight = MediaQuery.of(context).size.height;
    return Column( children: [
        CarouselSlider.builder(itemCount: imgList.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            final imgUrl = imgList[index];
            return Container( width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(screenWidth * 0.03),
                boxShadow: [ BoxShadow( color: Colors.black.withOpacity(0.2), spreadRadius: 2,  blurRadius: 5,offset: const Offset(0, 3), // Position of the shadow (x, y)
                  ),
                ],
              ),
              child: ClipRRect(borderRadius: BorderRadius.circular(screenWidth * 0.03),child: Image.asset(imgUrl, fit: BoxFit.fill, width: screenWidth * 0.8, height: screenHeight * 0.3,
                ),
              ),
            );
          },
          options: CarouselOptions( height: screenHeight * 0.2, autoPlay: true,
            enlargeCenterPage: true, enableInfiniteScroll: true,
              initialPage: 0, viewportFraction: 0.8,
                onPageChanged: (index, reason) { setState(() { _currentIndex = index; }); },), ),
                  SizedBox(height: screenHeight * 0.02), 
                    CarouselIndicator(itemCount: imgList.length, currentIndex: _currentIndex, screenWidth: screenWidth,),
      ],
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double screenWidth;

  const CarouselIndicator({ super.key,  required this.itemCount, required this.currentIndex, required this.screenWidth, });
 @override Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(itemCount,
        (int index) => AnimatedContainer( duration: const Duration(milliseconds: 300),width: (index == currentIndex) ? screenWidth * 0.07 : screenWidth * 0.02, // Adjust width based on active index
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
           decoration: BoxDecoration( borderRadius: BorderRadius.circular(screenWidth * 0.01),
            color: (index == currentIndex)  ? appColorAccent  : Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
