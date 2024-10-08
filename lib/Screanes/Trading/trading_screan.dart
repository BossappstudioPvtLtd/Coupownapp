import 'dart:async';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/lounchmap.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:rating_summary/rating_summary.dart';
import 'package:share_plus/share_plus.dart';

class TradingScrean extends StatefulWidget {
  final List<Map<String, dynamic>> deals;
  
  final Map<String, dynamic> deal;
  

  const TradingScrean({
    super.key, required this.deals, required this.deal, 
  
  });

  @override
  _TradingScreanState createState() => _TradingScreanState();
}

class _TradingScreanState extends State<TradingScrean>
    with SingleTickerProviderStateMixin {
  List<bool> isExpandedList = [];
  static const String _kLocationServicesDisabledMessage = 'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _currentPosition;
  String? _placeName;
  String? _pincode;
  String? _city;
  String? _state;
  String? _country;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isListening = false;
   late Timer _timer;

  Duration remainingTime = const Duration(hours: 24); // 24-hour countdown

late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  bool showMyRowWidget = true;
  Alignment alignment = Alignment.centerLeft;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
      startTimer();
    _checkPermissionAndFetchPosition();
     isExpandedList = List.generate(widget.deals.length, (index) => true);

    _controller.forward();
  }

  @override
  void dispose() {
    
    _positionStreamSubscription?.cancel();
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  

  Future<void> _checkPermissionAndFetchPosition() async {
    bool hasPermission = await _handlePermission();
    if (hasPermission) {
      _getCurrentPosition();
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {_showMessage(_kLocationServicesDisabledMessage); return false;
    }

    permission = await Geolocator.checkPermission();if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {_showMessage(_kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) { _showMessage(_kPermissionDeniedForeverMessage);
      return false;
    }
    _showMessage(_kPermissionGrantedMessage);
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high,);
    setState(() {_currentPosition = position;});
    _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _placeName = place.name;
        _city = place.locality;
        _state = place.administrativeArea;
        _country = place.country;
        _pincode = place.postalCode;
      });
    } catch (e) {
      _showMessage('Failed to get address.');
    }
  }

  void _toggleListening() { if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.listen(
        (Position position) {
          setState(() { _currentPosition = position;});
          _getAddressFromLatLng(position);
        },
      );
    }

    if (_isListening) {_positionStreamSubscription?.pause();
    } else {_positionStreamSubscription?.resume();
    }
    setState(() {_isListening = !_isListening; });
  }

  Future<void> _launchMap() async {
    if (_currentPosition != null) { final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showMarker( coords: Coords(_currentPosition!.latitude, _currentPosition!.longitude), title: '',);
      } else { _showMessage('No map apps installed.');}
    } else {_showMessage('Location not available yet.');}
  }

  void _showMessage(String message) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)), );
  }
   void startTimer() {_timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() { remainingTime = remainingTime - const Duration(seconds: 1);});
      } else { _timer.cancel();}
    });
  }
  

  void toggleExpand(int index) { setState(() { isExpandedList[index] = !isExpandedList[index]; });
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
   return Scaffold(
    backgroundColor: appColorPrimary,
    body:  Column( children: [
            
              const Padding(
                padding: EdgeInsets.only(left: 10,top: 20),
                child: MyAppbar(text:"Trading Details" ),
              ),
              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: Container(
                      height: isSmallScreen ? 80 : 100,
                      
                      decoration: BoxDecoration(
                        color:appColorPrimary,
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
                                  backgroundImage: AssetImage(widget.deal['logoUrl']),
                                  child: ClipOval(
                                    child: Image.asset(
                                    widget. deal['logoUrl'],
                                      fit: BoxFit.cover,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text( widget.deal['name'],style: TextStyle(fontSize: isSmallScreen ? 18 : 24,fontWeight: FontWeight.bold,color: appTextColorSecondary,),),
                                  Text('18 Locations', style: TextStyle( fontSize: isSmallScreen ? 8 : 10,fontWeight: FontWeight.bold, color: appTextColorSecondary,),),
                                ],
                              ),
                            ),
                            SizedBox(width: isSmallScreen ? 8 : 15),
                            Icon(Icons.share, size: isSmallScreen ? 20 : 24),
                            IconButton( icon: Icon( widget. deal['isFavorite']  ? Icons.favorite: Icons.favorite_border,
                                color: widget. deal['isFavorite'] ? Colors.red : Colors.grey, size: isSmallScreen ? 24 : 30,
                              ),
                              onPressed: () {
                                setState(() {
                                widget. deal['isFavorite'] = !widget.deal['isFavorite'];
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

               
                Expanded(
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
                        child: SlideTransition(
                          position: _slideInAnimation,
                          child:FadeTransition (
                            opacity:_fadeInAnimation ,
                            child: AnimatedContainer( margin: EdgeInsets.symmetric( horizontal: isExpanded ? 25 : 0,vertical: 20,),
                            padding: const EdgeInsets.all(20), height: isExpanded ? 150 : 500,  curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(milliseconds: 1200), decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.blueAccent),
                            boxShadow: [BoxShadow(color: const Color.fromARGB(255, 211, 211, 211).withOpacity(0.5), blurRadius: 10,offset: const Offset(5, 10),),],
                            color: Colors.white, borderRadius: BorderRadius.all( Radius.circular(isExpanded ? 8 : 0),),),
                            child: SingleChildScrollView(
                            child: SlideTransition(
                              position: _slideInAnimation,
                              child: Column( 
                              children: [ Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [ SizedBox( width: 240,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text(offerDetails,style: TextStyle( fontSize: isSmallScreen ? 17 : 18,fontWeight:FontWeight.bold  ),maxLines: 5, overflow: TextOverflow.ellipsis,),
                                         Text("Limited-time offers for first purchases are a great way to ensure that more visitors. ",style:  TextStyle( fontSize: isSmallScreen ? 16 : 18, ),maxLines: 5, overflow: TextOverflow.ellipsis,),
                                         Text("8 Users Today",style: TextStyle( fontSize: isSmallScreen ? 16 : 18, fontWeight:FontWeight.bold),maxLines: 5, overflow: TextOverflow.ellipsis,),], ),),
                                         RotationTransition(turns: AlwaysStoppedAnimation(isExpanded ? 0.0 : 0.5), child: GestureDetector(onTap: () {  
                                         String shareMessage = createShareMessage(offerDetails, productUrl, productName);
                                         Share.share(shareMessage);},child: const Icon(Icons.share, color: Colors.grey, size: 27)),
                                                     ),
                                                  ],),
                                          SizedBox(height: isExpanded ? 0 : 20),
                                          Column(children: [SlideTransition(position: _slideInAnimation,
                                                    child: AnimatedCrossFade( firstChild: const SizedBox(),
                                              secondChild: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [ Center(child: SizedBox(height: isSmallScreen ? 150 : 200,  width: isSmallScreen ? 150 : 200,
                                                    child: ClipRRect(borderRadius: BorderRadius.circular(16),child: Image.asset(productUrl, fit: BoxFit.cover), ), ), ),
                                                           Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [ Text( productName, style: TextStyle( fontSize: isSmallScreen ? 18 : 24, fontWeight: FontWeight.bold, ), ),
                                                           Row(
                                                children: [ Icon(Icons.calendar_month, size: isSmallScreen ? 16 : 20),
                                                          const SizedBox(width: 4),
                                                          Text.rich(TextSpan(children: [TextSpan( text: "Offer Valid to ",style: TextStyle( fontSize: isSmallScreen ? 12 : 14, color: Colors.black,),),
                                                          TextSpan( text: "${deal['valid date']}", style: TextStyle( fontSize: isSmallScreen ? 14 : 16,color: Colors.red, fontWeight: FontWeight.bold,), ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                           Row( children: [Padding( padding: const EdgeInsets.only(right: 8),
                                                           child: Text.rich(TextSpan(children: [TextSpan( text: "Starts at ",style: TextStyle(fontSize: isSmallScreen ? 12 : 14, color: Colors.black, ), ),
                                                           TextSpan( text: "₹${deal['offerprice']}", style: TextStyle(fontSize: isSmallScreen ? 16 : 20, color: Colors.black,  fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                      const SizedBox(height: 10),
                                                            Text("₹2099",style: TextStyle(   fontSize: isSmallScreen ? 14 : 18, color: Colors.black, decoration: TextDecoration.lineThrough,),),
                                                      const SizedBox(width: 8),
                                                            Text("₹${deal['price']}", style: TextStyle(fontSize: isSmallScreen ? 12 : 14, color: Colors.black,decoration: TextDecoration.lineThrough,),),
                                                                                              ],
                                                                                            ),
                                                                                            // Add more details here...
                                                                                          ],
                                                                                        ),
                                                                                        Row(  children: [Icon(Icons.location_on_outlined, size: isSmallScreen ? 16 : 20),
                                                                                                         const SizedBox(width: 4),
                                                                                       Text.rich( TextSpan(children: [TextSpan(text: "Location ", style: TextStyle(  fontSize: isSmallScreen ? 12 : 14, color: appTextColorPrimary,),),
                                                                                                  TextSpan(text: "${deal['location']}",style: TextStyle(fontSize: isSmallScreen ? 14 : 16, color: appTextColorPrimary, fontWeight: FontWeight.bold,), ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                        SizedBox( height: 100,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [Material(color: appDarkRed,borderRadius: BorderRadius.circular(32),
                                                                                                child:  Padding(padding: const EdgeInsets.only( right: 10, left: 10),
                                                                                                  child: Row(children: [ const Icon(Icons.alarm, 
                                                                                                    color: Colors.white), Padding( padding: const EdgeInsets.all(8.0),
                                                                                                        child: Text(formatDuration(remainingTime),style:  const TextStyle( color: Colors.white),), ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                                 const SizedBox(width: 4),
                                                                                              Text("${deal['rating']}", style: TextStyle( fontSize: isSmallScreen ? 14 : 16, ), ),
                                                                                              Icon(Icons.star, color: Colors.amber, size: isSmallScreen ? 20 : 24),
                                                                                              Text( "|", style: TextStyle( fontSize: isSmallScreen ? 14 : 16, color: Colors.grey,),),
                                                                                              Text( "130 ",style: TextStyle(fontSize: isSmallScreen ? 14 : 16), ),
                                                                                              Text( "Ratings",style: TextStyle(fontSize: isSmallScreen ? 10 : 12,),),
                                                                                              const SizedBox( width: 30, ),
                                                                                            
                                                                                              Padding( padding:const EdgeInsets.only(bottom: 15),
                                                                                                         child: Column(children: [IconButton(
                                                                                                    icon: Icon(  deal['isPressed'] ? Icons.handshake : Icons.handshake,),
                                                                                                    color: deal['isPressed']? Colors.pink : Colors.grey, iconSize: isSmallScreen ? 24 : 30,
                                                                                                    onPressed: () { setState(() { deal['isPressed'] = !deal['isPressed']; deal['count'] +=deal['isPressed'] ? 1 : -1;}); },
                                                                                                  ),
                                                                                                  Textedit( text: '${deal['count']}', fontSize: isSmallScreen ? 16 : 18,)
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                          ],
                                                                                       ),
                                                                                     ),
                                                                                             
                                                                                                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                       children: [ MapLaunch(onPressed: _launchMap,colorsList:const [Colors.blue, Colors.purple, Colors.red], data: 'Open In Map', icon:Icons.maps_home_work,),
                                                                                                   MapLaunch(onPressed: (){},colorsList:const [Colors.greenAccent, Colors.purple, Colors.red], data: 'Call Ma Now', icon:Icons.phone_android,),
                                                                                            ],
                                                                                          ),
                                                                                          
                                                                                      const SizedBox( height: 30, ), 
                                                                                            Text( "${deal['discretion']}", style: TextStyle(fontSize: isSmallScreen ? 14 : 16,), ),
                                                                                      const SizedBox( height: 50, ), 
                                                                                      const Textedit(text: "Rating & Riviews",fontWeight: FontWeight.bold,),
                                                                                            Material(borderRadius: BorderRadius.circular(8), elevation: 5,
                                                                                               child: Container(height: 150,
                                                                                                decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), color:appColorPrimary,border: Border.all(color:const Color.fromARGB(224, 211, 211, 211))),
                                                                                                child: const Padding( padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                                                                                                  child: RatingSummary( counter: 13,average: 4.5,
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
                                                                                        const MyButtonAni(elevationsize: 20, text: "Save Counpown"),    
                                                                                        const SizedBox( height: 50, ),
                                                                                      
                                                                                      ],
                                                                                    ),
                                                                                    crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                                                    duration: const Duration(milliseconds: 1200), reverseDuration: Duration.zero,
                                                                                    sizeCurve: Curves.fastLinearToSlowEaseIn,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                      ],
                                  ),
                            ),
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

 String createShareMessage(String offerDetails, String productUrl, String productName) {
    return '''
    Check out this product!

    Product Name: $productName
    Offer Details: $offerDetails
    Product URL: $productUrl
    ''';
  }