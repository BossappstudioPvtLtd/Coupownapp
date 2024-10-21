import 'package:coupown/Screanes/love_screen.dart';
import 'package:coupown/Screanes/my_location.dart';
import 'package:coupown/Screanes/notification_screen.dart';
import 'package:coupown/Screanes/subscription/subdata_sceen.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:flutter/material.dart';

class AppbarContainers extends StatelessWidget {
  const AppbarContainers({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if the screen width is considered small (e.g., less than 360 pixels)
    final bool isSmallScreen = screenWidth > 10;

    return Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,size: isSmallScreen ? screenWidth * 0.08 : screenWidth * 0.07, ),
          Row( children: [ SmallButton( containerheight: isSmallScreen ? screenHeight * 0.04 : screenHeight * 0.05,containerwidth: isSmallScreen ? screenWidth * 0.3 : screenWidth * 0.35,
                onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const SubscriptionScreen()));},elevationsize: 5, text: 'Subscribe',),
              IconButton( onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));},
                          icon: Icon(Icons.notifications_none, size: isSmallScreen ? screenWidth * 0.06 : screenWidth * 0.065, ),),
              IconButton( onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>const LoveScreen()));},
                          icon: Icon(Icons.favorite_border, size: isSmallScreen ? screenWidth * 0.06 : screenWidth * 0.065, ), ),
              IconButton( onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const GoogleMapExample())); },
                          icon: Icon( Icons.location_on_outlined, size: isSmallScreen ? screenWidth * 0.06 : screenWidth * 0.065, ),
              ),
            ],
          ),
        ],
      
    );
  }
}
