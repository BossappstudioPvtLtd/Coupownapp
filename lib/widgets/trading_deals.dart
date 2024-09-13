import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';

class TradingDeals extends StatefulWidget {
  const TradingDeals({super.key});

  @override
  State<TradingDeals> createState() => _TradingDealsState();
}

class _TradingDealsState extends State<TradingDeals> {
  final List<Map<String, dynamic>> deals = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'name': 'Travels',
      'offerDate': '2024-09-10',
      'offerDetails': '20% off on all travel packages'
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'name': 'Groceries',
      'offerDate': '2024-09-10',
      'offerDetails': 'Buy 1 get 1 free on selected items'
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'name': 'Food & Dining',
      'offerDate': '2024-09-11',
      'offerDetails': '15% discount on dinner sets'
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'name': 'Fashion',
      'offerDate': '2024-09-12',
      'offerDetails': '30% off on summer collection'
    },
    {
      'logoUrl': 'assets/featurerd/clapperboard.png',
      'name': 'Entertainment',
      'offerDate': '2024-09-13',
      'offerDetails': '10% off on movie tickets'
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 350; // Adjust based on a small screen threshold

    return Container(
      height: isSmallScreen ? 250 : 300,
      color: const Color.fromARGB(210, 237, 247, 251),
      child: Column(
        children: [
          Namebar(nametext: "Trending Deals" ,text: 'View all',color:appColorAccent,icon: Icons.arrow_forward,border: Border.all(width: 1, color: appColorAccent),iconcolor: appColorAccent,iconsize: 16,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return Container(
                    width: isSmallScreen ? 180 : 250,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 30,
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 5,
                            child: Container(
                              height: isSmallScreen ? 150 : 190,
                              width: isSmallScreen ? 180 : 250,
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: appColorAccent, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                  color: appColorPrimary,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 50),
                                    Row(
                                      children: [
                                        const SmallButton(
                                          elevationsize: 5,
                                          text: "Exclusive Offer",
                                          containerheight: 30,
                                          containerwidth: 110,
                                          fontSize: 15,
                                          textweight: FontWeight.normal,
                                        ),
                                        Flexible(
                                          child: Textedit(
                                            text: ' ${deal['offerDate']}',
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Textedit(
                                        text: deal['offerDetails'],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 2,
                          left: 10,
                          child: Card(
                            color: appColorPrimary,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              height: 50,
                              width: isSmallScreen ? 100 : 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        deal['logoUrl'],
                                        fit: BoxFit.fill,
                                        width: 25,
                                        height: 25,
                                      ),
                                    ),
                                    Expanded(
                                      child: Textedit(
                                        text: deal['name'],
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
