import 'dart:io';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:coupown/components/text_edit_quill.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostOfferPage extends StatefulWidget {
  const PostOfferPage({super.key});

  @override
  _PostOfferPageState createState() => _PostOfferPageState();
}

class _PostOfferPageState extends State<PostOfferPage> {
  File? _pickedImage;
   final Map<String, dynamic> deal = {
    'logoUrl': 'assets/exclusive/upload.png',
    'name': 'Dealer Name',
    'location': 'No 32, Roys Complex, Tuticorin Road, Pudukottai, Tuticorin',
  };
   // List of offers or product names
  final List<String> offerNames = ['Product A', 'Product B', 'Product C', 'Offer D'];
  
  // Variable to hold the selected value
  String? selectedOffer;

  final _formKey = GlobalKey<FormState>();
    // Radio button selection
  String discountType = "Rupees";
  
  String couponlimit = "Coupon Limit";


 Future<void> _pickImage() async {
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }


  // Controllers for text fields
  final controllers = {
    'startDate': TextEditingController(),
    'endDate': TextEditingController(),
    'OfferHeading': TextEditingController(),
    'prefix': TextEditingController(),
    'actualPrice': TextEditingController(),
    'offerPrice': TextEditingController(),
    'couponPrice': TextEditingController(),
    'suffix': TextEditingController(),
    "Coupon Limit": TextEditingController(),
    'couponCode': TextEditingController(),
    'description': TextEditingController(),
  };

  @override
  void dispose() {
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  bool _validateFields() {
    for (var key in controllers.keys) {
      if (controllers[key]!.text.isEmpty) {
        _showError("Please enter ${key.replaceFirst(key[0], key[0].toUpperCase())}");
        return false;
      }
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _postOffer() {
    if (_validateFields()) {
      print('Posting Offer...');
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, bool isDate = false}) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: TextField( controller: controller,
          decoration: InputDecoration( labelText: label, border: InputBorder.none,
          suffixIcon: isDate ? IconButton( icon: const Icon(Icons.calendar_today), onPressed: () => _selectDate(context, controller),) : null,),
          keyboardType: isNumber ? TextInputType.number : TextInputType.text, readOnly: isDate,
        ),
      ),
    );
  }

   @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isWideScreen = screenWidth > 600;

    // Adjust font sizes and layout for different screen sizes
    final avatarRadius = isSmallScreen ? 30.0 : isWideScreen ? 30.0 : 40.0;

    return 
     ListView(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Upload Photo", style: TextStyle(fontSize: 18)),
                  Row(
                    children: [
                      DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 2,
                        dashPattern: const [6, 3],
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        child: Container(
                          height: 130,
                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: avatarRadius,
                                  backgroundColor: appLight_orange,
                                  child: deal['logoUrl'] != null && deal['logoUrl']!.isNotEmpty
                                      ? Image.asset(
                                          deal['logoUrl']!,
                                          fit: BoxFit.fill,
                                        )
                                      : const Icon(Icons.person, color: Colors.white),
                                ),
                              ),
                              const Text("Add")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 130,
                          decoration: const BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: _pickedImage != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: Image.file(
                                    _pickedImage!,
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    'No Image Selected',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField('Offer Heading', controllers['OfferHeading']!),
            Row(
              children: [
                Expanded(child: _buildTextField('Offer Start', controllers['startDate']!, isDate: true)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField('Offer End', controllers['endDate']!, isDate: true)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                Material(
                  elevation: 1,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 40,
                    width: 70,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Rupees",
                          groupValue: discountType,
                          activeColor:appColorAccent,
                          onChanged: (value) {
                            setState(() {
                              discountType = value!;
                            });
                          },
                        ),
                        const Text("₹", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Material(
                  elevation: 1,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 40,
                    width: 70,
                    child: Row(
                      children: [
                        Radio<String>(
                          value: "Percentage",
                          groupValue: discountType,
                          activeColor:appColorAccent,
                          onChanged: (value) {
                            setState(() {
                              discountType = value!;
                            });
                          },
                        ),
                        const Text("%", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
                Row( children: [
                Expanded(child: _buildTextField('Prefix', controllers['prefix']!)),
          const SizedBox(width: 16),
                Expanded(child: _buildTextField(discountType == "Rupees" ? 'Actual Price' : 'Action %',controllers['actualPrice']!, isNumber: true,), ),
                ], ),
          const SizedBox(height: 16),
                Row(children: [ 
                Expanded( child: _buildTextField(discountType == "Rupees" ? 'Offer Price' : 'Offer %', controllers['offerPrice']!, isNumber: true, ),),
          const SizedBox( width: 16),
                Expanded( child: _buildTextField( discountType == "Rupees" ? 'Coupon Price' : 'Coupon %',controllers['couponPrice']!,isNumber: true,), ),
                ],),
          const SizedBox(height: 16),
                _buildTextField('Suffix', controllers['suffix']!),
          const SizedBox(height: 16),
                Card( color: Colors.white,
                  child: DropdownButtonFormField<String>(borderRadius: BorderRadius.circular(8),
                  dropdownColor: appColorPrimary, decoration: const InputDecoration( border: InputBorder.none,),
                  value: selectedOffer,items: offerNames.map((branch) {
                  return DropdownMenuItem<String>( value: branch, child: Text(branch), );}).toList(),
                  onChanged: (newValue) { setState(() { selectedOffer = newValue; });},
                  hint: const Padding( padding: EdgeInsets.symmetric(horizontal: 10), child: Text("Offer/Product Name",style: TextStyle(color:Color.fromARGB(255, 123, 123, 123) ),), ),
                ),),
                
          const SizedBox(height: 16),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: MediaQuery.of(context).size.width < 400 ? 35 : 40, // Adjust height based on screen width
        width: MediaQuery.of(context).size.width < 400 ? 130 : 150, // Adjust width for small screens
        child: Row( children: [
            Radio<String>( value: "Coupon Limit", groupValue: couponlimit, activeColor: appColorAccent,
              onChanged: (value) { setState(() { couponlimit = value!;});},),
            // Adjust font size based on screen width
            Textedit( text: 'Coupon Limit', fontSize: MediaQuery.of(context).size.width < 400 ? 10 : 12, ),
          ],
        ),
      ),
    ),
    Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(height: MediaQuery.of(context).size.width < 400 ? 35 : 40, // Adjust height for small screens
      width: MediaQuery.of(context).size.width < 400 ? 130 : 145, // Adjust width for small screens
      child: Row( children: [ Radio<String>( value: "UnLimit",  groupValue: couponlimit,
                  activeColor: appColorAccent,  onChanged: (value) { setState(() {couponlimit = value!; });},), // Adjust font size based on screen width
             Text("UnLimit",  style: TextStyle( fontSize: MediaQuery.of(context).size.width < 400 ? 14 : 16, ),
            ),
          ],
        ),
      ),
    ),
  ],
),

           if (couponlimit == "Coupon Limit")
            Padding( padding: const EdgeInsets.only(top: 10), child: _buildTextField('Coupon Limit', controllers['Coupon Limit']!, isNumber: true),),
      const SizedBox(height: 16),
            _buildTextField('Coupon Code', controllers['couponCode']!),
      const SizedBox(height: 16),
            // _buildTextField('Description', controllers['description']!),
      const SizedBox(height: 16),
      const TextEditorQuill(),
      const SizedBox(height: 16),
            MyButtonAni(elevationsize: 10, text: "Post Offer", onTap: _postOffer)

           
          ],
        
      
    );
  }
}