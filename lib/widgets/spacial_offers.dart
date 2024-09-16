import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SpacialOffers extends StatefulWidget {
  const SpacialOffers({super.key});

  @override
  State<SpacialOffers> createState() => _SpacialOffersState();
}

class _SpacialOffersState extends State<SpacialOffers> {
  List<Map<String, dynamic>> specialOffers = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/image 15.png',
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
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin.",
      "remainingTime": Duration(hours: 24),
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
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
      "remainingTime": Duration(hours: 12),
    },
     {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
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
      "remainingTime": Duration(hours: 12),
    },
     {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
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
      "remainingTime": Duration(hours: 12),
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

  return Container(
    height: isSmallScreen ? 450 : 500, // Adjust container height for small screens
    width: double.infinity,
    color: const Color.fromARGB(210, 237, 247, 251),
    child: Column(
      children: [
        Namebar(
          nametext: "Special Offers",
          text: 'View all',
          color: appColorAccent,
          icon: Icons.arrow_forward,
          border: Border.all(width: 1, color: appColorAccent),
          iconcolor: appColorAccent,
          iconsize: isSmallScreen ? 14 : 16, // Adjust icon size for small screens
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: isSmallScreen ? 370 : 420, // Adjust list height for small screens
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: specialOffers.length,
            itemBuilder: (context, index) {
              var deal = specialOffers[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: cardWidth,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                               radius: isSmallScreen ? 21 : 31,
                                backgroundColor: appColorAccent,
                              child: CircleAvatar(
                                radius: isSmallScreen ? 20 : 30, // Adjust avatar size
                                backgroundColor: appColorAccent,
                                child: CircleAvatar(
                                  backgroundColor: appLight_purple,
                                  radius: isSmallScreen ? 28 : 38,
                                  backgroundImage: AssetImage(deal['logoUrl']),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    deal['name'],
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 18,
                                      fontWeight: FontWeight.bold,
                                      color: appTextColorSecondary,
                                    ),
                                  ),
                                  Text(
                                    '18 Locations',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 10 : 12,
                                      fontWeight: FontWeight.bold,
                                      color: appTextColorSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.share, size: 24),
                            IconButton(
                              icon: Icon(
                                deal['isFavorite']
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: deal['isFavorite']
                                    ? Colors.red
                                    : Colors.grey,
                                size: 24,
                              ),
                              onPressed: () {
                                setState(() {
                                  deal['isFavorite'] = !deal['isFavorite'];
                                });
                              },
                            ),
                          ],
                        ),
                        Container(
                          height: isSmallScreen ? 150 : 200, // Adjust image height
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(deal['productUrl']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Textedit(
                          text: deal['productname'],
                          fontSize: isSmallScreen ? 14 : 18,
                          fontWeight: FontWeight.bold,
                          color: appTextColorSecondary,
                        ),
                        Row(
                          children: [
                            Material(
                              color: appDarkRed,
                              borderRadius: BorderRadius.circular(32),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    const Icon(Icons.alarm, color: Colors.white),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        formatDuration(deal['remainingTime']),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "${deal['rating']}",
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                              ),
                            ),
                            Icon(Icons.star, color: Colors.amber, size: isSmallScreen ? 20 : 24),
                            Text("|", style: TextStyle(fontSize: isSmallScreen ? 14 : 16, color: Colors.grey)),
                            Text("130", style: TextStyle(fontSize: isSmallScreen ? 14 : 16)),
                            Text("Ratings", style: TextStyle(fontSize: isSmallScreen ? 10 : 12)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      deal['percentage'],
                                      style: TextStyle(
                                          fontSize: isSmallScreen ? 20 : 24,
                                          color: appTextColorPrimary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      deal['offerpercentage'],
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 16 : 20,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      deal['coupownoffer'],
                                      style: TextStyle(
                                          fontSize: isSmallScreen ? 14 : 18,
                                          decoration: TextDecoration.lineThrough),
                                    ),
                                    const SizedBox(width: 10),
                                    const Textedit(
                                      text: "OFF",
                                      color: appTextColorPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined),
                                    Textedit(
                                      text: deal['location'],
                                      fontSize: isSmallScreen ? 12 : 14,
                                      color: appTextColorPrimary,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    deal['isPressed'] ? Icons.handshake : Icons.handshake,
                                  ),
                                  color: deal['isPressed'] ? Colors.pink : Colors.grey,
                                  iconSize: isSmallScreen ? 24 : 30, // Adjust icon size for small screens
                                  onPressed: () {
                                    setState(() {
                                      deal['isPressed'] = !deal['isPressed'];
                                      deal['count'] += deal['isPressed'] ? 1 : -1;
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
