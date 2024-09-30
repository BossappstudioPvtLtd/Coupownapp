import 'dart:io';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit_quill.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddJobOffer extends StatefulWidget {
  const AddJobOffer({super.key});

  @override
  State<AddJobOffer> createState() => _AddJobOfferState();
}

class _AddJobOfferState extends State<AddJobOffer> {
  File? _pickedImage;
   final Map<String, dynamic> deal = {
    'logoUrl': 'assets/exclusive/upload.png',
    'name': 'Dealer Name',
    'location': 'No 32, Roys Complex, Tuticorin Road, Pudukottai, Tuticorin',
  };
   // List of offers or product names
  final List<String> workType = ['Full Time ', 'Part Time', 'Day Shift', 'Night Shift'];
  
  // Variable to hold the selected value
  String? selectedworkType;

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
    'position': TextEditingController(),
    'experience': TextEditingController(),
    'description': TextEditingController(),
    "mobailenumber":TextEditingController(),
    "email": TextEditingController(),
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

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, bool isDate = false, required double fontSize}) {
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
  final baseFontSize = isSmallScreen ? 12.0 : isWideScreen ? 18.0 : 16.0; // Base font size for small, wide, and normal screens
  
  return ListView(
    children: [
      SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload Photo",
              style: TextStyle(fontSize: baseFontSize + 2), // Dynamic font size
            ),
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
                        Text(
                          "Add",
                          style: TextStyle(fontSize: baseFontSize), // Dynamic font size
                        ),
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
                        : Center(
                            child: Text(
                              'No Image Selected',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: baseFontSize, // Dynamic font size
                              ),
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
      Row(
        children: [
          Expanded(
            child: _buildTextField(
              'Offer Start', 
              controllers['startDate']!, 
              isDate: true,
              fontSize: baseFontSize, // Pass the font size dynamically
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTextField(
              'Offer End', 
              controllers['endDate']!, 
              isDate: true,
              fontSize: baseFontSize, // Pass the font size dynamically
            ),
          ),
        ],
      ),
      _buildTextField('Position', controllers['position']!, fontSize: baseFontSize), // Dynamic font size
      _buildTextField('Experience', controllers['experience']!, isNumber: true, fontSize: baseFontSize), // Dynamic font size
      const SizedBox(height: 16),
      Card(
        color: Colors.white,
        child: DropdownButtonFormField<String>(
          borderRadius: BorderRadius.circular(8),
          dropdownColor: appColorPrimary,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          value: selectedworkType,
          items: workType.map((branch) {
            return DropdownMenuItem<String>(
              value: branch,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  branch,
                  style: TextStyle(fontSize: baseFontSize), // Dynamic font size
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              selectedworkType = newValue;
            });
          },
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Select Work Type",
              style: TextStyle(
                color: Color.fromARGB(255, 123, 123, 123),
                fontSize: baseFontSize, // Dynamic font size
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      const TextEditorQuill(),
      const SizedBox(height: 16),
      _buildTextField('Mobaile Number', controllers['mobailenumber']!, isNumber: true, fontSize: baseFontSize), // Dynamic font size
      const SizedBox(height: 16),
      _buildTextField('Email', controllers['email']!, fontSize: baseFontSize), // Dynamic font size
      const SizedBox(height: 16),
      MyButtonAni(elevationsize: 10, text: "Post Job", onTap: _postOffer),
    ],
  );
}

}