import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:rating_summary/rating_summary.dart';

class TradingScrean extends StatefulWidget {
  final List<Map<String, dynamic>> deals;

  const TradingScrean({super.key, required this.deals, 
  required Map<String, dynamic> deal});

  @override
  _TradingScreanState createState() => _TradingScreanState();
}

class _TradingScreanState extends State<TradingScrean>
    with SingleTickerProviderStateMixin {
  List<bool> isExpandedList = [];

  @override
  void initState() {
    super.initState();

    // Initialize the expanded state for each deal
    isExpandedList = List.generate(widget.deals.length, (index) => true);
  }

  void toggleExpand(int index) {
    setState(() {
      isExpandedList[index] = !isExpandedList[index];
    });
  }

 @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 400;
   
   // final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
  

  return Scaffold(
    backgroundColor: appColorPrimary,
    body: 
        Column(
          children: [
             Padding(
                padding: const EdgeInsets.only(top: 30),
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
                        text: 'Trading Details',
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 18 : 24,
                      ),
                    ),
                  ],
                ),
              ),
              
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: widget.deals.length,
                  itemBuilder: (context, index) {
                    final deal = widget.deals[index];
                    bool isExpanded = isExpandedList[index];
                    
                  //  final dealName = deal['name'] ?? 'No Name';
                    final productUrl = deal['productUrl'] ?? 'assets/placeholder.png';
                    final productName = deal['productname'] ?? 'Unnamed Product';
                    final offerDetails = deal['offerDetails'] ?? 'No offer details';
                 //   final price = deal['price']?.toString() ?? 'N/A';
                 //   final offerPrice = deal['offerprice']?.toString() ?? 'N/A';
                 //   final rating = deal['rating']?.toString() ?? 'No Rating';
                    
                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => toggleExpand(index),
                      child: AnimatedContainer(
          margin: EdgeInsets.symmetric(
            horizontal: isExpanded ? 25 : 0,
            vertical: 20,
          ),
          padding: EdgeInsets.all(20),
          height: isExpanded ? 150 : 500, // Change the height based on isExpanded
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1200),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blueAccent),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 211, 211, 211).withOpacity(0.5),
                blurRadius: 10,
                offset: Offset(5, 10),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(isExpanded ? 8 : 0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 240,
                      child: Text(
                        offerDetails,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 16 : 18,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                     RotationTransition(
                       turns: AlwaysStoppedAnimation(isExpanded ? 0.0 : 0.5),
                       child: GestureDetector(onTap: () {
                         
                       },child: Icon(Icons.share, color: Colors.grey, size: 27)),
                     ),
                  ],
                ),
                SizedBox(height: isExpanded ? 0 : 20),
                Column(
                  children: [
              //        Card(
              //   child: Container(
              //     height: isSmallScreen ? 80 : 100,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     width: double.infinity,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(
              //           horizontal: isSmallScreen ? 8 : 10),
              //       child: Row(
              //         children: [
              //           CircleAvatar(
              //             radius:
              //                 isSmallScreen ? 30 : (isMediumScreen ? 37 : 40),
              //             backgroundColor: appColorAccent,
              //             child: CircleAvatar(
              //               backgroundColor: appLight_purple,
              //               radius:
              //                   isSmallScreen ? 29 : (isMediumScreen ? 36 : 39),
              //               child: CircleAvatar(
              //                 radius: isSmallScreen
              //                     ? 26
              //                     : (isMediumScreen ? 33 : 36),
              //                 backgroundColor: appColorPrimary,
              //                 backgroundImage: AssetImage(deal['logoUrl']),
              //                 child: ClipOval(
              //                   child: Image.asset(
              //                     deal['logoUrl'],
              //                     fit: BoxFit.fill,
              //                     width: isSmallScreen
              //                         ? 50
              //                         : (isMediumScreen ? 60 : 70),
              //                     height: isSmallScreen
              //                         ? 50
              //                         : (isMediumScreen ? 60 : 70),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(width: isSmallScreen ? 8 : 15),
              //           Expanded(
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   deal['name'],
              //                   style: TextStyle(
              //                     fontSize: isSmallScreen ? 18 : 24,
              //                     fontWeight: FontWeight.bold,
              //                     color: appTextColorSecondary,
              //                   ),
              //                 ),
              //                 Text(
              //                   '18 Locations',
              //                   style: TextStyle(
              //                     fontSize: isSmallScreen ? 8 : 10,
              //                     fontWeight: FontWeight.bold,
              //                     color: appTextColorSecondary,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(width: isSmallScreen ? 8 : 15),
              //           Icon(Icons.share, size: isSmallScreen ? 20 : 24),
              //           IconButton(
              //             icon: Icon(
              //               deal['isFavorite']
              //                   ? Icons.favorite
              //                   : Icons.favorite_border,
              //               color:
              //                   deal['isFavorite'] ? Colors.red : Colors.grey,
              //               size: isSmallScreen ? 24 : 30,
              //             ),
              //             onPressed: () {
              //               setState(() {
              //                 deal['isFavorite'] = !deal['isFavorite'];
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
                    AnimatedCrossFade(
                      firstChild: SizedBox(),
                      secondChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: SizedBox(
                              height: isSmallScreen ? 150 : 200,
                              width: isSmallScreen ? 150 : 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(productUrl, fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productName,
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 18 : 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month, size: isSmallScreen ? 16 : 20),
                                  const SizedBox(width: 4),
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Offer Valid to ",
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 12 : 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "${deal['valid date']}",
                                          style: TextStyle(
                                            fontSize: isSmallScreen ? 14 : 16,
                                            color: Colors.red,
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
                                      TextSpan(children: [
                                          TextSpan( text: "Starts at ",style: TextStyle(
                                              fontSize: isSmallScreen ? 12 : 14, color: Colors.black,
                                            ),
                                          ),
                                          TextSpan( text: "₹${deal['offerprice']}",
                                            style: TextStyle(fontSize: isSmallScreen ? 16 : 20,
                                              color: Colors.black,  fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text("₹2099",
                                    style: TextStyle(   fontSize: isSmallScreen ? 14 : 18, color: Colors.black, decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("₹${deal['price']}", style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14, color: Colors.black,decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                              // Add more details here...
                            ],
                          ),
                           Row(  children: [Icon(Icons.location_on_outlined, size: isSmallScreen ? 16 : 20),
                              const SizedBox(width: 4),
                              Text.rich(  TextSpan(
                                  children: [TextSpan(text: "Location ",
                                      style: TextStyle(  fontSize: isSmallScreen ? 12 : 14,
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
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Row(
                                      children: [
                                        Icon(Icons.alarm,
                                            color: Colors.white),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.all(8.0),
                                        //   child: Text(
                                        //     formatDuration(remainingTime),
                                        //     style: const TextStyle(
                                        //         color: Colors.white),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                   const SizedBox(width: 4),
                                Text(
                                  "${deal['rating']}",
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
                                         deal['isPressed']
                                              ? Icons.handshake
                                              : Icons.handshake,
                                        ),
                                        color: deal['isPressed']
                                            ? Colors.pink
                                            : Colors.grey,
                                        iconSize: isSmallScreen
                                            ? 24
                                            : 30, // Adjust icon size for small screens
                                        onPressed: () {
                                          setState(() {
                                         deal['isPressed'] =
                                             deal['isPressed'];
                                          deal['count'] +=
                                                deal['isPressed']
                                                    ? 1
                                                    : -1;
                                          });
                                        },
                                      ),
                                      Text( '${deal['count']}',  style: TextStyle(   fontSize: isSmallScreen ? 16
                                              : 18, // Adjust font size for small screens
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),
                          Text( "${deal['discretion']}",
                                  style: TextStyle(fontSize: isSmallScreen ? 14 : 16,
                                  ),
                                ),
                                 SizedBox( height: 50, ), const 
                              Textedit(text: "Rating & Riviews",fontWeight: FontWeight.bold,),
                               Material(   borderRadius: BorderRadius.circular(8),
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
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 1200),
                      reverseDuration: Duration.zero,
                      sizeCurve: Curves.fastLinearToSlowEaseIn,
                    ),
                  ],
                ),
              ],
            ),
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
