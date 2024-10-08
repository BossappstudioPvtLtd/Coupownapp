import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class MyService extends StatefulWidget {
  const MyService({super.key});

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<Map<String, dynamic>> specialOffers = [
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image6.png',
      'name': 'Travels',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "offerpercentage": "20%",
      "coupownoffer": "10",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      "Joboffer": "sales executive",
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": const Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": const Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image8.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "sales executive",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": const Duration(hours: 12),
    },
    {
      'logoUrl': 'assets/avatar/avatar.png',
      'productUrl': 'assets/Special0ffer/image9.png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "Joboffer": "",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "5",
      "discretion": "Power jet cleaning of indoor unit air filter...",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin.",
      "remainingTime": const Duration(hours: 12),
    },
    // Add more offers here
  ];

  List<Timer?> timers = [];

  @override
  void initState() {
    super.initState();
    startTimers();
  }

  void startTimers() {
    for (int i = 0; i < specialOffers.length; i++) {
      timers.add(Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (specialOffers[i]['remainingTime'].inSeconds > 0) {
            specialOffers[i]['remainingTime'] =
                specialOffers[i]['remainingTime'] - const Duration(seconds: 1);
          } else {
            timer.cancel();
          }
        });
      }));
    }
  }

  @override
  void dispose() {
    for (var timer in timers) {
      timer?.cancel();
    }
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
    bool isSmallScreen = screenWidth < 600;
    double cardWidth = screenWidth > 600 ? 400 : screenWidth * 0.95;

    return SizedBox(
      height: 370,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Textedit(
            text: "Populer Offers this weekes",
            fontWeight: FontWeight.bold,
            color: appTextColorPrimary,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: specialOffers.length,
              itemBuilder: (context, index) {
                var deal = specialOffers[index];

                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: cardWidth,
                        height: 360,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Container(
                                height: isSmallScreen ? 200 : 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(deal['productUrl']),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Textedit(
                                    text: deal['productname'],
                                    fontSize: isSmallScreen ? 14 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: appTextColorSecondary,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_month,
                                          size: isSmallScreen ? 16 : 20),
                                      const SizedBox(width: 4),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Offer Valid to ",
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 12 : 14,
                                                color: appTextColorPrimary,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${deal['valid date']}",
                                              style: TextStyle(
                                                fontSize:
                                                    isSmallScreen ? 14 : 16,
                                                color: appDarkRed,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "starts at ",
                                                        style: TextStyle(
                                                          fontSize:
                                                              isSmallScreen
                                                                  ? 12
                                                                  : 14,
                                                          color:
                                                              appTextColorPrimary,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "₹${deal['offerprice']}",
                                                        style: TextStyle(
                                                          fontSize:
                                                              isSmallScreen
                                                                  ? 16
                                                                  : 20,
                                                          color:
                                                              appTextColorPrimary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "₹2099",
                                                style: TextStyle(
                                                  fontSize:
                                                      isSmallScreen ? 14 : 18,
                                                  color: appTextColorPrimary,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "₹${deal['price']}",
                                                style: TextStyle(
                                                  fontSize:
                                                      isSmallScreen ? 12 : 14,
                                                  color: appTextColorPrimary,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Row(
                                            children: [
                                              Icon(Icons.location_on_outlined),
                                              Text("location"),
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              deal['isPressed']
                                                  ? Icons.handshake
                                                  : Icons.handshake,
                                            ),
                                            color: deal['isPressed']
                                                ? Colors.pink
                                                : Colors.grey,
                                            iconSize: isSmallScreen ? 24 : 30,
                                            onPressed: () {
                                              setState(() {
                                                deal['isPressed'] =
                                                    !deal['isPressed'];
                                                deal['count'] +=
                                                    deal['isPressed'] ? 1 : -1;
                                              });
                                            },
                                          ),
                                          Textedit(
                                            text: '${deal['count']}',
                                            fontSize: isSmallScreen ? 16 : 18,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              
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
