import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/add_job_offer.dart';
import 'package:coupown/Screanes/subscription/add_special_offer.dart';
import 'package:coupown/Screanes/subscription/services/booking_service.dart';
import 'package:coupown/Screanes/subscription/services/completed.dart';
import 'package:coupown/Screanes/subscription/services/my_service.dart';
import 'package:coupown/Screanes/subscription/services/today_target.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/service_card.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class ServiceSrean extends StatefulWidget {
  const ServiceSrean({super.key});

  @override
  State<ServiceSrean> createState() => _ServiceState();
}

class _ServiceState extends State<ServiceSrean> {
   
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth > 100;
    double cardWidth = screenWidth > 600 ? 400 : screenWidth * 0.95;
    return    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: SingleChildScrollView(
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
                              
                               
              
                              
                    
                 
                 
                ],
              ),
            ),
          ),
            Row(children: [  Expanded( child:  
                   MyButtonAni(elevationsize: 5, text: "Add Offer",
                  onTap: () {showModalBottomSheet( backgroundColor: appColorPrimary,
                      context: context,
                      isScrollControlled: true, // This allows the bottom sheet to take full height
                      builder: (BuildContext context) {
                return DraggableScrollableSheet(
                  expand: false,
                  initialChildSize: 0.9, // Set to 1.0 for full height
                  minChildSize: 0.5,     // Minimum height when sheet is minimized
                  maxChildSize: 1.0,     // Maximum height for the sheet
                  builder: (BuildContext context, ScrollController scrollController) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Container( width: double.infinity,height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                        padding: const EdgeInsets.all(16.0),
                        child: const Column( crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           MyAppbar(text: "Special Offers" ),
                            // Add your form or offer content here
                           Expanded(child: PostOfferPage())
                
                          ],
                        ),
                      ),
                    );
                  },
                );
                      },
                    );
                  },
                
                
                    
                    ), ),
        
        
        
        
                        Container( width: isSmallScreen ? 142: 138, height: isSmallScreen ? 45 : 40,
                            decoration: BoxDecoration(  border: Border.all(color: appColorAccent, width: 2.0), borderRadius: BorderRadius.circular(32), ),
                            child: Expanded(child: TextButton( onPressed: () {
                                 showModalBottomSheet(backgroundColor: appColorPrimary,
                                    context: context,
                                    isScrollControlled: true, // This allows the bottom sheet to take full height
                                    builder: (BuildContext context) {
                                      return DraggableScrollableSheet(
                                        expand: false,
                                        initialChildSize: 0.9, // Set to 1.0 for full height
                                        minChildSize: 0.5,     // Minimum height when sheet is minimized
                                        maxChildSize: 1.0,     // Maximum height for the sheet
                                        builder: (BuildContext context, ScrollController scrollController) {
                                          return SingleChildScrollView(
                                            controller: scrollController,
                                            child: Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                                              padding: const EdgeInsets.all(16.0),
                                              child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                 MyAppbar(text: "Job Offers" ),
                                                  // Add your form or offer content here
                                                     Expanded(child: AddJobOffer())
                              
                                                      ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                              }, child: const Textedit(color: appColorAccent, text: 'Job Offer'),),
                            ),
                          ),
                        
                      ],
                    ),
          
              const SizedBox(height: 20,)     
              
        ],
      ),
    );
  }
}