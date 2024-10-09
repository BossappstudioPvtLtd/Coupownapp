
import 'package:coupown/Screanes/subscription/data_editing.dart';
import 'package:coupown/Screanes/subscription/plan_screen.dart';
import 'package:coupown/components/text_edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coupown/Const/app_colors.dart';
import 'package:coupown/components/my_appbar.dart';
import 'package:coupown/components/my_button_ani.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class VerifyDetails extends StatefulWidget {
  const VerifyDetails({super.key});

  @override
  _VerifyDetailsState createState() => _VerifyDetailsState();
}

class _VerifyDetailsState extends State<VerifyDetails>
    with SingleTickerProviderStateMixin {
  final Map<String, dynamic> deal = {
    'logoUrl': 'assets/avatar/avatar.png',
    'name': 'Dealer Name',
    'location': 'No 32, Roys Complex, Tuticorin Road, Pudukottai, Tuticorin',
  };

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;

   
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _roadController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Position? _currentPosition; 
  

  static const String _kLocationServicesDisabledMessage ='Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';


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

    _slideInAnimation =
        Tween<Offset>(begin: const Offset(0, 1.0), end: Offset.zero).animate(
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
    _landmarkController.dispose();
    super.dispose();
  }
   
    Future<void> _getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentPosition = position;
    });
    _getAddressFromLatLng(position);
  }

    void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
        _landmarkController.text = place.subLocality ?? '';
      });
    } catch (e) {
      _showMessage('Failed to get address.');
    }
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


  Widget _buildTextField(TextEditingController controller, String label,
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
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: appColorPrimary,
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyAppbar(text: "Verify Details"),
              SlideTransition(
                position: _slideInAnimation,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: isSmallScreen ? 39 : 39,
                      backgroundColor: appColorAccent,
                      child: CircleAvatar(
                        radius: isSmallScreen ? 37 : 37,
                        backgroundColor: appColorPrimary,
                        child: deal['logoUrl'] != null &&
                                deal['logoUrl'].isNotEmpty
                            ? Image.asset(
                                deal['logoUrl'],
                                fit: BoxFit.fill,
                                height: 400,
                                width: 400,
                              )
                            : const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal['name'],
                            style: TextStyle(
                                fontSize: isSmallScreen ? 20 : 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ac Mechanical',
                            style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DataEditing())),
                      icon: const Icon(Icons.movie_edit, size: 30),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 24),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        deal['location'],
                        style: TextStyle(fontSize: isSmallScreen ? 16 : 18),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Add the new Padding with Dropdown and Form
              TextButton.icon(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            height: 500,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: appColorPrimary,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildTextField(
                                      _addressController, 'Address'),
                                  _buildTextField(
                                      _roadController, 'Area Road Name'),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildTextField(
                                              _pincodeController, 'Pincode',
                                              type: TextInputType.number)),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: _getCurrentPosition ,
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    appColorAccent)),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.gps_fixed,
                                              color: appColorPrimary,
                                            ),
                                            Textedit(
                                                text: 'Use My Location',
                                                fontSize: 10,
                                                color: appColorPrimary),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: _buildTextField(
                                              _stateController, 'State')),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: _buildTextField(
                                              _cityController, 'City')),
                                    ],
                                  ),
                                  _buildTextField(_landmarkController,
                                      '+ Add Nearby famous Landmark'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  MyButtonAni(
                                    elevationsize: 20,
                                    text: "Submit",
                                    onTap: () {
                                      _submitForm();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                label: const Text(" Add Another Location"),
                icon: const Icon(Icons.add_circle_outline,
                    size: 24, color: appTextColorPrimary),
              ),

              const Spacer(),
              MyButtonAni(
                elevationsize: 20,
                text: "Submit",
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const PlanScreen()));
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
