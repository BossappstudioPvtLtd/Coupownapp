import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Trading/trading_screan.dart';
import 'package:coupown/Screanes/Trading/trading_viewall.dart';
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
      'productname': 'Travels',
      'offerDate': '2024-09-10',
      'productUrl': 'assets/featurerd/image 15.png',
      "valid date":"15/09/20024",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      "location":"Tuticorin.",
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0,
      'offerDetails': '20% off on all travel packages'
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'name': 'Groceries',
      'offerDate': '2024-09-10',
      'offerDetails': 'Buy 1 get 1 free on selected items',
      'productUrl': 'assets/featurerd/image 15.png',
     
      "valid date":"15/09/20024",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      "location":"Tuticorin.",
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
       'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0,
   
    },
    {
      'logoUrl': 'assets/featurerd/dinnerset.png',
      'name': 'Food & Dining',
      'offerDate': '2024-09-11',
      'offerDetails': '15% discount on dinner sets',
      'productUrl': 'assets/featurerd/image 15.png',
     
      "valid date":"15/09/20024",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      "location":"Tuticorin.",
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
       'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0,
   
    },
    {
      'logoUrl': 'assets/featurerd/store.png',
      'name': 'Fashion',
      'offerDate': '2024-09-12',
      'offerDetails': '30% off on summer collection',
      'productUrl': 'assets/featurerd/image 15.png',
     
      "valid date":"15/09/20024",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      "location":"Tuticorin.",
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
       'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0,
   
    },
    {
      'logoUrl': 'assets/featurerd/clapperboard.png',
      'name': 'Entertainment',
      'offerDate': '2024-09-13',
      'offerDetails': '10% off on movie tickets',
      'productUrl': 'assets/featurerd/image 15.png',
     
      "valid date":"15/09/20024",
      "discretion":"Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service. \nAn additional cost of ₹2500 is applicable if gas charging is required.Pre-service check-up: Our technician shall inspect the AC thoroughly, including gas pressure, and recommend services or repairs as required.Indoor Unit cleaning: The technician shall do deep cleaning of filters, coil, fins, and drain trays with a power jet.\nOutdoor Unit cleaning: The outdoor unit will be opened for thorough cleaning with a power jet.\nHassle-free experience: The technician will cover the AC with jacket to prevent spillage during the service and clean the area post-serviceFinal check-up: The technician shall ensure the proper functioning of the AC at the end of service.",
      "location":"Tuticorin.",
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
       'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false, // Separate pressed state for each deal
      'count': 0,
   
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
          Namebar(nametext: "Trending Deals" ,text: 'View all',color:appColorAccent,icon: Icons.arrow_forward,border: Border.all(width: 1, color: appColorAccent),iconcolor: appColorAccent,iconsize: 16,
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_)=>const TradingDealsScrean()));},),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return GestureDetector(onTap: () {
                    Navigator.push(context, MaterialPageRoute( builder: (context) => TradingScrean( deal: deal,  deals: deals, ),
                     ),
                      );
                        },
                    child: Container(
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
