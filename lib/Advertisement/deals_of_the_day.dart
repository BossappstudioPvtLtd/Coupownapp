import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupown/Const/web_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DealsAdd extends StatefulWidget {
  const DealsAdd({super.key});

  @override
  _DealsAddState createState() => _DealsAddState();
}

class _DealsAddState extends State<DealsAdd> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  List<String> imageUrls = []; // List to hold the fetched image URLs

  @override
  void initState() {
    super.initState();
    // Fetch trending deal ads
    _fetchAdvertisements();
  }

  final DatabaseReference _adsRef =
      FirebaseDatabase.instance.ref('advertisements/deals_of_the_day_ad');

  late DatabaseReference _databaseReference;
  List<Map<String, dynamic>> _header = [];
  bool _isLoading = false;
  int _currentIndex = 0;

  // Fetch advertisements from Firebase Realtime Database
  void _fetchAdvertisements() {
    setState(() {
      _isLoading = true; // Set loading to true when the fetch begins
    });

    _adsRef.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        var data = snapshot.value as Map<dynamic, dynamic>;
        List<Map<String, dynamic>> ads = [];
        data.forEach((key, value) {
          ads.add({
            'id': key,
            'companyName': value['companyname'] ?? '',
            'fromDate': value['fromDate'] ?? '',
            'toDate': value['toDate'] ?? '',
            'phone': value['phone'] ?? '',
            'selectedImage': value['selectedImage'] ?? '',
            'selectedOption': value['selectedOption'] ?? '',
            'webLink': value['webLink'] ?? '',
          });
        });

        // Create a list of ads that need to be removed (expired ads)
        List<String> expiredAds = [];
        ads.forEach((ad) {
          if (_isExpired(ad['toDate'])) {
            expiredAds.add(ad['id']);
          }
        });

        // Remove expired ads
        if (expiredAds.isNotEmpty) {
          Future.forEach(expiredAds, (adId) async {
            await _adsRef.child(adId).remove().then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Expired advertisement deleted')),
              );
            }).catchError((error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Failed to delete expired ad: $error')),
              );
            });
          }).then((_) {
            // After removing all expired ads, refresh the list of valid advertisements
            setState(() {
              _header = ads
                  .where((ad) => !_isExpired(ad['toDate']))
                  .toList();
              _updateImageUrls(); // Update the image URLs for the slider
              _startImageSlider(); // Start automatic sliding
              _isLoading = false; // Set loading to false when done
            });
          });
        } else {
          // If no expired ads were found, just update the list
          setState(() {
            _header = ads;
            _updateImageUrls(); // Update the image URLs for the slider
            _startImageSlider(); // Start automatic sliding
            _isLoading = false; // Set loading to false when done
          });
        }
      } else {
        setState(() {
          _isLoading = false; // Set loading to false if no data found
        });
      }
    });
  }

  // Check if the advertisement has expired
  bool _isExpired(String toDate) {
    String cleanedDate = toDate.split('>')[0].trim(); // Clean unwanted characters
    try {
      final currentDate = DateTime.now();
      final expiryDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(cleanedDate);
      return currentDate.isAfter(expiryDate) ||
          currentDate.isAtSameMomentAs(expiryDate);
    } catch (e) {
      print('Error parsing date: $e');
      return false; // Assume the date is not expired in case of error
    }
  }

  // Update the imageUrls list based on fetched ads
  void _updateImageUrls() {
    setState(() {
      imageUrls = _header.map((ad) => ad['selectedImage'] as String).toList();
    });
  }

  // Start the image slider timer
  void _startImageSlider() {
    if (_timer != null) {
      _timer?.cancel(); // Cancel any existing timer
    }
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imageUrls.length - 1) {
        _currentPage++; // Move to the next page
      } else {
        _currentPage = 0; // Loop back to the first image
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void _openWebView(String url,  String phoneNumber) {
    if (url.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WebViewScreen(url: url, phoneNumber: phoneNumber,),
        ),
      );
    } else {
      print("No web link available for this ad.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No web link available."),
        ),
      );
    }
  }


  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  final double sliderHeight = screenWidth * 0.4;

  return SizedBox(
    height: sliderHeight,
    child: Padding(
      padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding based on screen width
      child: _isLoading || imageUrls.isEmpty
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Show a few shimmer placeholders
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.8, // Adjust placeholder width
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // Adjust margin
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(screenWidth * 0.04), // Adjust border radius
                    ),
                  );
                },
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
  final ad = _header[index]; // Use _header to get the full advertisement data
  final imageUrl = ad['selectedImage']; // Get the image URL
  return InkWell(
    onTap: () {
      _openWebView(ad['webLink'],ad["phone"]); // Access the webLink from the ad map
    },
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02), // Adjust margin
      child:ClipRRect(
  borderRadius: BorderRadius.circular(screenWidth * 0.04), // Adjust border radius
  child: CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.fill,
    width: screenWidth * 0.8, // Adjust width as needed
    height: screenHeight * 0.1, // Adjust height as needed
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.1,
        color: Colors.white, // Shimmer effect background
      ),
    ),
    errorWidget: (context, url, error) => Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.1,
      color: Colors.grey[300], // Optional background color for error widget
      child: const Center(
        child: Icon(Icons.error, color: Colors.red), // Show error icon
      ),
    ),
  ),
),
    ),
  );
}

                  ),
                ),
              ],
            ),
    ),
  );
}

}
