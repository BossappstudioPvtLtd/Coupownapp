import 'dart:io';

import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/Screanes/subscription/verify_details.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geocoding/geocoding.dart'; // Import this for address reverse geocoding

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final _picker = ImagePicker();

  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _websiteController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _stateController = TextEditingController();
  final _cityController = TextEditingController();
  final _buildingController = TextEditingController();
  final _roadController = TextEditingController();
  final _landmarkController = TextEditingController();

  String? _selectedCategory;
  String? _selectedSubCategory; // Change to a single string

  final _categories = ['Restaurant', 'Hotel','Shop','Office','Fashions', 'Food & Dining','Home & Living','Furnitures','Electrical Appliances', 'Mobiles & Electronics','Books & Stationery', 'Grocery', 'Beauty & Health', 'Entertainment', 'Sports Products','Gifts & Jewels', 'Automobiles', 'Local Home Services', 'Transportation Services', 'Travel & Hospitality','Others'];
   final Map<String, List<String>> _subCategories = {
    'Fashions': [
      'Clothing',
      'Footwear',
      'Watch & Sunglass',
      'Travel & Accessories',
      'All',
    ],
    'Food & Dining': [
      'Restaurants',
      'Drinks and Beverages',
      'Street Food',
      'Fast Food',
      'All',
    ],
    'Home & Living': [
      'Furniture & Decor',
      'Kitchen & Dining',
      'Bed & Bath',
      'All',
    ],
    'Electrical Appliances': [
      'Cooling Appliances',
      'Refrigerator',
      'Television',
      'Washing Machine',
      'Kitchen Accessories',
      'All',
    ],
    // Add more subcategories as needed
  };
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

  static const String _kLocationServicesDisabledMessage ='Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _currentPosition;
  bool _isLoading = false; // Step 1: Create a loading state


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideInAnimation = Tween<Offset>(begin: const Offset(0, 2.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  Future<void> _getCurrentPosition() async {
    // Step 1: Show loading dialog
    final loadingDialog = showCupertinoDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (BuildContext context) {
        return const CupertinoAlertDialog(
          content: Row(
            children: [
              CupertinoActivityIndicator(), // Cupertino loader
              SizedBox(width: 20), // Space between loader and text
              Text("Fetching location..."),
            ],
          ),
        );
      },
    );

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng(position);
    } catch (e) {
      // Handle error (e.g., show a message)
      print('Error fetching location: $e');
    } finally {
      // Step 2: Dismiss the loading dialog
      Navigator.of(context).pop(); // Close the loading dialog
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _pincodeController.text = place.postalCode ?? '';
        _cityController.text = place.locality ?? '';
        _stateController.text = place.administrativeArea ?? '';
        _roadController.text = place.street ?? '';
        _buildingController.text = place.subLocality ?? '';
      });
    } catch (e) {
      _showMessage('Failed to get address.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _submitForm() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Form Submitted')),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label,
      {TextInputType type = TextInputType.text, bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SlideTransition(
        position: _slideInAnimation,
        child: FadeTransition(
          opacity: _fadeInAnimation,
          child: Material(
            color: appColorPrimary,
            borderRadius: BorderRadius.circular(8),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  labelText: label,
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: type,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(245, 237, 247, 251),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            backgroundColor: Color.fromARGB(245, 237, 247, 251),
            title: Text('Create Subscriber'),
            pinned: true,
            floating: false,
            elevation: 5,
            expandedHeight: 60,
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                              backgroundColor: appColorPrimary,
                              radius: 30,
                              backgroundImage: _image != null ? FileImage(_image!) : null,
                              foregroundColor: Colors.transparent,
                              child: _image == null
                                  ? const Textedit(
                                      color: appTextColorSecondary,
                                      text: 'Logo',
                                    )
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 20),
                          const Textedit(
                            color: iconColorSecondary,
                            text: '(File format as PNG or JPEG only)',
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(_nameController, 'Name', isRequired: true),
                    _buildTextField(_mobileController, 'Mobile Number', type: TextInputType.phone, isRequired: true),
                    _buildTextField(_websiteController, 'Website Link'),
                   Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 5),
      child: Column(
        children: [
           Material(
                        color: appColorPrimary,
                        borderRadius: BorderRadius.circular(8),
                        elevation: 5,
                        child: Container(
                          height: 52,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: DropdownButtonFormField<String>(
                              menuMaxHeight: 300,
                              borderRadius: BorderRadius.circular(8),
                              dropdownColor: appColorPrimary,
                              decoration: const InputDecoration(
                                labelText: 'Category',
                                labelStyle:TextStyle(color: appTextColorPrimary) ,
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                              ),
                              value: _selectedCategory,
                              items: _categories.map((category) {
                                return DropdownMenuItem(value: category, child: Text(category));
                              }).toList(),
                              onChanged: (value) => setState(() => _selectedCategory = value),
                            ),
                          ),
                        ),
                      ),
          if (_selectedCategory != null && _subCategories.containsKey(_selectedCategory))
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                
                  color: Colors.transparent,
                child: Container(
                  width: 400,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 1, // Adjust spacing between items
                        runSpacing: 1, // Adjust spacing between rows
                        children: _subCategories[_selectedCategory!]!.map((subCategory) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedSubCategory = subCategory; // Set the selected subcategory
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(8.0), // Add some padding
                                decoration: BoxDecoration(
                                  color: _selectedSubCategory == subCategory
                                      ? Colors.green // Highlight selected item
                                      : Colors.white , // Default color
                                  border: Border.all(color:appColorAccent), // Optional border
                                  borderRadius: BorderRadius.circular(12.0), // Optional rounded corners
                                ),
                                child: Text(
                                  subCategory,
                                  style: TextStyle(
                                    color: _selectedSubCategory == subCategory
                                        ? appColorPrimary // Change text color for selected item
                                        : appTextColorPrimary, // Default text color
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              //          if (_selectedSubCategory != null) // Update condition to check for single selection
              // Card(
              //   color: appColorPrimary,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              //     child: Text(
              //       'Selected Subcategory: $_selectedSubCategory', // Show only the selected subcategory
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
                    ],
                  ),
              
                ),
              ),
            ),
         
        ],
      ),
    ),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_pincodeController, 'Pincode', type: TextInputType.number)),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _getCurrentPosition,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(appColorAccent),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.gps_fixed),
                              Textedit(text: 'Use My Location', fontSize: 10, color: appColorPrimary),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _buildTextField(_stateController, 'State')),
                        const SizedBox(width: 10),
                        Expanded(child: _buildTextField(_cityController, 'City')),
                      ],
                    ),
                    _buildTextField(_buildingController, 'Building Number'),
                    _buildTextField(_roadController, 'Area Road Name'),
                    _buildTextField(_landmarkController, 'Nearby Landmark'),
                    MyButtonAni(
                      elevationsize: 20,
                      text: "Submit",
                      onTap: () {
                        _submitForm();
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const VerifyDetails()));
                      },
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
