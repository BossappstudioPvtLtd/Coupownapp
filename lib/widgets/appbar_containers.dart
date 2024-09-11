import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class AppbarContainers extends StatelessWidget {
  const AppbarContainers({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03), // Dynamically adjust horizontal padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the container in the center horizontally
        children: [
          Icon(Icons.menu, size: screenWidth * 0.07), // Adjust icon size based on screen width
          Row(
            children: [
              SmallButton(
                containerheight: screenHeight * 0.05, // Adjust button height based on screen height
                containerwidth: screenWidth * 0.25, // Adjust button width based on screen width
                onPressed: () {
                  // Add your subscription logic here
                },
                elevationsize: 5,
                text: 'Subscribe',
              ),
              Icon(Icons.notifications_none, size: screenWidth * 0.065), // Adjust icon size
              SizedBox(width: screenWidth * 0.03), // Dynamically adjust spacing
              Icon(Icons.favorite_border, size: screenWidth * 0.065), // Adjust icon size
              SizedBox(width: screenWidth * 0.03), // Dynamically adjust spacing
              Icon(Icons.location_on_outlined, size: screenWidth * 0.065), // Adjust icon size
            ],
          ),
        ],
      ),
    );
  }
}
