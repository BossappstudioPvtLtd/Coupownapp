import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Upcoming%20offers/upcoming_screen.dart';
import 'package:coupown/Screanes/Upcoming%20offers/upcoming_view.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpcomingOffers extends StatefulWidget {
  const UpcomingOffers({super.key});

  @override
  State<UpcomingOffers> createState() => _UpcomingOffersState();
}

class _UpcomingOffersState extends State<UpcomingOffers> {
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
    // Add more offers as needed
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Define what you consider a small screen

    return Container(
      color:appColorPrimary,
      height: isSmallScreen ? 250 : 300,
      width: double.infinity,
      child: Column(
        children: [
          Namebar( onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_)=>const UpcomingView()));},
            nametext: "Upcoming Offers",
            text: 'View all',
            color: appColorAccent,
            icon: Icons.arrow_forward,
            border: Border.all(width: 1, color: appColorAccent),
            iconcolor: appColorAccent,
            iconsize: isSmallScreen ? 14 : 16, // Adjust icon size for small screens
          ),
          Expanded(
            child: ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: exclusiveOffers.length,
              itemBuilder: (context, index) {
                final deal = exclusiveOffers[index];
                return InkWell( borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {Navigator.push( context, MaterialPageRoute(builder: (context) => UpcomingScreen(deal: deal),),);},
                  child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Material( borderRadius: BorderRadius.circular(8),elevation: 10,
                      child: Container( height: isSmallScreen ? 200 : 240,
                        width: isSmallScreen ? 290 : 350,
                          decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(8), ),
                              child: Row(children: [ Padding( padding: const EdgeInsets.all(8.0),
                                child: Material(color: const Color.fromARGB(255, 232, 248, 247), borderRadius: BorderRadius.circular(8), elevation: 5,
                                  child: Container(  height: isSmallScreen ? 40 : 50, width: isSmallScreen ? 80 : 90,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage( image: AssetImage(deal['logoUrl']),fit: BoxFit.fill,),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: Padding(padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                                  children: [ Textedit( text: deal['productname'], fontWeight: FontWeight.bold,fontSize: isSmallScreen ? 14 : 16,),
                                    SizedBox(height: isSmallScreen ? 4 : 8),
                                    Text('${deal['discretion']}\nNext line content here nNext line content here',
                                      style: TextStyle(fontSize: isSmallScreen ? 14 : 17,color: Colors.grey[600],),
                                      maxLines: 5, overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: isSmallScreen ? 16 : 20),
                                    Padding(padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
                                      child: SmallButton( borderRadius: BorderRadius.circular(8),
                                        containerheight: isSmallScreen ? 35 : 40,elevationsize: isSmallScreen ? 8 : 10,text: 'GET COUPOWN',
                                        onTap: (){showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return Center(child: Padding(padding: const EdgeInsets.all(25),
                  child: Stack(children: [Container(decoration: BoxDecoration(color: appColorPrimary,
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
            });},
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
