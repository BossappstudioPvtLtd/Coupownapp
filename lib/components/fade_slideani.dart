import 'package:flutter/material.dart';

class FadeSlideAnimation {
  final AnimationController controller;
  late final Animation<double> fadeInAnimation;
  late final Animation<Offset> slideInAnimation;

  FadeSlideAnimation(this.controller) {
    fadeInAnimation = Tween<double>(begin: 0.1, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    slideInAnimation = Tween<Offset>(begin: const Offset(0, 0.9), end: Offset.zero).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }
}
