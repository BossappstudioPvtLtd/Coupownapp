import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/services/booking_service.dart';
import 'package:coupown/Screanes/subscription/services/completed.dart';
import 'package:coupown/Screanes/subscription/services/my_service.dart';
import 'package:coupown/Screanes/subscription/services/today_target.dart';
import 'package:coupown/components/service_card.dart';
import 'package:flutter/material.dart';

class ServiceSrean extends StatefulWidget {
  const ServiceSrean({super.key});

  @override
  State<ServiceSrean> createState() => _ServiceState();
}

class _ServiceState extends State<ServiceSrean> {
   
  @override
  Widget build(BuildContext context) {
    return    SingleChildScrollView(
      child: Column(
        children: [
                Container(
                  height: 100,
                  color: appColorPrimary,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SserviceCard(text: '20', text1: 'BOOKINGS',onTap:(){Navigator.push(context,MaterialPageRoute(builder: (_)=>const BookingService()));},),
                      SserviceCard(text: '04', text1: 'TODAY TARGET',onTap:(){Navigator.push(context,MaterialPageRoute(builder: (_)=>const TodayTarget()));}),
                      SserviceCard(text: '18', text1: 'COMPLETED',onTap:(){Navigator.push(context,MaterialPageRoute(builder: (_)=>const Completed()));}),
                    ],
                  ),
                ),
      
                       const MyService(),
                                      
      
          //  Expanded(
          //                        child: Padding(
          //                          padding: const EdgeInsets.only(left: 5),
          //                          child: Container(
          //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
          //                           height: 120,
          //                           width: 240,
          //                            child: ListView.builder(
          //                              itemCount: 5,  // Specify the length of the list
          //                              scrollDirection: Axis.horizontal,  // Horizontal scrolling if needed
          //                              itemBuilder: (context, index) {
          //                                return 
                                           
          //                              },
          //                            ),
          //                          ),
          //                        ),
          //                      ),
        ],
      ),
    );
  }
}