import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Local%20Service/lacaltab.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/widgets/namebar.dart';
import 'package:flutter/material.dart';


class InstalionServis extends StatefulWidget {
  const InstalionServis({super.key});

  @override
  State<InstalionServis> createState() => _InstalionServisState();
}

class _InstalionServisState extends State<InstalionServis> {
  final List<Map<String, dynamic>> instalionservis = [
    {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Servis/air-conditioners.jpg',
      'name': 'Travels',
      'productname': 'Air Conditioner',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Servis/Television.jpg',
      'name': 'Food',
      'productname': 'Television',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin."
    },
     {
      'logoUrl': 'assets/featurerd/travel.png',
      'productUrl': 'assets/Servis/sofa.jpg',
      'name': 'Travels',
      'productname': 'Furnitures',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "60%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/09/2024",
      "location": "Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Servis/chimini.webp',
      'name': 'chimini',
      'productname': 'Chimini',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Servis/home.jpg',
      'name': 'Home Services',
      'productname': 'Home Services',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin."
    },

     {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Servis/fridge.jpg',
      'name': 'Refrigerator',
      'productname': 'Refrigerator',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin."
    },
    {
      'logoUrl': 'assets/featurerd/collectionfood.png',
      'productUrl': 'assets/Servis/washing.jpg',
      'name': 'washing machine',
      'productname': 'washing machine',
      'price': "2499",
      'offerprice': "1500",
      "percentage": "50%",
      "discretion": "Power jet cleaning of indoor unit air filter, drain tray/ tube, evaporator coil and condenser coil.\nChecking operations of the blower motor, compressor, and fan motor.\nInspection and testing of all controls \n30 days warranty on all services\nPCB Repair or any other component repair or replacement is not covered.\nCustomers need to provide a ladder to the technician.Gas charging is not covered under this service.",
      'rating': "4.5",
      'productlike': 0,
      'isFavorite': false,
      'isPressed': false,
      'count': 0,
      "valid date": "15/08/2024",
      "location": "Tuticorin."
    },

    // Additional items...
  ];

 @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Define different screen size thresholds
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth >= 360 && screenWidth < 600;
    //final isLargeScreen = screenWidth >= 600;

    return Container(height: 250, color: appColorPrimary,
      child: Column(children: [Namebar(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>const TabBarExample()));},
            nametext: "Instalion Service",
            text: 'View all',
            color: appColorAccent,
            icon: Icons.arrow_forward,
            border: Border.all(width: 1, color: appColorAccent),
            iconcolor: appColorAccent,
            iconsize: isSmallScreen ? 14 : (isMediumScreen ? 16 : 18), // Adjust icon size
          ),
          
          // Set height of the ListView
          Expanded( child: ListView.builder(scrollDirection: Axis.horizontal,
              itemCount: instalionservis.length,
              itemBuilder: (context, index) {var item = instalionservis[index];
                return Padding(padding: EdgeInsets.symmetric( horizontal: isSmallScreen ? 2 : (isMediumScreen ? 5 : 8), vertical: isSmallScreen ? 15 : (isMediumScreen ? 20 : 25), ),
                   child: Material(color: appColorPrimary, elevation: 5,
                    shape: const RoundedRectangleBorder( borderRadius: BorderRadius.all(Radius.circular(5)),),
                     child: SizedBox(height: isSmallScreen ? 100 : (isMediumScreen ? 110 : 130),  width: isSmallScreen ? 145 : (isMediumScreen ? 165 : 185),
                      child: Column( crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[ ClipRRect( borderRadius: const BorderRadius.vertical(top: Radius.circular(5)),
                        child: Image.asset( item['productUrl'],fit: BoxFit.fill, width: double.infinity,
                         height: isSmallScreen ? 100 : (isMediumScreen ? 120 : 140), ),),
                          Padding(padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 6 : (isMediumScreen ? 8.0 : 10.0), vertical: isSmallScreen ? 2 : (isMediumScreen ? 4 : 6), ),
                            child: Textedit( text: item['productname'],fontSize: isSmallScreen ? 10 : (isMediumScreen ? 14 : 16),),),
                        ],
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
