import 'dart:async';
import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shimmer/shimmer.dart';

class GoogleMapExample extends StatefulWidget {
  const GoogleMapExample({super.key});

  @override
  _GoogleMapExampleState createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? _googleMapController;
  Position? _currentPosition;
  LatLng? _currentLatLng;
  Marker? _currentLocationMarker;

  // Initial Camera Position (fallback in case location is not found yet)
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng( 8.5241, 76.9366), // San Francisco coordinates
    zoom: 12,
  );

  @override
  void initState() {
    super.initState();
    _getUserCurrentLocation();
  }

  Future<void> _getUserCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || 
        permission == LocationPermission.deniedForever) {
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _currentLocationMarker = Marker(
        markerId: const MarkerId('currentLocation'),
        position: _currentLatLng!,
        infoWindow: const InfoWindow(title: 'Your Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      );
    });

    // Move the camera to the user's location as soon as it's fetched
    if (_googleMapController != null) {
      _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentLatLng!, zoom: 16),
      ));
    }
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: _currentLatLng == null
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[300],
                height: double.infinity,
                width: double.infinity,
              ),
            )
          : GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: _initialCameraPosition,
              onMapCreated: (GoogleMapController mapController) {
                _controllerGoogleMap.complete(mapController);
                _googleMapController = mapController; // Set the controller
              },
              markers: _currentLocationMarker != null
                  ? {_currentLocationMarker!}
                  : {},
            ),
       floatingActionButton: Positioned(
         child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32), // Adjust the border radius as needed
          ),
          backgroundColor: appColorPrimary,
          onPressed: _getUserCurrentLocation, // Fetch and update location
          child: const Icon(
            Icons.my_location,
            color: appColorAccent,
          ),
               ),
       ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Positioning the button at the bottom center
    

    );
  }
}
