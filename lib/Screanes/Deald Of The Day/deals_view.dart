import 'dart:async';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DealsView extends StatefulWidget {
  const DealsView({super.key});

  @override
  State<DealsView> createState() => _DealsViewState();
}

class _DealsViewState extends State<DealsView> {
  final List<Map<String, dynamic>> todatdeal = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/image 15.png',
      'name': 'Travels',
      "productdetails":"Feel free to adjust any part to better match your brand or product specifics!",
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0, // Separate count for each 
      "valid date":"15/09/20024",
      
      "location":"Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      
      "productdetails":"Feel free to adjust any part to better match your brand or product specifics!",
      'productname': 'Food Collection',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
       "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      
      "valid date":"15/08/20024",
      
      "location":"Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'productUrl': 'assets/featurerd/image 15 (2).png',
      'name': 'Dinner Set',
      'productname': 'Dinner Set',
      'price': "2499",
      
      "productdetails":"Feel free to adjust any part to better match your brand or product specifics!",
      'offerprice': "1500",
      "percentage": "60%",
       "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
     
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      
      "valid date":"15/07/20024",
      "location":"Pudukotte"
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Store',
      'productname': 'Store Items',
      'price': "2499",
      
      "productdetails":"Feel free to adjust any part to better match your brand or product specifics!",
      'offerprice': "1500",
      "percentage": "70%",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
     
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      
      "valid date":"15/05/20024",
      
      "location":"Tuticorin."
    },
  ];



  late Timer _timer;

  Duration remainingTime = const Duration(hours: 24); // 24-hour countdown

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
  
 @override
Widget build(BuildContext context) {
  
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 400; // Define your breakpoint for small screens
  final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
  return Scaffold(
    backgroundColor: appColorPrimary,
    body: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: MyAppbar(text: "Deals Of The Day"),
        ),
        const Divider(color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              const Icon(Icons.alarm),
              Text(formatDuration(remainingTime)),
              const Text(" remaining"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: todatdeal.length,
            itemBuilder: (context, index) {
              final deal = todatdeal[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 220,
                    width: 330,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Material(
                              borderRadius: BorderRadius.circular(8),
                              elevation: 2,
                              child: Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(deal['productUrl']),
                                    fit: BoxFit.fill,
                                    
                                  ),
                                ),
                              ),
                            ),
                            
                             Column(
                               children: [
                                 Row(
                                   children: [
                                     Material(
                                        borderRadius: BorderRadius.circular(8),
                                        elevation: 10,
                                        child: Container(
                                          height: isSmallScreen ? 40 : isMediumScreen ? 45 : 50, // Adjust height for screen size
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: appColorPrimary,
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 10 : isMediumScreen ? 8 : 12),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Image.asset(
                                                    deal['logoUrl'],
                                                    width: isSmallScreen ? 20 : isMediumScreen ? 22 : 25,
                                                    height: isSmallScreen ? 20 : isMediumScreen ? 22 : 25,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    deal['name'],
                                                    style: TextStyle(
                                                      fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: appTextColorSecondary,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                              ),
                                              IconButton(
                            icon: Icon(
                              deal['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                              color: deal['isFavorite'] ? Colors.red : Colors.grey,
                              size: isSmallScreen ? 20 : isMediumScreen ? 22 : 24,
                            ),
                            onPressed: () {
                              setState(() {
                                deal['isFavorite'] = !deal['isFavorite'];
                              });
                            },
                          ),
                                            ],
                                          ),
                                        ),
                                      ),
                                   ],
                                 ),
                                 Textedit(
                                    text: deal['productname'],
                                    fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                    color: appTextColorPrimary,
                                  ),
                                  
                                  //  Text(
                                  //    deal['productdetails'],
                                  //  style: TextStyle(
                                  //    fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                  //   color: appTextColorPrimary,
                                    
                                  //  ),
                                  // ),
                                 Padding(
                                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8.0 : isMediumScreen ? 10.0 : 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Textedit(
                                            text: "₹${deal['offerprice']}",
                                            fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                            color: Colors.green,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "₹${deal['price']}",
                                                style: TextStyle(
                                                  fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                                  color: Colors.grey,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Textedit(
                                                text: "${deal['percentage']} OFF",
                                                fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                                color: appDarkRed,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: List.generate(5, (ratingIndex) {
                                                  return Icon(
                                                    ratingIndex < 4 ? Icons.star : Icons.star_half,
                                                    color: Colors.amber,
                                                    size: isSmallScreen ? 14 : isMediumScreen ? 15 : 16,
                                                  );
                                                }),
                                              ),
                                              const SizedBox(width: 4),
                                             
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              deal['isPressed'] ? Icons.handshake : Icons.handshake,
                                              size: isSmallScreen ? 18 : isMediumScreen ? 19 : 20,
                                              color: deal['isPressed'] ? Colors.pink : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                deal['isPressed'] = !deal['isPressed'];
                                                deal['count'] += deal['isPressed'] ? 1 : -1;
                                              });
                                            },
                                          ),
                                          Textedit(
                                            text: '${deal['count']}',
                                            fontSize: isSmallScreen ? 10 : isMediumScreen ? 12 : 14,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                               ],
                             ),

                          ],
                          
                          
                        ),
                       
                        // Add more fields as needed
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
}