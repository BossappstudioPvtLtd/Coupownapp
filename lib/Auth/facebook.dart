import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/my_text_field.dart';
import 'package:coupown/components/text_edit.dart';

class Facebook extends StatefulWidget {
  const Facebook({super.key});

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> with SingleTickerProviderStateMixin {
  // Controllers to handle user input for username and password
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Boolean to manage password visibility
  bool _obscurePassword = false;

  // Animation variables
  late AnimationController _controller;
  late Animation<double> fadeInAnimation;
  late Animation<Offset> slideInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    slideInAnimation = Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust text size based on screen width
    double titleFontSize = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Stack(
        children: [
          // Image positioned at the top left
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.05,
            child: FadeTransition(
              opacity: fadeInAnimation,
              child: SlideTransition(
                position: slideInAnimation,
                child: Image.asset(
                  "assets/logo/facebookname.png",
                  height: screenHeight * 0.1,
                  width: screenWidth * 0.3,
                ),
              ),
            ),
          ),
          // Centered content
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        // Text title for the sign-in
                        FadeTransition(
                          opacity: fadeInAnimation,
                          child: SlideTransition(
                            position: slideInAnimation,
                            child: Textedit(
                              text: 'Sign in to Facebook',
                              color: appTextColorPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: titleFontSize,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        // Username TextField
                        FadeTransition(
                          opacity: fadeInAnimation,
                          child: SlideTransition(
                            position: slideInAnimation,
                            child: MyTextField(
                              controller: _usernameController,
                              icon: Icons.person,
                              color: iconColorSecondary,
                              hintText: 'User Id/Email',
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        // Password TextField
                        FadeTransition(
                          opacity: fadeInAnimation,
                          child: SlideTransition(
                            position: slideInAnimation,
                            child: Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(8),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.03),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  FadeTransition(
                    opacity: fadeInAnimation,
                    child: SlideTransition(
                      position: slideInAnimation,
                      child: MyButtonAni(
                        elevationsize: 20,
                        text: "Continue",
                        onTap: () {
                          // Your action here
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
