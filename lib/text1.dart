import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart'; // Import the package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocator Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeolocatorWidget(),
    );
  }
}

class GeolocatorWidget extends StatefulWidget {
  const GeolocatorWidget({super.key});

  @override
  State<GeolocatorWidget> createState() => _GeolocatorWidgetState();
}

class _GeolocatorWidgetState extends State<GeolocatorWidget> {
  static const String _kLocationServicesDisabledMessage = 'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  Position? _currentPosition;
  String? _placeName;
  String? _pincode;
  String? _city;
  String? _state;
  String? _country;
  StreamSubscription<Position>? _positionStreamSubscription;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionAndFetchPosition();
  }

  Future<void> _checkPermissionAndFetchPosition() async {
    bool hasPermission = await _handlePermission();
    if (hasPermission) {
      _getCurrentPosition();
    }
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage(_kLocationServicesDisabledMessage);
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showMessage(_kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showMessage(_kPermissionDeniedForeverMessage);
      return false;
    }

    _showMessage(_kPermissionGrantedMessage);
    return true;
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

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _placeName = place.name;
        _city = place.locality;
        _state = place.administrativeArea;
        _country = place.country;
        _pincode = place.postalCode;
      });
    } catch (e) {
      _showMessage('Failed to get address.');
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.listen(
        (Position position) {
          setState(() {
            _currentPosition = position;
          });
          _getAddressFromLatLng(position);
        },
      );
    }

    if (_isListening) {
      _positionStreamSubscription?.pause();
    } else {
      _positionStreamSubscription?.resume();
    }

    setState(() {
      _isListening = !_isListening;
    });
  }

  Future<void> _launchMap() async {
    if (_currentPosition != null) {
      final availableMaps = await MapLauncher.installedMaps;
      if (availableMaps.isNotEmpty) {
        await availableMaps.first.showMarker(
          coords: Coords(_currentPosition!.latitude, _currentPosition!.longitude),
          title: 'Current Location',
        );
      } else {
        _showMessage('No map apps installed.');
      }
    } else {
      _showMessage('Location not available yet.');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocator Example'),
        actions: [
          IconButton(
            icon: Icon(_isListening ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleListening,
          ),
        ],
      ),
      body: Center(
        child: _currentPosition == null
            ? const Text('Press the button to get your location.')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Latitude: ${_currentPosition?.latitude}, Longitude: ${_currentPosition?.longitude}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Place Name: ${_placeName ?? 'Loading...'}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'City: ${_city ?? 'Loading...'}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'State: ${_state ?? 'Loading...'}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Country: ${_country ?? 'Loading...'}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Pincode: ${_pincode ?? 'Loading...'}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _launchMap,
                    icon: const Icon(Icons.map),
                    label: const Text('Open in Map'),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentPosition,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
