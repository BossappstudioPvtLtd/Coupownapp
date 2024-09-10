import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final Color? color;
  final TextEditingController? controller;

  const MyTextField({
    super.key,
    this.hintText,
    this.icon,
    this.color,
    this.controller,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        //horizontal: screenWidth * 0.05, // Adjusting the horizontal padding dynamically
        vertical: screenHeight * 0.01,  // Adjusting the vertical padding dynamically
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 10,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, // Dynamic padding for better UI on small screens
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              widget.icon,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
