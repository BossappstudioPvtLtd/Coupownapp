import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:scale_button/scale_button.dart'; // Import scale_button package

class ImageAdd extends StatefulWidget {
  final String image;
  final void Function()? onTap;
  const ImageAdd({super.key, required this.image, this.onTap});

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Define breakpoints for small screens
        bool isSmallScreen = constraints.maxWidth < 200; // You can adjust the threshold

        return Padding(
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: ScaleButton(
            onTap: widget.onTap,
            child: Material(
              color: appColorPrimary,
              borderRadius: BorderRadius.circular(32),
              elevation: 5,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                width: isSmallScreen ? 70 : 90, // Adjust the width for small screens
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    widget.image,
                    height: isSmallScreen ? 27 : 37, // Adjust height for small screens
                    width: isSmallScreen ? 27 : 37,  // Adjust width for small screens
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
