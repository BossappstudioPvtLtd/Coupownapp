import 'dart:async';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/Job/job_screen.dart';
import 'package:coupown/Screanes/spacial/spacial_screan.dart';
import 'package:coupown/components/jobeoffer.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class FeaturesTab extends StatefulWidget {
  final Map<String, dynamic> deal;

  const FeaturesTab({super.key, required this.deal});

  @override
  State<FeaturesTab> createState() => _FeaturesTabState();
}

class _FeaturesTabState extends State<FeaturesTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    
   // startTimers();
  }

  @override
  void dispose() {
    _tabController.dispose();
      for (var timer in timers) {
      timer?.cancel();
    }
    super.dispose();
  }
  
  List<Timer?> timers = [];



  

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
    bool isSmallScreen = screenWidth < 600;
    double cardWidth = screenWidth > 600 ? 400 : screenWidth * 0.95;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:appColorPrimary,
        title: Text(widget.deal['name'] ,),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Flight'),
            Tab(text: 'Hotel'),
            Tab(text: 'Bus'),
            Tab(text: 'Train'),
            Tab(text: 'Cab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildListView('All'),
          buildListView('Flight'),
          buildListView('Hotel'),
          buildListView('Bus'),
          buildListView('Train'),
          buildListView('Cab'),
        ],
      ),
    );
  }

  // Helper method to build ListView based on the type of deal
  Widget buildListView(String type) {
    
    final screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth > 100;
    double cardWidth = screenWidth > 600 ? 400 : screenWidth * 0.95;
    List<dynamic> items = widget.deal[type] ?? [];

    if (items.isEmpty) {
      return const Center(child: Text('No deals available'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final deal = items[index];
        return InkWell(  borderRadius: const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                         Navigator.push(
                            context,
                           MaterialPageRoute(
                              builder: (context) => SpacialScrean(deal: deal),
                         ),
                         );
                        },
                          child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                               child: Material(elevation: 10,borderRadius: BorderRadius.circular(8),
                                 child: Container(width: cardWidth, height: 370,
                                                   decoration: BoxDecoration( color: Colors.white, borderRadius: BorderRadius.circular(8),),
                                 child: Padding(padding: const EdgeInsets.all(10.0),
                                 child: Column(children: [
                                                 const         SizedBox(height: 10),
                                        Row( children: [
                                        CircleAvatar( radius: isSmallScreen ? 21 : 31, backgroundColor: appColorAccent,
                                 child: CircleAvatar(radius: isSmallScreen ? 20 : 30,backgroundColor: appColorAccent,
                                 child: CircleAvatar(backgroundColor: appColorPrimary, radius: isSmallScreen ? 28 : 38,
                                        backgroundImage: AssetImage( deal['logoUrl'],),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column( crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text( deal['name'], style: TextStyle(fontSize: isSmallScreen ? 14 : 18, fontWeight: FontWeight.bold,color: appTextColorSecondary,
                                                ),
                                              ),
                                              Text( '18 Locations',style: TextStyle( fontSize: isSmallScreen ? 10 : 12, fontWeight: FontWeight.bold, color: appTextColorSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                           if (deal['Joboffer'] != null && deal['Joboffer'].isNotEmpty)InkWell(
                              
                                   child: JobOffer(
                                    onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>JobScreen(deal: deal)));
                                    },
                                   )), 
                                             
                                          const SizedBox(width: 8),
                                          const Spacer(),
                                          IconButton(
                                        onPressed: () {
                                        String shareMessage = '''
                                        productUrl:${deal['productUrl']}
                                        Name: ${deal['name']}
                                        Percentage: ${deal['percentage']}
                                        Offer Percentage: ${deal['offerpercentage']}
                                        Coupon Offer: ${deal['coupownoffer']}
                                        ''';
                                        Share.share(shareMessage);},
                                        icon: const Icon(Icons.share, size: 24),),
                                        IconButton(  icon: Icon( deal['isFavorite'] ? Icons.favorite: Icons.favorite_border,
                                                    color: deal['isFavorite']? Colors.red: Colors.grey,size: 24, ),
                                                onPressed: () { setState(() {deal['isFavorite'] = !deal['isFavorite'];});},
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10,),
                                      Container( height: isSmallScreen ? 150 : 200, width: double.infinity,
                                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage( image: AssetImage(deal['productUrl']), fit: BoxFit.fill,),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Textedit(text: deal['productname'],fontSize: isSmallScreen ? 14 : 18,fontWeight: FontWeight.bold,color: appTextColorSecondary,),
                                                                               
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
                                             Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [Column(  mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: Text.rich(
                                              TextSpan(children: [ TextSpan(text: "starts at ",style: TextStyle( fontSize:isSmallScreen ? 12 : 14,
                                                      color: appTextColorPrimary,
                                                    ),
                                                  ),
                                                  TextSpan( text: "₹${deal['offerprice']}",
                                                    style: TextStyle(fontSize:isSmallScreen ? 16 : 20,
                                                      color: appTextColorPrimary,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(  "₹2099",style: TextStyle(fontSize: isSmallScreen ? 14 : 18,
                                              color: appTextColorPrimary,decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text("₹${deal['price']}", style: TextStyle(fontSize: isSmallScreen ? 12 : 14,color: appTextColorPrimary,   decoration: TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ],
                                      ),
                                        const Row(
                                          children: [
                                            Icon(Icons.location_on_outlined),
                                            Text("location"),
                                          ],
                                        )
                                          ],
                                        ),
                                        Column(children: [IconButton( 
                                                      icon: Icon( deal['isPressed'] ? Icons.handshake : Icons.handshake,),
                                                     color: deal['isPressed']? Colors.pink : Colors.grey,iconSize: isSmallScreen ? 20 : 30,
                                                 onPressed: () { setState(() {deal['isPressed'] = !deal['isPressed']; deal['count'] +=deal['isPressed'] ? 1 : -1;});},),
                                            Textedit( text: '${deal['count']}', fontSize: isSmallScreen ? 14: 18,
                                            ),
                                          ],
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
                          ),
                        );
                
      },
    );
  }
}
