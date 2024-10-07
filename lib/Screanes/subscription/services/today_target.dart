import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_icons.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class TodayTarget extends StatefulWidget {
  const TodayTarget({super.key});

  @override
  State<TodayTarget> createState() => _TodayTargetState();
}

class _TodayTargetState extends State<TodayTarget> {
   final List<Map<String, dynamic>> target = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/featurerd/image 15.png',
      'name': 'Travels',
      "phone": "8839824788",
      "productdetails":
          "Feel free to adjust any part to better match your brand or product specifics!",
      'productname': 'Travels',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      "discretion":
          "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "booking date": "15/09/2024",
      "location": "55,Roys Complex,puthukottai,tuticorin Main Road,tuticorin-611111."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/featurerd/image 15 (1).png',
      'name': 'Food',
      "productdetails":
          "Feel free to adjust any part to better match your brand or product specifics!",
      'productname': 'Food Collection',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion":
          "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "booking date": "15/08/2024",
      "location": "Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'productUrl': 'assets/featurerd/image 15 (2).png',
      'name': 'Dinner Set',
      'productname': 'Dinner Set',
      "phone": "4879824788",
      'price': "2499",
      "productdetails":
          "Feel free to adjust any part to better match your brand or product specifics!",
      'offerprice': "1500",
      "percentage": "60%",
      "discretion":
          "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "booking date": "15/07/2024",
      "service date": "15/05/2024",
      "location": "Pudukotte"
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'productUrl': 'assets/featurerd/travel.png',
      'name': 'Store',
      'productname': 'Store Items',
      "phone": "8839824755",
      'price': "2499",
      "productdetails":
          "Feel free to adjust any part to better match your brand or product specifics!",
      'offerprice': "1500",
      "percentage": "70%",
      "discretion":
          "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "booking date": "15/05/2024",
      "service date": "15/05/2024",
      "location": "Tuticorin."
    },
  ];
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              height: 50,
              color: appColorPrimary,
              child: const Row(
                children: [
                  Textedit(
                    text: '4',
                    color: appTextColorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  Textedit(
                    text: ' Today Target',
                    color: appTextColorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: target.length,
                itemBuilder: (context, index) {
                  final item = target[index];
                  return Card(
                    elevation: 5,
                    shadowColor: appColorPrimary,
                          color: appColorPrimary,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
    side: const BorderSide(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(12.0), // Adds curved corners
  ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color:appColorPrimary,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Textedit(text:"Booking Date: ${item['booking date']}",),
                                const SizedBox(height: 10),
                                Row(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Textedit(text: "${item['name']}",fontWeight:FontWeight.bold,fontSize: 12,),
                                    const SizedBox(width: 10,),
                                    const SmallButton( elevationsize: 5,text: "Home",containerheight: 30,containerwidth: 70,meterialColor:appColorPrimary,textcolor:appColorAccent,),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Textedit(text:"Phone: ${item['phone']}",fontWeight:FontWeight.bold,fontSize: 12),
                                const SizedBox(height: 5),
                                Textedit(text: "Service Date: ${item['service date'] ?? 'N/A'}",fontWeight:FontWeight.bold,fontSize: 12),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined),
                                    SizedBox(width: 280,
                          
                                      child: Text( item['location'], maxLines: 5, overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 16,fontWeight:FontWeight.bold ,color: appTextColorSecondary),))
                          
                                  ],
                                ),
                                  
                          
                              ],
                            ),
                          ),
                        ),
                        
            const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.2), // Shadow color with opacity
                                                spreadRadius: 2, // How much the shadow spreads
                                                blurRadius: 5, // Blur intensity of the shadow
                                                offset: const Offset(0, 3), // Position of the shadow (x, y)
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(screenWidth * 0.03),
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                 "assets/images/map.png",
                                                  fit: BoxFit.fill,
                                                  width: screenWidth * 1.40,
                                                  height: screenHeight * 0.20
                                                ),
                                             Center(
                                               child: Padding(
                                                 padding: const EdgeInsets.all(40.0),
                                                 child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment:CrossAxisAlignment.center ,
                                                  
                                                  children: [
                                                  
                              const Text("View Map", style: TextStyle(decoration: TextDecoration.underline, decorationColor:appColorPrimary,color:appColorPrimary,fontSize: 16,fontWeight:FontWeight.bold ),),
                              Material(color: appTxtTintDark_purple,  borderRadius: BorderRadius.circular(16),child:  const MyIcons(icon: Icons.location_on,color:appColorPrimary,))
                            ]
                                                    ),
                                               ),
                                             )
                                              ],
                                            ),
                                          ),
                                        ),
                          ),
                          
            const SizedBox(height: 20),
                      ],
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