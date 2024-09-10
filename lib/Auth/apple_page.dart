import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/my_text_field.dart';
import 'package:coupown/components/text_edit.dart';

class ApplePage extends StatefulWidget {
  const ApplePage({super.key});

  @override
  State<ApplePage> createState() => _ApplePageState();
}

class _ApplePageState extends State<ApplePage> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
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
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Stack(
        children: [
          // Image positioned at the top left
          Positioned(
            top: 50,
            left: 20,
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: SlideTransition(
                position: _slideInAnimation,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Image.asset(
                        "assets/logo/apple.png",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const Textedit(
                      text: 'Apple ID',
                      color: appTextColorPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Text title for the sign-in
                      FadeTransition(
                        opacity: _fadeInAnimation,
                        child: SlideTransition(
                          position: _slideInAnimation,
                          child: const Textedit(
                            text: 'Use your Apple ID to Sign In to Coupown',
                            color: appTextColorPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Username TextField
                      FadeTransition(
                        opacity: _fadeInAnimation,
                        child: SlideTransition(
                          position: _slideInAnimation,
                          child: MyTextField(
                            controller: _usernameController,
                            color: iconColorSecondary,
                            hintText: 'Email/phone Number',
                          ),
                        ),
                      ),
                      // Password TextField (you can add it if needed)
                      const SizedBox(height: 30),
                      // Sign in Button
                      FadeTransition(
                        opacity: _fadeInAnimation,
                        child: SlideTransition(
                          position: _slideInAnimation,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
