import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_summary/rating_summary.dart';

class DealDetailPage extends StatefulWidget {
  final Map<String, dynamic> deal;

  const DealDetailPage({super.key, required this.deal});

  @override
  _DealDetailPageState createState() => _DealDetailPageState();
}

class _DealDetailPageState extends State<DealDetailPage> {
  
  late Map<String, dynamic> deal; // Local mutable copy of widget.deal
  Duration remainingTime = const Duration(hours: 24); // 24-hour countdown
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    deal = Map.from(widget.deal); // Create a mutable copy of widget.deal
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime = remainingTime - const Duration(seconds: 1);
        });
      } else {
        _timer.cancel(); // Stop the timer when countdown reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
   // final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 10 : 20,
            vertical: isSmallScreen ? 15 : 35,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
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
                        text: 'Deals Of The Day',
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 18 : 24,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Container(
                  height: isSmallScreen ? 80 : 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 8 : 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius:
                              isSmallScreen ? 30 : (isMediumScreen ? 37 : 40),
                          backgroundColor: appColorAccent,
                          child: CircleAvatar(
                            backgroundColor: appLight_purple,
                            radius:
                                isSmallScreen ? 29 : (isMediumScreen ? 36 : 39),
                            child: CircleAvatar(
                              radius: isSmallScreen
                                  ? 26
                                  : (isMediumScreen ? 33 : 36),
                              backgroundColor: appColorPrimary,
                              backgroundImage: AssetImage(deal['logoUrl']),
                              child: ClipOval(
                                child: Image.asset(
                                  deal['logoUrl'],
                                  fit: BoxFit.fill,
                                  width: isSmallScreen
                                      ? 50
                                      : (isMediumScreen ? 60 : 70),
                                  height: isSmallScreen
                                      ? 50
                                      : (isMediumScreen ? 60 : 70),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 8 : 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            deal['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                deal['isFavorite'] ? Colors.red : Colors.grey,
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
              Card(
                color: Colors.white,
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SizedBox(
                          height: isSmallScreen ? 150 : 200,
                          width: isSmallScreen ? 150 : 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              deal['productUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal['productname'],
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month,
                                  size: isSmallScreen ? 16 : 20),
                              const SizedBox(width: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Offer Valid to ",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12 : 14,
                                        color: appTextColorPrimary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${deal['valid date']}",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 14 : 16,
                                        color: appDarkRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "starts at ",
                                        style: TextStyle(
                                          fontSize:
                                              isSmallScreen ? 12 : 14,
                                          color: appTextColorPrimary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "₹${deal['offerprice']}",
                                        style: TextStyle(
                                          fontSize:
                                              isSmallScreen ? 16 : 20,
                                          color: appTextColorPrimary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "₹2099",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 18,
                                  color: appTextColorPrimary,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "₹${deal['price']}",
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 12 : 14,
                                  color: appTextColorPrimary,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined,
                                  size: isSmallScreen ? 16 : 20),
                              const SizedBox(width: 4),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Location ",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 12 : 14,
                                        color: appTextColorPrimary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "${deal['location']}",
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 14 : 16,
                                        color: appTextColorPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Material(
                                  color: appDarkRed,
                                  borderRadius: BorderRadius.circular(32),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.alarm,
                                            color: Colors.white),
                                        Padding(
                                          padding:
                                              const EdgeInsets.all(8.0),
                                          child: Text(
                                            formatDuration(remainingTime),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                   const SizedBox(width: 4),
                                Text(
                                  "${widget.deal['rating']}",
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                  ),
                                ),
                                Icon(Icons.star,
                                    color: Colors.amber,
                                    size: isSmallScreen ? 20 : 24),
                                Text(
                                  "|",
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "130 ",
                                  style: TextStyle(
                                      fontSize: isSmallScreen ? 14 : 16),
                                ),
                                Text(
                                  "Ratings",
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 10 : 12,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 15),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          widget.deal['isPressed']
                                              ? Icons.handshake
                                              : Icons.handshake,
                                        ),
                                        color: widget.deal['isPressed']
                                            ? Colors.pink
                                            : Colors.grey,
                                        iconSize: isSmallScreen
                                            ? 24
                                            : 30, // Adjust icon size for small screens
                                        onPressed: () {
                                          setState(() {
                                            widget.deal['isPressed'] =
                                                !widget.deal['isPressed'];
                                            widget.deal['count'] +=
                                                widget.deal['isPressed']
                                                    ? 1
                                                    : -1;
                                          });
                                        },
                                      ),
                                      Text(
                                        '${widget.deal['count']}',
                                        style: TextStyle(
                                          fontSize: isSmallScreen
                                              ? 16
                                              : 18, // Adjust font size for small screens
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                                  "${widget.deal['discretion']}",
                                  style: TextStyle(
                                    fontSize: isSmallScreen ? 14 : 16,
                                  ),
                                ),
                      
                       const SizedBox( height: 50, ), const 
                              Textedit(text: "Rating & Riviews",fontWeight: FontWeight.bold,),
                               Material(
                                
                                    borderRadius: BorderRadius.circular(8),
                                elevation: 5,
                                 child: Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  color:appColorPrimary,
                                    border: Border.all(color:const Color.fromARGB(224, 211, 211, 211))
                                    
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                    child: RatingSummary(
                                      counter: 13,
                                      average: 4.5,
                                      counterFiveStars: 5,
                                      counterFourStars: 4,
                                      counterThreeStars: 2,
                                      counterTwoStars: 1,
                                      counterOneStars: 1,
                                    ),
                                  ),
                                         
                                       ),
                               ),
                            
                       const SizedBox( height: 50, ),
                          
                        ],
                      
                        
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
       floatingActionButton: Container
       (
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        width: 150, 
        height: 40,// Set the desired width here
        child: FloatingActionButton(
          onPressed: () {
            // Add your action here
            showCupertinoModalPopup(context: context, builder: (BuildContext context){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Stack(
  children: [
    Container(
      decoration: BoxDecoration(
        color: appColorPrimary,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 300,
      width: 400,
    ),
    Positioned(
      top: 10,  // Adjust as needed
      right: 10,  // Adjust as needed
      child: IconButton(
        icon: const Icon(Icons.close),  // Change the icon as needed
        color: Colors.black,  // Icon color
        onPressed: () {
          // Define what happens when the button is pressed
        },
      ),
    ),
  ],
)


                ),
              );
            });
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text('Floating Action Button Pressed!')),
            // );
          },
          child: Textedit(text: "Save Coupown",color:appColorPrimary,),
          backgroundColor:appColorAccent,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center the button at the bottom
    );
  }
}
