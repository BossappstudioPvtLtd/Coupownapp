import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Exclusive/exclusive_Screan.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:flutter/material.dart';

class ExclusiveView extends StatefulWidget {
  const ExclusiveView({super.key});

  @override
  State<ExclusiveView> createState() => _ExclusiveViewState();
}
 List<Map<String, dynamic>> exclusiveOffers = [
    {
      'logoUrl': 'assets/exclusive/WhatsApp.jpeg',
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
      'logoUrl': 'assets/exclusive/WhatsApp4.jpeg',
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
      'logoUrl': 'assets/exclusive/WhatsApp3.jpeg',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      'productname': 'Adventure Explore the World',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "30%",
      "offerpercentage": "10%",
      "coupownoffer": "100",
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
      'logoUrl': 'assets/exclusive/WhatsApp.jpeg',
      'productUrl': 'assets/featurerd/image 15.png',
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
       'logoUrl': 'assets/exclusive/WhatsApp4.jpeg',
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
     'logoUrl': 'assets/exclusive/WhatsApp1.jpeg',
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
      'logoUrl': 'assets/exclusive/WhatsApp1.jpeg',
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

 class _ExclusiveViewState extends State<ExclusiveView> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: MyAppbar(text: "Exclusive Offers"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: exclusiveOffers.length,
              itemBuilder: (context, index) {
                var deal = exclusiveOffers[index];
                return InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExclusiveScrean(deal: deal),
                            ),
                          );
                        },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                    elevation: 5,
                     borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: isSmallScreen ? 100 : isWideScreen ? 150 : 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Material(
                                color: appColorPrimary,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 5,
                                child: Container(
                                  height: isSmallScreen ? 50 : 60,
                                  width: isSmallScreen ? 80 : 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: AssetImage(deal['logoUrl']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(deal['name'],style: TextStyle(fontSize: isSmallScreen ? 14 : 16,fontWeight: FontWeight.bold,), ),
                                  Text(deal['productname'],style: TextStyle(fontSize: isSmallScreen ? 12 : 14,),),
                                   Column(children: [ const SizedBox(height: 10), // Add spacing between the text and animation
                                    AnimatedTextKit(totalRepeatCount: 100,
                                    animatedTexts: [  ColorizeAnimatedText("Upto ${deal['offerpercentage']} Cashback",
                                    textStyle: const TextStyle( fontSize: 16.0,fontWeight: FontWeight.bold, ),
                                     colors: [ Colors.grey, Colors.grey, Colors.white, Colors.black, Colors.black,],),], isRepeatingAnimation: true,),
                                   ],
                                 )
                  
                  
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${deal['coupownoffer']} ",
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 12 : 14,
                                          color: appTextColorPrimary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Offers",
                                        style: TextStyle(
                                          fontSize: isSmallScreen ? 12 : 14,
                                          color:appColorAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
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

