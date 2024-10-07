import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/add_job_offer.dart';
import 'package:coupown/Screanes/subscription/add_special_offer.dart';
import 'package:coupown/Screanes/subscription/data_editing.dart';
import 'package:coupown/components/my_Icons.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/scanner.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? selectedBranch; // Selected branch variable
  final List<String> branches = ['Branch A', 'Branch B', 'Branch C', 'Branch D'];

  final Map<String, dynamic> deal = {
    'logoUrl': 'assets/exclusive/Frame 1261154796.png',
    'name': 'Dealer Name',
    'location': 'No 32, Roys Complex, Tuticorin Road, Pudukottai, Tuticorin',
  };

  @override
  Widget build(BuildContext context) {
    // Get screen width and categorize the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isWideScreen = screenWidth > 600;

    // Adjust font sizes and layout for different screen sizes
    final titleFontSize = isSmallScreen ? 16.0 : isWideScreen ? 28.0 : 24.0;
    final subtitleFontSize = isSmallScreen ? 14.0 : isWideScreen ? 22.0 : 20.0;
    final avatarRadius = isSmallScreen ? 25.0 : isWideScreen ? 50.0 : 40.0;

    return Scaffold(

  resizeToAvoidBottomInset: true,
      backgroundColor: appColorPrimary,
      body: Padding( padding: const EdgeInsets.all(20.0),
        child: Column( children: [
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
    // Adjust layout based on screen width
    if (screenWidth > 350)
      Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
      children: [ Text(deal['name'],style: TextStyle(fontSize: titleFontSize,fontWeight: FontWeight.bold, ), ),
                  Text(  'Category',style: TextStyle(fontSize: subtitleFontSize,  fontWeight: FontWeight.bold, ),),
          ],
        ),
      )
    else
      Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start,
             children: [Text( deal['name'], style: TextStyle( fontSize: titleFontSize - 2,  
           fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis, ),
      Text('Category', style: TextStyle( fontSize: subtitleFontSize - 2,   fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis, ),
          ],
        ),
      ),
       MyIcons(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>const QRViewExample()));},icon:Icons.qr_code_scanner_sharp ,),
       MyIcons(onTap: () {},icon:Icons.notifications_none ,),
       MyIcons(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_)=>const DataEditing()));},icon:Icons.movie_edit ,),
  ],
),

            const SizedBox(height: 30),
            Material(  elevation: 5, color: Colors.white, borderRadius: BorderRadius.circular(8),
              child: Padding( padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(borderRadius: BorderRadius.circular(8),
                  dropdownColor: appColorPrimary, decoration: const InputDecoration( border: InputBorder.none,),
                  value: selectedBranch,items: branches.map((branch) {
                  return DropdownMenuItem<String>( value: branch, child: Text(branch), );}).toList(),
                  onChanged: (newValue) { setState(() { selectedBranch = newValue; });},
                  hint: const Padding( padding: EdgeInsets.symmetric(horizontal: 10), child: Text("Location or Branch"), ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox( height: isWideScreen ? 250 : 200, width: double.infinity,
              child: Column( crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [ const Textedit(text: 'Our Service', fontWeight: FontWeight.bold),
                  DottedBorder(color: iconColorSecondary,
                    strokeWidth: 2, dashPattern: const [6, 3],
                    borderType: BorderType.RRect, radius: const Radius.circular(12),
                    child: Container( height: 100, width: 100,
                      alignment: Alignment.center,
                      child: IconButton( onPressed: () {
                          showDialog(  context: context,
                            builder: (BuildContext context) {  String inputText = "";
                              return Dialog( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), ),
                                child: Container( decoration: BoxDecoration( color: appColorPrimary, borderRadius: BorderRadius.circular(8),),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(  mainAxisSize: MainAxisSize.min,
                                    children: [  const SizedBox(height: 20),
                                      TextField( onChanged: (value) {  inputText = value; },
                                        decoration: const InputDecoration(
                                          hintText: "Add Product/Service Name",
                                          hintStyle: TextStyle(color: iconColorSecondary),
                                          focusedBorder: OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder( borderSide: BorderSide(  color: iconColorSecondary, width: 1.0, ), ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row( mainAxisAlignment: MainAxisAlignment.end,
                                        children:[TextButton(onPressed:(){print("User entered: $inputText");Navigator.of(context).pop();},child: const Text("OK"),),],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add, size: 50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(children: [  
            Expanded( child:  
           MyButtonAni(
  elevationsize: 5,
  text: "Add Offer",
  onTap: () {
    showModalBottomSheet(
      backgroundColor: appColorPrimary,
      context: context,
      isScrollControlled: true, // This allows the bottom sheet to take full height
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.9, // Set to 1.0 for full height
          minChildSize: 0.5,     // Minimum height when sheet is minimized
          maxChildSize: 1.0,     // Maximum height for the sheet
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   MyAppbar(text: "Special Offers" ),
                    // Add your form or offer content here
                   Expanded(child: PostOfferPage())

                  ],
                ),
              ),
            );
          },
        );
      },
    );
  },


            
            ), ),
                Container( width: isSmallScreen ? 142: 138, height: isSmallScreen ? 45 : 40,
                    decoration: BoxDecoration(  border: Border.all(color: appColorAccent, width: 2.0), borderRadius: BorderRadius.circular(32), ),
                    child: Expanded(
                      child: TextButton( onPressed: () {
                         showModalBottomSheet(
                            backgroundColor: appColorPrimary,
                            context: context,
                            isScrollControlled: true, // This allows the bottom sheet to take full height
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                initialChildSize: 0.9, // Set to 1.0 for full height
                                minChildSize: 0.5,     // Minimum height when sheet is minimized
                                maxChildSize: 1.0,     // Maximum height for the sheet
                                builder: (BuildContext context, ScrollController scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    child: Container(
                                      width: double.infinity,
                                      height: MediaQuery.of(context).size.height * 0.9, // Set desired height
                                      padding: const EdgeInsets.all(16.0),
                                      child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       MyAppbar(text: "Job Offers" ),
                        // Add your form or offer content here
                       Expanded(child: AddJobOffer())
                      
                      ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                      }, child: const Textedit(color: appColorAccent, text: 'Job Offer'),),
                    ),
                  ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
