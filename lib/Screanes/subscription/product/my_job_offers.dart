import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';

class MyJobOffers extends StatefulWidget {
  const MyJobOffers({super.key, });

  @override
  State<MyJobOffers> createState() => _MyJobOffersState();
}

class _MyJobOffersState extends State<MyJobOffers> {
  // Define the list of job offers
  final List<Map<String, dynamic>> jobOffers = [
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
      "Joboffer": "Sales Executive",
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
      "Joboffer": "Chef",
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
  final isSmallScreen = screenWidth < 400;
  final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    
      const Textedit(
                text: "Job Offers",fontWeight:FontWeight.bold,fontSize: 16 ,
               
              ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: SizedBox(
          height: isSmallScreen ? 370 : isMediumScreen ? 400 : 450, // Adjust height based on screen size
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: jobOffers.length,
            itemBuilder: (context, index) {
              final deal = jobOffers[index]; // Get the offer
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  
                          height: isSmallScreen ? 310 : isMediumScreen ? 310 : 310, // Adjust container height
                          width: isSmallScreen ? 310 : isMediumScreen ? 310 : 310, // Adjust container width
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: isSmallScreen ? 300 : isMediumScreen ? 300 : 350, // Adjust container height
                          width: isSmallScreen ? 300 : isMediumScreen ? 300 : 350, // Adjust container width
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: deal['productUrl'] != null
                                          ? DecorationImage(
                                              image: AssetImage(deal['productUrl']),
                                              fit: BoxFit.fill,
                                            )
                                          : null,
                                    ),
                                    child: deal['productUrl'] == null
                                        ? Center(
                                            child: Column(
                                              children: [
                                                _buildJobOfferHeader(deal, isSmallScreen),
                                                const SizedBox(height: 5),
                                                _buildLocationRow(deal, isSmallScreen),
                                                const SizedBox(height: 5),
                                                _buildJobTypeButtons(isSmallScreen),
                                                const SizedBox(height: 5),
                                                _buildContactRow(isSmallScreen),
                                              ],
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                _buildJobOfferHeader(deal, isSmallScreen),
                                const SizedBox(height: 5),
                                _buildLocationRow(deal, isSmallScreen),
                                const SizedBox(height: 5),
                                _buildJobTypeButtons(isSmallScreen),
                                const SizedBox(height: 5),
                                _buildContactRow(isSmallScreen),
                                const SizedBox(height: 10),
                              ],
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
  );
}

}
 Row _buildJobOfferHeader(Map<String, dynamic> deal, bool isSmallScreen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        deal['Joboffer'],
        style: TextStyle(
          fontSize: isSmallScreen ? 14 : 18, // Adjust font size
          fontWeight: FontWeight.bold,
          color: appTextColorSecondary,
        ),
      ),
      const Row(
        children: [
          Icon(Icons.share, size: 24),
        ],
      ),
    ],
  );
}

Row _buildLocationRow(Map<String, dynamic> deal, bool isSmallScreen) {
  return Row(
    children: [
      const Icon(Icons.location_on_outlined, size: 20),
      const SizedBox(width: 4),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Location ",
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14, // Adjust font size
                color: appTextColorPrimary,
              ),
            ),
            TextSpan(
              text: "${deal['location']}",
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16, // Adjust font size
                color: appTextColorPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Row _buildJobTypeButtons(bool isSmallScreen) {
  return Row(
    children: [
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green[50]),
        ),
        onPressed: () {},
        child: Text(
          "Full-time",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 12 : 14, // Adjust font size
          ),
        ),
      ),
      const SizedBox(width: 10),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green[50]),
        ),
        onPressed: () {},
        child: Text(
          "Part-time",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 12 : 14, // Adjust font size
          ),
        ),
      ),
    ],
  );
}

Row _buildContactRow(bool isSmallScreen) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SmallButton(
        icon: Icons.phone_in_talk,
        iconcolor: appColorPrimary,
        elevationsize: 5,
        text: "+91 98847 xxxxx ",
        containerheight: 40,
        borderRadius: BorderRadius.circular(8),
        containerwidth: isSmallScreen ? 170 : 160, // Adjust width
      ),
      Text(
        "2 days ago",
        style: TextStyle(color: Colors.black, fontSize: isSmallScreen ? 10 : 12), // Adjust font size
      ),
    ],
  );
}
