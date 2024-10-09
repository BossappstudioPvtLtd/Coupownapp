import 'dart:io';
import 'dart:math';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/dealer_screan.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

class AddJobOffer extends StatefulWidget {
  const AddJobOffer({super.key});

  @override
  State<AddJobOffer> createState() => _AddJobOfferState();
}

class _AddJobOfferState extends State<AddJobOffer> {
  
   late quill.QuillController _quillController;
  final FocusNode _focusNode = FocusNode();
  final String _documentKey = 'saved_document';
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
    "mobilenumber":TextEditingController(),
    "email": TextEditingController(),
  };

 @override
  void initState() {
    super.initState();
    _quillController = quill.QuillController.basic();
    _loadDocument();
  }
 Future<void> _loadDocument() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDocument = prefs.getString(_documentKey);
    if (savedDocument != null) {
      final document = quill.Document.fromJson(
          List<Map<String, dynamic>>.from(prefs.get(_documentKey) as List));
      setState(() {
        _quillController = quill.QuillController(
          document: document,
          selection: const TextSelection.collapsed(offset: 0),
        );
      });
    }
  }
   // Save document to shared preferences
  Future<void> _saveDocument() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonDocument = _quillController.document.toDelta().toJson();
    await prefs.setString(_documentKey, jsonDocument.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document saved!')),
    );
  }


// Clear the saved document
  Future<void> _clearDocument() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_documentKey);
    setState(() {
      _quillController = quill.QuillController.basic();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Document cleared!')),
    );
  }
  @override
  void dispose() {
    
    _quillController.dispose();
    _focusNode.dispose();
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
    bool _validateDocument() {
    final documentText = _quillController.document.toPlainText();
    if (documentText.trim().isEmpty) { // Check for empty or whitespace-only content
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('please enter Description!')),
      );
      return false;
    }
    return true;
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, bool isDate = false, required double fontSize}) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: SingleChildScrollView(
          child: TextField( controller: controller,
            decoration: InputDecoration( labelText: label, border: InputBorder.none,
            suffixIcon: isDate ? IconButton( icon: const Icon(Icons.calendar_today), onPressed: () => _selectDate(context, controller),) : null,),
            keyboardType: isNumber ? TextInputType.number : TextInputType.text, readOnly: isDate,
          ),
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
  final baseFontSize = isSmallScreen ? 15.0 : isWideScreen ? 18.0 : 16.0; // Base font size for small, wide, and normal screens
  
  return Scaffold(
    backgroundColor: appColorPrimary,
  body: SingleChildScrollView(
    child: Column(
        children: [
          // Your content, starting with the SizedBox and other widgets
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload Photo",
                  style: TextStyle(fontSize: baseFontSize + 2),
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
                              style: TextStyle(fontSize: baseFontSize),
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
                                    fontSize: baseFontSize,
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
                  fontSize: baseFontSize,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  'Offer End',
                  controllers['endDate']!,
                  isDate: true,
                  fontSize: baseFontSize,
                ),
              ),
            ],
          ),
          _buildTextField('Position', controllers['position']!, fontSize: baseFontSize),
          _buildTextField('Experience', controllers['experience']!, isNumber: true, fontSize: baseFontSize),
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
                      style: TextStyle(fontSize: baseFontSize),
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
                    fontSize: baseFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // TextEditorQuill(),
            Card(
          
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(  'Description',),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material( elevation: 2,
                   borderRadius: BorderRadius.circular(8),
                  child: QuillSimpleToolbar(
                              controller: _quillController,
                              configurations:  QuillSimpleToolbarConfigurations(
                              decoration: BoxDecoration(  color:Colors.white, borderRadius: BorderRadius.circular(8)),
                              sectionDividerColor:appColorAccent,
                              toolbarIconAlignment: WrapAlignment.start,
                              toolbarSectionSpacing: sqrt2,
                              multiRowsDisplay: false,
                              toolbarSize: 30,
                              showFontSize: true,
                              showJustifyAlignment: true,
                              showListCheck: true,
                              showCodeBlock: true,
                              showInlineCode: true,
                              showQuote: true,
                              showStrikeThrough: true,
                              showUnderLineButton: true,
                              showBoldButton: true,
                              showItalicButton: true,
                            ),
                          ),),
                ),
                    
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                      color:const Color.fromARGB(235, 247, 247, 250),
                      borderRadius: BorderRadius.circular(8),
                            child: Padding(
                            
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              child: quill.QuillEditor(
                                scrollController: ScrollController(),
                                focusNode: _focusNode,
                                controller: _quillController,
                              ),
                            ),
                          ),
                    ),
                      
                    const SizedBox(height: 20,)
                  ],
                ),
              
          ),
          const SizedBox(height: 16),
          _buildTextField('Mobile Number', controllers['mobilenumber']!, isNumber: true, fontSize: baseFontSize),
          const SizedBox(height: 16),
          _buildTextField('Email', controllers['email']!, fontSize: baseFontSize),
          const SizedBox(height: 40),
          MyButtonAni(elevationsize: 10, text: "Post ", onTap:() { _postOffer();_validateDocument();
          
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const DealerHomescrean()));}),
         
    
          const SizedBox(height: 40),
        ],
      ),
    ),
  
);

}
}