import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Upcoming%20offers/upcoming_screen.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcomingView extends StatefulWidget {
  const UpcomingView({super.key});

  @override
  State<UpcomingView> createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
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
      "remainingTime": const Duration(hours: 24),
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
      "remainingTime": const Duration(hours: 24),
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
    // Add more offers as needed
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Define what you consider a small screen

    return Scaffold(
      body: Container(
        color:appColorPrimary,
        width: double.infinity,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10,left: 10,),
              child: MyAppbar(text: "Upcoming Offers"),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: exclusiveOffers.length,
                itemBuilder: (context, index) {
                  final deal = exclusiveOffers[index];
                  return InkWell(
                     borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpcomingScreen(deal: deal),
                            ),
                          );
                        },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      
                        child: Material(
                          color: appColorPrimary,
                              borderRadius: BorderRadius.circular(8),
                              
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              height: isSmallScreen ? 190 : 240,
                              width: isSmallScreen ? 280 : 350,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      color: const Color.fromARGB(255, 232, 248, 247),
                                      borderRadius: BorderRadius.circular(8),
                                      elevation: 5,
                                      child: Container(
                                        height: isSmallScreen ? 40 : 50,
                                        width: isSmallScreen ? 80 : 90,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: AssetImage(deal['logoUrl']),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Textedit(
                                            text: deal['productname'],
                                            fontWeight: FontWeight.bold,
                                            fontSize: isSmallScreen ? 14 : 16,
                                          ),
                                          SizedBox(height: isSmallScreen ? 4 : 8),
                                          Text(
                                            '${deal['discretion']}\nNext line content here nNext line content here',
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 14 : 17,
                                              color: Colors.grey[600],
                                            ),
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: isSmallScreen ? 16 : 20),
                                          Padding(
                                            padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                                            child: SmallButton(
                                              meterialColor: Colors.green,
                                              borderRadius: BorderRadius.circular(8),
                                              containerheight: isSmallScreen ? 35 : 40,
                                              elevationsize: isSmallScreen ? 8 : 10,
                                              text: 'GET COUPOWN',
                                              onTap: () {
                                                showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return Center(child: Padding(padding: const EdgeInsets.all(25),
                  child: Stack(children: [
                  Container(decoration: BoxDecoration(color: appColorPrimary,
                  borderRadius: BorderRadius.circular(8),),height: 300, width: 400,),
                  Positioned(top: 10,  right: 10,  // Adjust as needed
                  child: IconButton(icon: const Icon(Icons.close), color: Colors.black,  // Icon color
                  onPressed: () {  },
            ),
           ),
         ],
       )


                ),
              );
            });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
      ),
    );
  }
}
