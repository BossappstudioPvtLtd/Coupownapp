import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ticket_clippers/ticket_clippers.dart';

class CoupownScreen extends StatefulWidget {
   const CoupownScreen({super.key});

  @override
  State<CoupownScreen> createState() => _CoupownScreenState();
}

class _CoupownScreenState extends State<CoupownScreen> {
  // Exclusive offers data
  final List<Map<String, dynamic>> exclusiveOffers = [
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
   
    // Add other offers...
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
    
    return Scaffold(
      backgroundColor:const Color.fromARGB(255, 243, 244, 252),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [ const SizedBox(height: 30,),
                const Textedit( text: "Coupowns",fontWeight:FontWeight.bold ,),
                const SizedBox(height: 10,),
                 Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColorAccent // Red color for the button
                  ),
                  child: const Text(
                    "Red Button",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20), // Space between buttons
              Flexible(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white, // Text color for white button
                  ),
                  child: const Text("        Past        "),
                ),
              ),
            ],
          ),
        
      
    
    

SizedBox(
      height: 570, // Specify the height of the ListView
      child: ListView.builder(
        itemCount: exclusiveOffers.length,
        itemBuilder: (context, index) {
          final deal = exclusiveOffers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Align(
                    child: TicketClipper(
                      clipper: TicketRoundedEdgeClipper(
                        edge: Edge.horizontal,
                        position: 70,
                        radius: 40,
                      ),
                      shadowRadius: ShadowRadius.circular(8),
                      shadow: const BoxShadow(color: Colors.transparent),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: 140,
                            width: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: appColorPrimary,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: isSmallScreen ? 32 : (isMediumScreen ? 37 : 40),
                                    backgroundColor: appColorAccent,
                                    child: CircleAvatar(
                                      backgroundColor: appLight_purple,
                                      radius: isSmallScreen ? 30 : (isMediumScreen ? 36 : 39),
                                      child: CircleAvatar(
                                        radius: isSmallScreen ? 28 : (isMediumScreen ? 33 : 36),
                                        backgroundColor: appColorPrimary,
                                        backgroundImage: AssetImage(deal['logoUrl']!),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 1),
                                  child: SizedBox(
                                    width: 2,
                                    child: CustomPaint(
                                      painter: DottedLinePainter(),
                                      child: const SizedBox(height: double.infinity),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          deal['name']!,
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 18 : 24,
                                            fontWeight: FontWeight.bold,
                                            color: appTextColorSecondary,
                                          ),
                                        ),
                                        Text(
                                          deal['location']!,
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 10,
                                            fontWeight: FontWeight.bold,
                                            color: appTextColorSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          'Valid Until: ${deal["valid date"]}',
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 10,
                                            fontWeight: FontWeight.bold,
                                            color: appTextColorSecondary,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Material(
                      borderRadius: BorderRadius.circular(8),
                      elevation: 10,
                      color: appColorPrimary,
                      shadowColor: appColorPrimary,
                      child: Container(
                        height: isSmallScreen ? 150 : 250,
                        width: double.infinity,
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: appColorPrimary,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
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
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Textedit(
                                  text: "deal['offerDetails'],",
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
                                      onPressed: () => _showCupertinoDialog(context),
                                      child: const Text(
                                        "VIEW CoupOwn",
                                        style: TextStyle(
                                          color: appColorAccent,
                                          decoration: TextDecoration.underline,
                                          decorationColor: appColorAccent,
                                        ),
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
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      
    




      )
)
              ]
            )
          
          ),
        ),
      ),
    );
  }
}



class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 5, startY = 0;
    final paint = Paint()
      ..color = Colors.grey // Customize the color if needed
      ..strokeWidth = 2; // Customize the thickness if needed

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

 void _showCupertinoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(

          
          content: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [ const Spacer(),IconButton( onPressed: () {  Navigator.of(context).pop(); }, icon:Icon(Icons.close,) )],),
                const Textedit( text: 'Tarce fashions',),
                
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.location_solid),
                    SizedBox(width: 8),
                    Text('puthukottai'),
                  ],
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'assets/featurerd/qrcode.png', // Replace with your image URL
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                ),
                
                
                
                
                
              
                const Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User Name",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "sankaran"),
                    SizedBox(height: 5,),
                    Text("Offer Start",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "apr 01.2024"),
                    
                    SizedBox(height: 5,),
                    Text("Actual Price",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "₹4999 ")

                  ],),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Phone Number ",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "91 98413 xxxxx"),
                       SizedBox(height: 5,),
                    Text("Offer End",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "apr 25.2024") ,
                    
                       SizedBox(height: 5,),
                    Text("Offer Price",style: TextStyle(color: appTextColorSecondary),), Textedit(text: "₹3999"),
                  ],
                )
                ],),
                   SizedBox(height: 20,),

                 SmallButton(elevationsize: 10, text: "Coupown Pricw ₹2499",containerwidth:200 ,containerheight: 40,borderRadius: BorderRadius.circular(8),),
          
              ],
            ),
          ),
          
                              
          

          
        );
      },
    );
  }
