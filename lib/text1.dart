import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Const/appwidgets.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DealsOfTheDay extends StatefulWidget {
  const DealsOfTheDay({super.key});

  @override
  State<DealsOfTheDay> createState() => _DealsOfTheDayState();
}

class _DealsOfTheDayState extends State<DealsOfTheDay> {
  final List<Map<String, dynamic>> todatdeal = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Travels',
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      'rating': "4.5",
      "productlike": 0,  // Storing like count here
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Travels',
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      'rating': "4.5",
      "productlike": 0,
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Travels',
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      'rating': "4.5",
      "productlike": 0,
      'isFavorite': false,
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Travels',
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "70%",
      'rating': "4.5",
      "productlike": 0,
      'isFavorite': false,
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

    return Container(
      width: double.infinity,
      height: 450,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
                Textedit(text: formatDuration(remainingTime)),
                const Textedit(text: " remaining"),
              ],
            ),
          ),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 10,
                                child: Container(
                                  width: 100,
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
                                            color: appTextColorPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  deal['isFavorite']
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: deal['isFavorite']
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    deal['isFavorite'] = !deal['isFavorite'];
                                    // Reset countdown on unlike
                                    if (!deal['isFavorite']) {
                                      deal['remainingTime'] = const Duration(hours: 24);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Card(
                          color: appStore.appBarColor,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            onTap: () {},
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    deal['logoUrl'],
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 170,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 150,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(
                                              deal['productname'],
                                              style: boldTextStyle(
                                                size: 20,
                                                color: appStore.textPrimaryColor,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Text(" ${deal['offerprice']}",
                                                style: secondaryTextStyle(
                                                  size: 16,
                                                  color: appStore.textSecondaryColor,
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                Text(
                                                  " ${deal['price']}",
                                                  style: secondaryTextStyle(
                                                    size: 16,
                                                    color: appStore.textSecondaryColor,
                                                  ),
                                                ),
                                                Text(" ${deal['percentage']}".toString(),
                                                    style: boldTextStyle(
                                                      size: 14,
                                                      color: appColorAccent,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Row(
                                              children: List.generate(5, (index) {
                                                if (index < 4) {
                                                  return const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 20.0,
                                                  );
                                                } else if (index == 4) {
                                                  return const Icon(
                                                    Icons.star_half,
                                                    color: Colors.amber,
                                                    size: 20.0,
                                                  );
                                                } else {
                                                  return const Icon(
                                                    Icons.star_border,
                                                    color: Colors.grey,
                                                    size: 20.0,
                                                  );
                                                }
                                              }),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            deal['isFavorite']
                                                ? Icons.handshake
                                                : Icons.handshake_outlined,
                                            color: deal['isFavorite'] ? Colors.green : null,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              // Increase the count on press
                                              deal['productlike']++;
                                              // Change the icon color on like
                                              deal['isFavorite'] = !deal['isFavorite'];
                                            });
                                          },
                                        ),
                                        Text('${deal['productlike']}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
 























                                      