import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Deald%20Of%20The%20Day/deals_view.dart';
import 'package:coupown/Screanes/Deald%20Of%20The%20Day/produvt_deatiles.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart'; // Assuming you're using nb_utils for text styles and padding

class DealsOfTheDay extends StatefulWidget {
  const DealsOfTheDay({super.key});

  @override
  State<DealsOfTheDay> createState() => _DealsOfTheDayState();
}

class _DealsOfTheDayState extends State<DealsOfTheDay> {
  final List<Map<String, dynamic>> todatdeal = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/image 15.png',
      'name': 'Travels',
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
  final isMediumScreen = screenWidth >= 400 && screenWidth <= 600; // Define breakpoint for medium screens
  //final isWideScreen = screenWidth > 600; // Define breakpoint for wide screens

  return SizedBox(
    width: double.infinity,
    height: 420,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Header Section
        Namebar(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>const DealsView()));
          },
          nametext: "Deals Of The Day",
          text: 'View all',
          color: appColorAccent,
          icon: Icons.arrow_forward,
          border: Border.all(width: 1, color: appColorAccent),
          iconcolor: appColorAccent,
          iconsize: isSmallScreen ? 14 : isMediumScreen ? 16 : 18, // Adjust icon size based on screen size
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : isMediumScreen ? 12 : 16),
          child: Row(
            children: [
              const Icon(Icons.alarm),
              Text(formatDuration(remainingTime)),
              const Text(" remaining"),
            ],
          ),
        ),
        // Deal Cards
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Horizontal scrolling
            itemCount: todatdeal.length,
            itemBuilder: (context, index) {
              final deal = todatdeal[index];
              return Padding(
                padding: EdgeInsets.all(isSmallScreen ? 4 : isMediumScreen ? 8 : 12),
                child: SizedBox(
                  width: isSmallScreen ? 200 : isMediumScreen ? 200 : 220, // Adjust width for screen size
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: isSmallScreen ? 4 : isMediumScreen ? 8 : 12),
                              child: Material(
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
                                        padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 4 : isMediumScreen ? 8 : 12),
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
                                      Expanded(
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
                                    ],
                                  ),
                                ),
                              ),
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
                      InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DealDetailPage(deal: deal),
                            ),
                          );
                        },
                        child: Card(
                        
                            elevation: 5,
                          child: Container(
                           
                            height: 280,
                            decoration: BoxDecoration(borderRadius:BorderRadius.circular(16), color: appColorPrimary),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                  child: Image.asset(
                                    deal['productUrl'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height * (isSmallScreen ? 0.2 : isMediumScreen ? 0.22 : 0.25),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 8.0 : isMediumScreen ? 10.0 : 12.0,
                                    vertical: isSmallScreen ? 4.0 : isMediumScreen ? 6.0 : 8.0,
                                  ),
                                  child: Textedit(
                                    text: deal['productname'],
                                    fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                    color: appTextColorPrimary,
                                  ),
                                ),
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
                                              Textedit(
                                                text: "55151555",
                                                fontSize: isSmallScreen ? 8 : isMediumScreen ? 10 : 12,
                                                color: textSecondaryColor,
                                              ),
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
                                const SizedBox(height: 8), // Adjusted for smaller screens
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
