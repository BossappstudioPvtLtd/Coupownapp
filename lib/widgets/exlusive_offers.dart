import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';

class ExclusiveOffers extends StatefulWidget {
  const ExclusiveOffers({super.key});

  @override
  State<ExclusiveOffers> createState() => _ExclusiveOffersState();
}

class _ExclusiveOffersState extends State<ExclusiveOffers> {
  List<Map<String, dynamic>> exclusiveOffers = [
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
      "remainingTime":  const Duration(hours: 12),
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
      "remainingTime": const Duration(hours: 12),
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
      "remainingTime": const Duration(hours: 12),
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
      "remainingTime": const Duration(hours: 12),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Namebar(
          nametext: "Exclusive Offers",
          text: 'View all',
          color: appColorAccent,
          icon: Icons.arrow_forward,
          border: Border.all(width: 1, color: appColorAccent),
          iconcolor: appColorAccent,
          iconsize: 16, // Adjust icon size for small screens
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: exclusiveOffers.length,
            itemBuilder: (context, index) {
              final deal = exclusiveOffers[index];
              final cardWidth = screenWidth * 0.5; // Adjust card width based on screen size
              final imageWidth = cardWidth * 0.8; // Adjust image width based on card width

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color: appColorPrimary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: cardWidth,
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        Material(
                          color: appColorPrimary,
                          borderRadius: BorderRadius.circular(8),
                          elevation: 5,
                          child: Container(
                            height: 100,
                            width: imageWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 60, // Adjust image height
                                width: imageWidth * 0.3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(deal['productUrl'] ?? deal['logoUrl']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            deal['name'] ?? 'No name',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmallButton(
                            borderRadius: BorderRadius.circular(8),
                            containerheight: 30,
                            elevationsize: 10,
                            text: 'Upto ${deal['percentage']} Offers',
                          ),
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
    );
  
  }
}
