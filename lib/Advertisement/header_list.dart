
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupown/Const/web_view.dart';
import 'package:coupown/widgets/image_slider_widgets.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HeaderList extends StatefulWidget {
  const HeaderList({super.key});

  @override
  _HeaderListListState createState() => _HeaderListListState();
}

class _HeaderListListState extends State<HeaderList> {
  final DatabaseReference _adsRef = FirebaseDatabase.instance.ref('advertisements/header_ad');

  late DatabaseReference _databaseReference;
  List<Map<String, dynamic>> _header = [];
  bool _isLoading = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchAdvertisements();
  }

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
                SnackBar(content: Text('Failed to delete expired ad: $error')),
              );
            });
          }).then((_) {
            // After removing all expired ads, refresh the list of valid advertisements
            setState(() {
              _header = ads.where((ad) => !_isExpired(ad['toDate'])).toList();
              _isLoading = false; // Set loading to false when done
            });
          });
        } else {
          // If no expired ads were found, just update the list
          setState(() {
            _header = ads;
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
      final expiryDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(cleanedDate);
      return currentDate.isAfter(expiryDate) || currentDate.isAtSameMomentAs(expiryDate);
    } catch (e) {
      print('Error parsing date: $e');
      return false; // Assume the date is not expired in case of error
    }
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
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Sort the advertisements by 'fromDate' in descending order
    _header.sort((a, b) {
      DateTime fromDateA = DateTime.parse(a['fromDate']);
      DateTime fromDateB = DateTime.parse(b['fromDate']);
      return fromDateB.compareTo(fromDateA);
    });

    return _isLoading
        ? _buildShimmerEffect(screenWidth, screenHeight) // Show shimmer while loading
        : _header.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CarouselSlider.builder(
                    itemCount: _header.length,
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      final ad = _header[index];
                      double imageSize = _currentIndex == index
                          ? screenWidth * 0.9
                          : screenWidth * 0.7;

                      return Container(
                        width: double.infinity,
                        height: 200,
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(screenWidth * 0.03),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: GestureDetector(
                            onTap: ()  {_openWebView(ad["webLink"],ad["phone"]); },
                child:ClipRRect(borderRadius: BorderRadius.circular(screenWidth * 0.03),
              child: ad['selectedImage'] != null
                  ? CachedNetworkImage(
                   imageUrl: ad['selectedImage'],
                  fit: BoxFit.fill,
          width: imageSize,
          height: screenHeight * 0.1,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: imageSize,
              height: screenHeight * 0.1,
              color: Colors.white,
            ),
          ), // Shimmer effect
          errorWidget: (context, url, error) => const Icon(Icons.error), // Show on error
        )
      : const SizedBox.shrink(),
          ),
        ),
                      );
                    },
                    options: CarouselOptions(
                      height: screenHeight * 0.2,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  CarouselIndicator(
                    itemCount: _header.length,
                    currentIndex: _currentIndex,
                    screenWidth: screenWidth,
                  ),
                  
                ],
              );
  }

  // Shimmer Effect while loading
  Widget _buildShimmerEffect(double screenWidth, double screenHeight) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            margin: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.05),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

