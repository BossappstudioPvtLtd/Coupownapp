import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:coupown/widgets/produvt_deatiles.dart';
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
    final isSmallScreen = screenWidth < 500;

    return Container(
      width: double.infinity,
      height: 450,
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Header Section
            Namebar(
            nametext: "Deals Of The Day",
            text: 'View all',
            color: appColorAccent,
            icon: Icons.arrow_forward,
            border: Border.all(width: 1, color: appColorAccent),
            iconcolor: appColorAccent,
            iconsize: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 210, // Set a fixed width for each card
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 10,
                                child: Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: appColorPrimary,
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(
                                            deal['logoUrl'],
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          deal['name'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: appTextColorSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Favorite Icon
                            IconButton(
                              icon: Icon(
                                deal['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: deal['isFavorite']
                                    ? Colors.red
                                    : Colors.grey,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  deal['isFavorite'] = !deal['isFavorite'];
                                });
                              },
                            ),
                          ],
                        ),
                        // Deal Card
                        // InkWell(
                        //     borderRadius: const BorderRadius.all(Radius.circular(16)),
                        //     onTap: () {
                        //       // Navigate to the detail page
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => DealDetailPage(deal: deal),
                        //         ),
                        //       );
                        //     },
                        InkWell(
                          borderRadius:BorderRadius.all(Radius.circular(16)),
                          onTap:() {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                   builder: (context) => DealDetailPage(deal: deal),
                                 ),
                               );
                          },
                          child: Card(
                            color: appColorPrimary,
                            elevation: 2,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            ),
                            child: InkWell(
                              borderRadius: const BorderRadius.all(Radius.circular(16)),
                              onTap: () { Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DealDetailPage(deal: deal),
                                ),
                              );
                            },
                              child: Column(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      deal['productUrl'],
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: 170,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 100),
                                    child: Textedit(
                                      text: deal['productname'],
                                      fontSize:18 ,
                                      color: appTextColorPrimary,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("₹${deal['offerprice']}",
                                              style: secondaryTextStyle(
                                                  size: 16, color: Colors.green)),
                                          Row(
                                            children: [
                                              Text("₹${deal['price']}",
                                                  style: secondaryTextStyle(size: 14, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                                                  SizedBox(width: 10,),
                                                       Text("₹${deal['price']}", style: secondaryTextStyle(size: 10, color: Colors.grey, decoration: TextDecoration.lineThrough)),
                                                       SizedBox(width: 10,),
                                                      
                                                        SizedBox(width: 10,),
                                              Text("${deal['percentage']} OFF", style: boldTextStyle(size: 14, color: Colors.red)),
                                              
                                            ],
                                          ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 16),
                                                      child: Row(
                                                      children: List.generate(5, (ratingIndex) {
                                                      return Icon(
                                                        
                                                      ratingIndex < 4
                                                          ? Icons.star
                                                          : Icons.star_half,
                                                      color: Colors.amber,
                                                      size: 16,
                                                        );
                                                                                                }),
                                                                                              
                                                                                              ),
                                                    ),
                                                    Textedit(text: "55151555",color:textSecondaryColor ,fontSize: 10,)
                                                  ],
                                                ),
                          
                                        ],
                                      ),
                                      // Rating and Like Button
                                      Column(
                                        children: [
                                        
                                          IconButton(
                                            icon: Icon(
                                              deal['isPressed']
                                                  ? Icons.handshake
                                                  : Icons.handshake_outlined,
                                            ),
                                            color: deal['isPressed']
                                                ? Colors.pink
                                                : Colors.grey,
                                            iconSize: 20.0,
                                            onPressed: () {
                                              setState(() {
                                                deal['isPressed'] = !deal['isPressed'];
                                                deal['count'] += deal['isPressed'] ? 1 : -1;
                                              });
                                            },
                                          ),
                                          Text(
                                            '${deal['count']}',
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
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
