import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/widgets/adds.dart';
import 'package:coupown/widgets/all_featuers.dart';
import 'package:coupown/widgets/appbar_containers.dart';
import 'package:coupown/widgets/deals_of_the_day.dart';
import 'package:coupown/widgets/image_slider_widgets.dart';
import 'package:coupown/widgets/search_widgets.dart';
import 'package:coupown/widgets/trading_deals.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    //final screenHeight = mediaQuery.size.height;

    // Example thresholds
    final isLargeScreen = screenWidth < 100; // Adjust threshold as needed

    return Scaffold(
      body: Container(
        height: double.infinity,
        color: appColorPrimary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: isLargeScreen ? 60 : 40), // Adjust size for large screens
              const AppbarContainers(),
              SizedBox(height: isLargeScreen ? 25 : 15), // Adjust size for large screens
              const SearchWidgets(),
              SizedBox(height: isLargeScreen ? 25 : 15), // Adjust size for large screens
              const ImageSlider(),
              SizedBox(height: isLargeScreen ? 25 : 15), // Adjust size for large screens
              const AvatarListView(),
              SizedBox(height: isLargeScreen ? 25 : 15), // Adjust size for large screens
              ImageSliderPage(), 
              SizedBox(height: isLargeScreen ? 25 : 15), 
              const TradingDeals(), // Adjust size for large screens
              SizedBox(height: isLargeScreen ? 25 : 15),
              ImageSliderPage(), 
              SizedBox(height: isLargeScreen ? 25 : 15),
              const DealsOfTheDay(),
              ImageSliderPage(), 
              SizedBox(height: isLargeScreen ? 25 : 15),
            ],
          ),
        ),
      ),
    );
  }
}
