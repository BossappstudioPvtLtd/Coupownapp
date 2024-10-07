import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/data_editing.dart';
import 'package:coupown/Screanes/subscription/product/my_product.dart';
import 'package:coupown/Screanes/subscription/reviews.dart';
import 'package:coupown/Screanes/subscription/services/service_srean.dart';
import 'package:coupown/components/my_Icons.dart';
import 'package:coupown/components/scanner.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CoupownScreen extends StatefulWidget {
  const CoupownScreen({super.key});

  @override
  State<CoupownScreen> createState() => _CoupownScreenState();
}

class _CoupownScreenState extends State<CoupownScreen> with SingleTickerProviderStateMixin {
  String? selectedBranch; // Selected branch variable
  final List<String> branches = ['Branch A', 'Branch B', 'Branch C', 'Branch D'];

  final Map<String, dynamic> deal = {
    'logoUrl': 'assets/exclusive/Frame 1261154796.png',
    'name': 'Dealer Name',
    'location': 'No 32, Roys Complex, Tuticorin Road, Pudukottai, Tuticorin',
  };

 

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Two tabs: My Product, Service
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  // Get screen width and categorize the screen size
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 600;
  final isMediumScreen = screenWidth >= 400 && screenWidth <= 600;
  final isWideScreen = screenWidth > 600;

  // Adjust font sizes and layout for different screen sizes
  final titleFontSize = isSmallScreen ? 16.0 : isMediumScreen ? 24.0 : isWideScreen ? 28.0 : 24.0;
  final subtitleFontSize = isSmallScreen ? 14.0 : isMediumScreen ? 20.0 : isWideScreen ? 22.0 : 20.0;
  final avatarRadius = isSmallScreen ? 25.0 : isMediumScreen ? 40.0 : isWideScreen ? 50.0 : 40.0;

  return Scaffold(
    backgroundColor: appColorPrimary,
    body: Padding(
      padding: const EdgeInsets.only(left:10.0 ,right: 10,top:15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                radius: avatarRadius + 2,
                backgroundColor: appColorAccent,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: appColorPrimary,
                  child: deal['logoUrl'] != null && deal['logoUrl'].isNotEmpty
                      ? Image.asset(deal['logoUrl'], fit: BoxFit.fill)
                      : const Icon(Icons.person, color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              if (screenWidth > 350)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal['name'],
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        deal['name'],
                        style: TextStyle(
                          fontSize: titleFontSize - 2,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: subtitleFontSize - 2,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              MyIcons(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => const QRViewExample()));}, icon: Icons.qr_code_scanner_sharp,),
              MyIcons(onTap: () {},icon: Icons.notifications_none,),
              MyIcons(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => const DataEditing()));},icon: Icons.movie_edit,),
            ],
          ),
          const SizedBox(height: 5),
          Material(elevation: 5,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: Padding( padding: const EdgeInsets.symmetric(horizontal: 16),
               child: DropdownButtonFormField<String>( borderRadius: BorderRadius.circular(8),dropdownColor: appColorPrimary,
                 decoration: const InputDecoration( border: InputBorder.none,),
                   value: selectedBranch,
                     items: branches.map((branch) {
                      return DropdownMenuItem<String>(value: branch, child: Text(branch), ); }).toList(),
                        onChanged: (newValue) {setState(() { selectedBranch = newValue; }); },
                           hint: const Padding( padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("Location or Branch"),
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(height: isWideScreen ? 190 : isMediumScreen ? 150 : 90,width: double.infinity,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [  Row(
                  children: [ DottedBorder( color: iconColorSecondary,
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      child: Container(
                        height: 70,
                        width: 70,
                        alignment: Alignment.center,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                String inputText = "";
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: appColorPrimary,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(height: 20),
                                        TextField(
                                          onChanged: (value) {
                                            inputText = value;
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Add Product/Service Name",
                                            hintStyle: TextStyle(color: iconColorSecondary),
                                            focusedBorder: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: iconColorSecondary,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                print("User entered: $inputText");
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.add, size: 50,color: Colors.grey,),
                        ),
                      ),
                    ),
                    Expanded( child: Padding( padding: const EdgeInsets.only(left: 5),
                        child: Container(height: 90,width: 240,decoration: BoxDecoration( borderRadius: BorderRadius.circular(16), ),
                         child: ListView.builder( itemCount: 5, // Specify the length of the list
                            scrollDirection: Axis.horizontal, // Horizontal scrolling if needed
                            itemBuilder: (context, index) {
                              return Padding(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: Container( height: 80,  width: 80, decoration: BoxDecoration( borderRadius: BorderRadius.circular(16), color: Colors.blueGrey,),
                                  child: const Center(child: Padding( padding: EdgeInsets.symmetric(horizontal: 15),
                                      child: Text( "Womens Wear", style: TextStyle(fontSize: 10,color: appColorPrimary,fontWeight:FontWeight.bold ), ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material( color: appColorPrimary,shadowColor: appColorPrimary,borderRadius: BorderRadius.circular(8), elevation: 5,
            child: Container(height: 73,width: 400,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
             child: Padding( padding: const EdgeInsets.symmetric(horizontal: 5),
                   child: Column( mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [Row(crossAxisAlignment: CrossAxisAlignment.start,
                   children: [ const Textedit( text: "Reviews", fontWeight: FontWeight.bold, ),
                               const Spacer(), TextButton( onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>const Reviews()));},
                        child: const Text("See All Reviews",style: TextStyle( fontWeight: FontWeight.bold,
                             fontSize: 16,color: appColorAccent,decoration: TextDecoration.underline, decorationColor: appColorAccent, ),
                                ),
                              ),
                            ],
                          ),
                           const Row( children: [ Icon(Icons.star, color: appColorAccent, size: 20),
                           Textedit( text: "4.4", color: appColorAccent,fontWeight: FontWeight.bold, ), Text("  Total 120 Reviews"),],
                       ),
                   ],
                 ),
               ),
                   
                
               
              
            ),
          ),

          

          TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: "Product"),
              Tab(text: "Service"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                
                const MyProduct(),
const ServiceSrean(),
                Center( child: Text("No services available", style: TextStyle(fontSize: titleFontSize, color: Colors.black),),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
