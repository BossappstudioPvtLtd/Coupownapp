import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/widgets/adds.dart';
import 'package:coupown/widgets/all_featuers.dart';
import 'package:coupown/widgets/appbar_containers.dart';
import 'package:coupown/widgets/deals_of_the_day.dart';
import 'package:coupown/widgets/exlusive_offers.dart';
import 'package:coupown/widgets/image_slider_widgets.dart';
import 'package:coupown/widgets/instalion_servis.dart';
import 'package:coupown/widgets/search_widgets.dart';
import 'package:coupown/widgets/spacial_offers.dart';
import 'package:coupown/widgets/trading_deals.dart';
import 'package:coupown/widgets/upcoming_offers.dart';
import 'package:coupown/components/fade_slideani.dart'; // Import animations
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Example thresholds
    final isLargeScreen = screenWidth < 100; // Adjust threshold as needed

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: appColorPrimary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: isLargeScreen ? 60 : 40),
              FadeTransition(
                opacity: _fadeSlideAnimation.fadeInAnimation,
                child: SlideTransition(
                  position: _fadeSlideAnimation.slideInAnimation,
                  child: const AppbarContainers(),
                ),
              ),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const SearchWidgets(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const ImageSlider(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const AvatarListView(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const TradingDeals(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const DealsOfTheDay(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const SpacialOffers(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const ExclusiveOffers(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const UpcomingOffers(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(),
              SizedBox(height: isLargeScreen ? 25 : 15),
              const InstalionServis(),
              SizedBox(height: isLargeScreen ? 25 : 15),
            ],
          ),
        ),
      ),
    );
  }
}
