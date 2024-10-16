import 'package:coupown/Const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async'; // For Timer

class LocationTracker extends StatefulWidget {
  const LocationTracker({super.key});

  @override
  _LocationTrackerState createState() => _LocationTrackerState();
}

class _LocationTrackerState extends State<LocationTracker> {
  Position? _currentPosition;
  Position? _previousPosition;
  String _locationMessage = "";
  double _distanceMoved = 0.0; // Distance in meters
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _startTimer(); // Start the timer to check location every minute
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Function to get the current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if the location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  // Timer to check location every minute
  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await _updateLocationAndCalculateDistance();
    });
  }

  // Function to update location and calculate distance difference
  Future<void> _updateLocationAndCalculateDistance() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (_previousPosition != null) {
      // Calculate the distance between previous and current position
      double distanceInMeters = Geolocator.distanceBetween(
        _previousPosition!.latitude,
        _previousPosition!.longitude,
        position.latitude,
        position.longitude,
      );

      setState(() {
        _distanceMoved += distanceInMeters;
      });
    }

    setState(() {
      _previousPosition = _currentPosition; // Store the current position
      _currentPosition = position;
      _locationMessage =
          "Lat: ${position.latitude}, Long: ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Current Location:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        const  SizedBox(height: 10),
          _currentPosition != null
              ? Card(
                  color: appColorPrimary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _locationMessage,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )
              :const CircularProgressIndicator(),
          const SizedBox(height: 20),
          // Display the distance moved
          _distanceMoved > 0
              ? Text(
                  "Distance moved: ${_distanceMoved.toStringAsFixed(2)} meters",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                )
              : Container(),
        ],
      ),
    );
  }
}
