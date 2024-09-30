import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';

class TradingDealsScrean extends StatefulWidget {
  const TradingDealsScrean({super.key});

  @override
  State<TradingDealsScrean> createState() => _TradingDealsScreanState();
}

 final List<Map<String, dynamic>> tradingdeals = [
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

class _TradingDealsScreanState extends State<TradingDealsScrean> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;

    return Scaffold(
      body: Container(
        color: appColorPrimary,
        child: Column(
          children: [
            const SizedBox(height: 30,),
               Padding(
                 padding: const EdgeInsets.only(left: 15),
                 child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      iconSize: isSmallScreen ? 20 : 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Textedit(
                        text: 'Trading deals',
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 18 : 24,
                      ),
                    ),
                  ],
                           
                           ),
               ),
            Expanded(
              child: ListView.builder(
                itemCount: tradingdeals.length,
                itemBuilder: (context, index) {
                  final deal = tradingdeals[index];
                  
                  return Container(
                    color: appColorPrimary,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            child: Container(
                              height: isSmallScreen ? 80 : 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 8 : 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: isSmallScreen ? 30 : (isMediumScreen ? 37 : 40),
                                      backgroundColor: appColorAccent,
                                      child: CircleAvatar(
                                        backgroundColor: appLight_purple,
                                        radius: isSmallScreen ? 29 : (isMediumScreen ? 36 : 39),
                                        child: CircleAvatar(
                                          radius: isSmallScreen ? 26 : (isMediumScreen ? 33 : 36),
                                          backgroundColor: appColorPrimary,
                                          backgroundImage: AssetImage(deal['logoUrl']),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: isSmallScreen ? 8 : 15),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        
                                        children: [
                                          Text(
                                            deal['name'],
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 18 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: appTextColorSecondary,
                                            ),
                                          ),
                                          Text(
                                            '18 Locations',
                                            style: TextStyle(
                                              fontSize: isSmallScreen ? 8 : 10,
                                              fontWeight: FontWeight.bold,
                                              color: appTextColorSecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: isSmallScreen ? 8 : 15),
                                    Icon(Icons.share, size: isSmallScreen ? 20 : 24),
                                    IconButton(
                                      icon: Icon(
                                        deal['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                                        color: deal['isFavorite'] ? Colors.red : Colors.grey,
                                        size: isSmallScreen ? 24 : 30,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          deal['isFavorite'] = !deal['isFavorite'];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Material(
                            borderRadius: BorderRadius.circular(8),
                            elevation: 10,
                            child: Container(
                              height: isSmallScreen ? 200 : 250,
                              width: double.infinity,
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: appColorAccent, width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                  color: appColorPrimary,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 50),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: SmallButton(
                                        elevationsize: 5,
                                        text: "Exclusive Offer",
                                        containerheight: 30,
                                        containerwidth: 140,
                                        fontSize: 15,
                                        textweight: FontWeight.normal,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Textedit(
                                        text: deal['offerDetails'],
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Textedit(
                                            text: "8 Users Today",
                                            fontSize: 12,
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Textedit(
                                              text: "VIEW DETAILS",
                                              color: appColorAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
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
