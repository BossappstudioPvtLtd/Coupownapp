import 'package:coupown/Const/appwidget.dart';
import 'package:coupown/components/small_sutton.dart';
import 'package:coupown/components/splash_radius.dart';
import 'package:coupown/Screanes/Srarching/my_searching.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SearchingArea extends StatefulWidget {
  const SearchingArea({super.key, required Shop shop});

  @override
  _SearchingAreaState createState() =>
      _SearchingAreaState();
}

class _SearchingAreaState extends State<SearchingArea> {
  double _scale = 2.5;  // Initial scale value
double _maxScale = 15.0;  // Maximum scale value
  int _count = 1; // Start with a higher value to represent the initial zoom level (assuming this is the default zoom level)
 int? _selectedOption; // Ensure this is part of the state

  // Function to show a message when limits are reached
  void _showLimitMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Function to zoom in the background image (now reduces the scale and decreases the count)
 void _zoomIn() {
  if (_count < 15) { // Ensure the zoom doesn't go above 15
    setState(() {
      _scale -= 0.1; // Decrease the scale to "zoom out"
      _count++; // Increase the count number (show larger value on zoom in)
    });
  } else {
    _showLimitMessage("Maximum radius level reached!"); // Show message when limit is reached
  }
}

// Function to zoom out (increases the scale and decreases the count)
void _zoomOut() {
  if (_count > 1) { // Ensure the zoom doesn't exceed 1
    setState(() {
      _scale += 0.1; // Increase the scale to "zoom in"
      _count--; // Decrease the count number (show smaller value on zoom out)
    });
  } else {
    _showLimitMessage("Minimum radius level reached!"); // Show message when limit is reached
  }
}


  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
    final isWideScreen = screenWidth > 600;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        
        fit: StackFit.expand,
        children: [Stack(
            children: [ Positioned.fill(
      child: Transform.scale( scale: _scale.clamp(1.0, _maxScale), // Limit the scale between 1.0 and 15.0 (15 times)
       child: Image.asset(  "assets/avatar/app.jpg", fit: BoxFit.cover,
        ),
      ),
        
               ),
             
                   
                    Padding( padding: const EdgeInsets.only(top: 30),
                     child: Row(children: [IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_outlined,color: appColorPrimary,)), Spacer(),
                      Padding(padding: const EdgeInsets.all(6.0),
                       child: SmallButton( icon: Icons.short_text_sharp,iconcolor: appColorPrimary, containerheight: 30,containerwidth: 70,
                        borderRadius: BorderRadius.circular(8),meterialColor: Colors.white38,
                         onTap: () {showModalBottomSheet( backgroundColor: appColorPrimary,context: context,builder: (BuildContext context) {
                      return SortOptionsModal(initialSelectedOption: _selectedOption, onOptionSelected: (int? value) {
                       setState(() {_selectedOption = value;  });},);},);}, elevationsize: 10, text: 'Filter', ), ),],),),
      
                   
              
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut, // Smooth transition curve
                  width: 400 - (50 * (_scale - 1)), // Adjust width based on scale
                  height: 400 - (50 * (_scale - 1)), // Adjust height based on scale
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white38),
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Colors.white10, Colors.white10],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: SpalshRipple(),
                ),
              ),
              Padding( padding: const EdgeInsets.only(left: 120),child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [ClipPath(clipper: MessageClipper(borderRadius: 4),
            child: Stack( children: [ Container( height: 30 + (10 * (_scale - 1)),width: 30 + (10 * (_scale - 1)),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.white, ),
                  child: Center(child: Image.asset("assets/exclusive/WhatsApp.jpeg",fit: BoxFit.fill,),),),],),),
                   Text( _selectedOption == 0 ? "₹400" : "950m",  style: TextStyle(color: appColorAccent,fontWeight: FontWeight.bold,fontSize: (6 * _scale),),),],),),),
                    
      
               Padding( padding: const EdgeInsets.only(top:120),
                child: Center(child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ ClipPath(clipper: MessageClipper(borderRadius: 4),
                        child: Stack( children: [ InkWell(onTap: (){ showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: appColorPrimary,),
                        
                        height: 200,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Card(
                                  child: Container(
                                    height: isSmallScreen ? 60: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      
                                      color: Colors.white,
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
                                                       child: ClipOval(
                                                         child: Image.asset("assets/exclusive/WhatsApp.jpeg",
                                                         //  deal['logoUrl'],
                                                           fit: BoxFit.cover,
                                                           width: isSmallScreen ? 50 : (isMediumScreen ? 60 : 70),
                                                           height: isSmallScreen ? 50 : (isMediumScreen ? 60 : 70),
                                                         ),
                                                       ),
                                                     ),
                                          ),
                                          SizedBox(width: isSmallScreen ? 8 : 15),
                                          Expanded(
                                                     child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      Text(
        "deal['name']",
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
      SizedBox(height: 4), // Spacing between text and stars
         Row( children: [ ...List.generate(4, (index) => Icon( Icons.star,   color: Colors.amber,  size: isSmallScreen ? 16 : 20,  )),
      Icon(Icons.star_half,   color: Colors.amber,  size: isSmallScreen ? 16 : 20,),
      SizedBox(width: 4), // Space between stars and the rating text
      Text('4.5', style: TextStyle( fontSize: isSmallScreen ? 12 : 16, fontWeight: FontWeight.bold, color: appTextColorSecondary,),),],),],)),
                                          SizedBox(width: isSmallScreen ? 8 : 15),
                                          Icon(Icons.share, size: isSmallScreen ? 20 : 24),
                                         
                                        ],
                                      ),
                                    ),
                                  ),
                                                           ),
                               ),
                               RichText(text: TextSpan( text: 'Offer: ',  
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,  fontSize: 18, ),
                                children: <TextSpan>[TextSpan( text: 'Get 50% off on all items!', 
                                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.blueGrey[700],  fontSize: 16,    ),),
                                    TextSpan(text: '\nOffer valid till: 31st December 2024', 
                                      style: TextStyle( fontStyle: FontStyle.italic, color: Colors.redAccent,  fontSize: 14,             // Smaller font size for details
                                  ),
                                ),
                              ],
                            ),
                          ),
                           
                          Row(children:  [
                              Flexible(child: SmallButton(containerheight: 30, elevationsize: 10, text: "cancel",onTap: () {
                                Navigator.pop(context);
                              },),),
                              SizedBox(width: 10), // Add spacing between buttons if needed
                             
                              Flexible( child: SmallButton( containerheight: 30, elevationsize: 10,  text: "ViewMore", ),),
                            ],
                          )
                            ],
                          ),
                        ),
                      ),
                    ),
      
                  );
                },
              );
            },
                          child: Container(  height: 30 + (10 * (_scale - 1)), width: 30 + (10 * (_scale - 1)),
                                decoration: const BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white,),
                                  child: Center(  child:  Image.asset("assets/exclusive/WhatsApp.jpeg", fit: BoxFit.fill, ), ),),),], ), ),
                                    Text( _selectedOption == 0 ? "₹400" : "950m",  style: TextStyle(color: appColorAccent,fontWeight: FontWeight.bold,fontSize: (6 * _scale),),), ],),),),
                                    
      
      
                                     Padding( padding: const EdgeInsets.only(bottom: 120),child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [ClipPath(clipper: MessageClipper(borderRadius: 4),
            child: Stack( children: [ Container( height: 30 + (10 * (_scale - 1)),width: 30 + (10 * (_scale - 1)),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0)),color: Colors.white, ),
                  child: Center(child: Image.asset("assets/exclusive/WhatsApp.jpeg",fit: BoxFit.fill,),),),],),),
                    Text( _selectedOption == 0 ? "₹400" : "950m",  style: TextStyle(color: appColorAccent,fontWeight: FontWeight.bold,fontSize: (6 * _scale),),),  ],),),),
      
               Padding( padding: const EdgeInsets.only(right:120),
                child: Center(child: Column( crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [ ClipPath(clipper: MessageClipper(borderRadius: 4),
                        child: Stack( children: [ Container(  height: 30 + (10 * (_scale - 1)), width: 30 + (10 * (_scale - 1)),
                              decoration: const BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(5.0)), color: Colors.white,),
                                child: Center(  child:  Image.asset("assets/exclusive/WhatsApp.jpeg", fit: BoxFit.fill, ), ),),], ), ),
                                   Text( _selectedOption == 0 ? "₹400" : "950m",  style: TextStyle(color: appColorAccent,fontWeight: FontWeight.bold,fontSize: (6 * _scale),),
      ),
      
                                    ],
                               ),
                             ),
                           ),          
                         ], 
                      ),
                              
            Positioned( child: Align( alignment: Alignment.bottomCenter,
              child: Padding(padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                child: Material(color: Colors.white10,borderRadius: BorderRadius.circular(500),elevation: 5,
                  child: Container(decoration: BoxDecoration( borderRadius: BorderRadius.circular(500),
                    color: Colors.transparent,border: Border.all(color: Colors.white30),),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [ IconButton(onPressed: _zoomOut, icon: const Icon(Icons.remove, size: 30), color: appColorAccent, ),
                        const SizedBox(width: 10),
                        Material( color: Colors.white12, elevation: 5,shape: const CircleBorder(),
                          child: CircleAvatar(radius: 30, backgroundColor: Colors.transparent, child: Column(children: [
                            Text( "$_count",  style: const TextStyle(  fontSize: 24, fontWeight: FontWeight.bold, color: appColorAccent,),),
                              const Text( "KM",style: TextStyle(  fontWeight: FontWeight.bold, color: appColorAccent, ), ), ], ), ), ),
                               const SizedBox(width: 10),
                                 IconButton( onPressed: _zoomIn,icon: const Icon(Icons.add, size: 30), color: appColorAccent,
                                ),
                              ],
                            ),
                          ),
                        ),
                       ),
            ),
          ),
        ],
      ),
    );
  }
}




// Modal Bottom Sheet Widget
// Modal Bottom Sheet Widget
class SortOptionsModal extends StatefulWidget {
  final int? initialSelectedOption;
  final ValueChanged<int?> onOptionSelected;

  const SortOptionsModal({
    Key? key,
    required this.initialSelectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  _SortOptionsModalState createState() => _SortOptionsModalState();
}

class _SortOptionsModalState extends State<SortOptionsModal> {
  late int? _selectedOption;

  @override
  void initState() {
    super.initState();
    // If initialSelectedOption is not provided, default to Distance Wise (1)
    _selectedOption = widget.initialSelectedOption ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined, color: appTextColorPrimary),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 8),
              const Text(
                'Sort by',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: appTextColorPrimary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.money, color: appTextColorPrimary),
            title: const Text('Rate Wise', style: TextStyle(fontWeight: FontWeight.bold, color: appTextColorPrimary)),
            trailing: Radio<int>(
              activeColor: appColorAccent,
              value: 0,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                });
                widget.onOptionSelected(value);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on, color: appTextColorPrimary),
            title: const Text('Distance Wise', style: TextStyle(fontWeight: FontWeight.bold, color: appTextColorPrimary)),
            trailing: Radio<int>(
              activeColor: appColorAccent,
              value: 1,
              groupValue: _selectedOption,
              onChanged: (int? value) {
                setState(() {
                  _selectedOption = value;
                });
                widget.onOptionSelected(value);
              },
            ),
          ),
          const SizedBox(height: 16),
          SmallButton(
            meterialColor: appColorAccent,
            elevationsize: 20,
            text: "Apply",
            containerheight: 40,
            containerwidth: 400,
            onTap: () {
              if (_selectedOption == 0) {
                print("Rate Wise selected");
              } else if (_selectedOption == 1) {
                print("Distance Wise selected");
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

  



