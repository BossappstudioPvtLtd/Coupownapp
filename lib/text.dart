import 'package:coupown/components/fade_slideani.dart';
import 'package:flutter/material.dart';
// Import the animations file

class YourWidget extends StatefulWidget {
  const YourWidget({super.key});

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> with SingleTickerProviderStateMixin {
  late final FadeSlideAnimation _fadeSlideAnimation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeSlideAnimation = FadeSlideAnimation(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeSlideAnimation.fadeInAnimation,
      child: SlideTransition(
        position: _fadeSlideAnimation.slideInAnimation,
        child: const Text("data"),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
