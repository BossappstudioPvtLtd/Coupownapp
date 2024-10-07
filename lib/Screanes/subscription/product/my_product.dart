import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/add_job_offer.dart';
import 'package:coupown/Screanes/subscription/add_special_offer.dart';
import 'package:coupown/Screanes/subscription/product/my_job_offers.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/service_card.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
   List<Map<String, dynamic>> specialOffers = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Special0ffer/image1.png',
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
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Special0ffer/Image2.png',
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
  ];
  
  @override
  Widget build(BuildContext context) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth > 100;

    // Adjust font sizes and layout for different screen sizes
    
    double cardWidth = screenWidth > 600 ? 400 : screenWidth * 0.95;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SserviceCard(text: '20', text1: 'BOOKINGS',onTap: (){},),
                    SserviceCard(text: '04', text1: 'TODAY TARGET',onTap: (){},),
                    SserviceCard(text: '18', text1: 'COMPLETED',onTap: (){},),
                  ],
                ),
          const Textedit(text:  "Special Offers",fontWeight:FontWeight.bold ,),
                 SizedBox( height: isSmallScreen? 330: 420, // Adjust list height for small screens
                 width: double.infinity,
                 child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 itemCount: specialOffers.length,
                 itemBuilder: (context, index) {var deal = specialOffers[index];
                 return InkWell( borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {},
                        child: Padding( padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(width: cardWidth, height: 300,
                      decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8),),
                           child: Padding(padding: const EdgeInsets.all(10.0),
                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
          const SizedBox(height: 10),
                                  Container( height: isSmallScreen ? 150 : 200, width: double.infinity,
                                  decoration: BoxDecoration( borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage( image: AssetImage(deal['productUrl']), fit: BoxFit.fill,),
                                  ),
                                ),
                                 Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [ SizedBox(width: 260,
                                       child:  Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                                               Textedit(text: deal['productname'],fontSize: isSmallScreen ? 14 : 18,fontWeight: FontWeight.bold,color: appTextColorSecondary,),
                                               Row(children: [ Icon(Icons.calendar_month,  size: isSmallScreen ? 16 : 20),
                                        const SizedBox(width: 4),
                                               Text.rich( TextSpan( children: [
                                                          TextSpan(  text: "Offer Valid to ", style: TextStyle( fontSize: isSmallScreen ? 12 : 14, color: appTextColorPrimary,), ),
                                                          TextSpan( text: "${deal['valid date']}", style: TextStyle(fontSize: isSmallScreen ? 14 : 16, color: appDarkRed,fontWeight: FontWeight.bold,),),],),),
                                                          ],),
                                               Row(children: [Text("${deal['rating']}", style: TextStyle( fontSize: isSmallScreen ? 14 : 16,),),
                                                  Icon(Icons.star, color: Colors.amber, size: isSmallScreen ? 20 : 24),
                                                  Text("|",style: TextStyle( fontSize: isSmallScreen ? 14 : 16,color: Colors.grey)),
                                                  Text("130", style: TextStyle(fontSize: isSmallScreen ? 14 : 16)),
                                                  Text("Ratings", style: TextStyle( fontSize: isSmallScreen ? 10 : 12)),
                                                ],
                                                                             ),
                                             ],
                                           ), ),
                                     
                                     PopupMenuButton<String>( color: appColorPrimary, onSelected: (value) {
      
                                     switch (value) { case 'Edit': print("Edit clicked"); break;
                                                      case 'Share': print("Share clicked");break;
                                                      case 'Unpublish': print("Unpublish clicked");break;
                                                      case 'Delete': print("Delete clicked");break;}},
                                                      itemBuilder: (BuildContext context) {
                                              return [
                              const PopupMenuItem<String>( value: 'Edit', child: ListTile(leading: Icon(Icons.edit), title: Text('Edit'), ),),
                              const PopupMenuItem<String>( value: 'Share',child: ListTile(leading: Icon(Icons.share),title: Text('Share'),),),
                              const PopupMenuItem<String>( value: 'Unpublish',child: ListTile(leading: Icon(Icons.unpublished),title: Text('Unpublish'),), ),
                              const PopupMenuItem<String>( value: 'Delete', child: ListTile(leading: Icon(Icons.delete),title: Text('Delete'), ),),
                                           ];
                                         },
                                       ),
                                    ],
                                 ),
                                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [Column(  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [ Row(
                                  children: [Text( deal['percentage'], style: TextStyle(fontSize: isSmallScreen ? 20 : 24,color: appTextColorPrimary, fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 10),
                                            Text( deal['offerpercentage'], style: TextStyle( fontSize: isSmallScreen ? 16 : 20, decoration:TextDecoration.lineThrough,),),
                                      const SizedBox(width: 10),
                                            Text( deal['coupownoffer'],style: TextStyle( fontSize: isSmallScreen ? 14 : 18,decoration:TextDecoration.lineThrough),),
                                      const SizedBox(width: 10),
                                      const Textedit(text: "OFF",color: appTextColorPrimary,fontWeight: FontWeight.bold,), ],
                                        ),
                                        Row(children: [const Icon(Icons.location_on_outlined),
                                            Textedit( text: deal['location'],fontSize: isSmallScreen ? 12 : 14,color: appTextColorPrimary,)
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(children: [IconButton( 
                                                  icon: Icon( deal['isPressed'] ? Icons.handshake : Icons.handshake,),
                                                 color: deal['isPressed']? Colors.pink : Colors.grey,iconSize: isSmallScreen ? 24 : 30,
                                             onPressed: () { setState(() {deal['isPressed'] = !deal['isPressed']; deal['count'] +=deal['isPressed'] ? 1 : -1;});},),
                                        Textedit( text: '${deal['count']}', fontSize: isSmallScreen ? 16 : 18,
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
                    );
                  },
                ),
              ),
              
              const MyJobOffers(),

             Row(children: [  Expanded( child:  
               MyButtonAni(elevationsize: 5, text: "Add Offer",
              onTap: () {showModalBottomSheet( backgroundColor: appColorPrimary,
                  context: context,
                  isScrollControlled: true, // This allows the bottom sheet to take full height
                  builder: (BuildContext context) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.9, // Set to 1.0 for full height
              minChildSize: 0.5,     // Minimum height when sheet is minimized
              maxChildSize: 1.0,     // Maximum height for the sheet
              builder: (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container( width: double.infinity,height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                    padding: const EdgeInsets.all(16.0),
                    child: const Column( crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       MyAppbar(text: "Special Offers" ),
                        // Add your form or offer content here
                       Expanded(child: PostOfferPage())
            
                      ],
                    ),
                  ),
                );
              },
            );
                  },
                );
              },
            
            
                
                ), ),




                    Container( width: isSmallScreen ? 142: 138, height: isSmallScreen ? 45 : 40,
                        decoration: BoxDecoration(  border: Border.all(color: appColorAccent, width: 2.0), borderRadius: BorderRadius.circular(32), ),
                        child: Expanded(child: TextButton( onPressed: () {
                             showModalBottomSheet(backgroundColor: appColorPrimary,
                                context: context,
                                isScrollControlled: true, // This allows the bottom sheet to take full height
                                builder: (BuildContext context) {
                                  return DraggableScrollableSheet(
                                    expand: false,
                                    initialChildSize: 0.9, // Set to 1.0 for full height
                                    minChildSize: 0.5,     // Minimum height when sheet is minimized
                                    maxChildSize: 1.0,     // Maximum height for the sheet
                                    builder: (BuildContext context, ScrollController scrollController) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        child: Container(width: double.infinity, height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                                          padding: const EdgeInsets.all(16.0),
                                          child: const Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                             MyAppbar(text: "Job Offers" ),
                                              // Add your form or offer content here
                                                 Expanded(child: AddJobOffer())
                          
                                                  ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                          }, child: const Textedit(color: appColorAccent, text: 'Job Offer'),),
                        ),
                      ),
                    
                  ],
                ),
      
      
        ],
      ),
    );





































             



  }
}