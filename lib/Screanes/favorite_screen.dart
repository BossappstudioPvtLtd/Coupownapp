import 'dart:async';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Deald%20Of%20The%20Day/produvt_deatiles.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<Map<String, dynamic>> todatdeal = [
   
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
      "valid date": "15/08/20024",
      "location": "Tuticorin."
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
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/07/20024",
      "location": "Pudukotte"
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
  final isSmallScreen = screenWidth < 400;
  final isMediumScreen = screenWidth >= 600 && screenWidth <= 600;
  return Scaffold(
    backgroundColor: appColorPrimary,
    body: Column(
      children: [
        const SizedBox(height: 30,),
        const Textedit(text: "wishlist",fontSize: 20,fontWeight:FontWeight.bold,),
        const Divider(color: Colors.grey),
       
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
                  child: InkWell(
                     borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DealDetailPage(deal: deal),
                            ),
                          );
                        },
                    child: Container(
                      height: 250,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Material(
                                  borderRadius: BorderRadius.circular(8),
                                  elevation: 2,
                                  child: Container(
                                    height: 210,
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
                                Container(
                                  decoration: BoxDecoration(
                                    color: appColorPrimary,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  width: 162,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Material(
                                              borderRadius: BorderRadius.circular(8),
                                              elevation: 10,
                                              child: Container(
                                                width: 145,
                                                height: isSmallScreen
                                                    ? 40
                                                    : isMediumScreen
                                                        ? 45
                                                        : 50,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: appColorPrimary,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius: BorderRadius.circular(50),
                                                        child: Image.asset(
                                                          deal['logoUrl'],
                                                          width: isSmallScreen ? 20 : isMediumScreen ? 22 : 25,
                                                          height: isSmallScreen ? 20 : isMediumScreen ? 22 : 25,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 5),
                                                        child: Textedit(
                                                          fontSize: isSmallScreen ? 10 : isMediumScreen ? 13 : 14,
                                                          fontWeight: FontWeight.bold,
                                                          color: appTextColorSecondary,
                                                          text: deal['name'],
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: Icon(
                                                          deal['isFavorite']
                                                              ? Icons.favorite_border
                                                              : Icons.favorite,
                                                          color: deal['isFavorite'] ? Colors.grey : Colors.red,
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          deal['productname'],
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 18 : isMediumScreen ? 13 : 14,
                                            color: appTextColorPrimary,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Container(
                                          height: 67,
                                          color: appColorPrimary,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Text(
                                              '${deal['productdetails']}',
                                              style: TextStyle(
                                                fontSize: isSmallScreen ? 16 : 12,
                                                color: iconColorSecondary,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: isSmallScreen ? 8.0 : isMediumScreen ? 10.0 : 12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Textedit(
                                                  text: "₹${deal['offerprice']}",
                                                  fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                                  color: appTextColorPrimary,
                                                  fontWeight: FontWeight.bold,
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
                                                    Text(
                                                      "₹${deal['price']}",
                                                      style: TextStyle(
                                                        fontSize: isSmallScreen ? 10 : isMediumScreen ? 12 : 13,
                                                        color: Colors.grey,
                                                        decoration: TextDecoration.lineThrough,
                                                      ),
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
                                                    deal['isPressed']
                                                        ? Icons.handshake
                                                        : Icons.handshake,
                                                    size: isSmallScreen ? 18 : isMediumScreen ? 19 : 20,
                                                    color: deal['isPressed'] ? Colors.grey : Colors.pink,
                                                  ),
                                                  onPressed: () {
                                                   
                                                     showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text("Confirmation"),
        content: Text(deal['isPressed'] 
            ?  "Do you want to decrease the count?"
            :"Do you want to increase the count?" ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          CupertinoDialogAction(
            child: Text("OK"),
            onPressed: () {
               setState(() {
                   deal['isPressed'] = !deal['isPressed'];
                   deal['count'] += deal['isPressed'] ? 1 : -1;
                                                    });
              Navigator.of(context).pop(); // Dismiss the dialog
              // Additional actions can be added here if necessary
            },
          ),
        ],
      );
    },
  );
                                                    
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
                                ),
                              ],
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.location_on_outlined, size: 27),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Textedit(
                                      fontSize: isSmallScreen ? 12 : isMediumScreen ? 13 : 14,
                                      fontWeight: FontWeight.bold,
                                      color: appTextColorSecondary,
                                      text: deal['location'],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
