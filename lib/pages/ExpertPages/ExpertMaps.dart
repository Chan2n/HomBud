import 'dart:async';
import 'dart:math'; // Import the math library
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/ChatScreen.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final String userID;
  final String expertID;

  const MapScreen({super.key, required this.userID, required this.expertID});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0); // Default initial position
  LatLng? _userPosition; // Position of the user
  Location location = Location();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isTracking = true; // Initially start tracking
  bool arrivalDialogShown = false; // Track if the arrival dialog has been shown
  final Set<Polyline> _polylines = <Polyline>{};
  final Set<Marker> _markers = <Marker>{};
  StreamSubscription<LocationData>? _locationSubscription;
  double _distance = 0.0; // Variable to store the distance

  @override
  void initState() {
    super.initState();
    _getUserLocation(); // Get the initial position for the expert
    _trackUserLocation(); // Start tracking when the map is created
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return; // Exit if permissions are not granted
      }
    }

    var userLocation = await location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(userLocation.latitude!, userLocation.longitude!);
      _updateMapLocationAndRoute();
    });
  }

  void _trackUserLocation() {
    _locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      if (isTracking) {
        setState(() {
          _currentPosition =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _updateMapLocationAndRoute();
          _checkProximity(); // Check proximity to user location
        });
      }
    });

    firestore
        .collection('User')
        .doc(widget.userID)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        var userLocation = snapshot.data()!['Location'];
        if (userLocation != null) {
          setState(() {
            _userPosition =
                LatLng(userLocation['latitude'], userLocation['longitude']);
            _updateMapLocationAndRoute();
          });
        }
      }
    });
  }

  void _updateMapLocationAndRoute() {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId("expert_location"),
        position: _currentPosition,
        infoWindow: const InfoWindow(title: "Expert Location"),
      ));
      if (_userPosition != null) {
        _markers.add(Marker(
          markerId: const MarkerId("user_location"),
          position: _userPosition!,
          infoWindow: const InfoWindow(title: "User Location"),
        ));

        // Draw polyline
        _polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: [_currentPosition, _userPosition!],
          color: Colors.blue,
          width: 5,
        ));

        // Calculate the distance
        _distance = calculateDistance(
          _currentPosition.latitude,
          _currentPosition.longitude,
          _userPosition!.latitude,
          _userPosition!.longitude,
        );
      }

      if (isTracking) {
        mapController.animateCamera(CameraUpdate.newLatLng(_currentPosition));
      }
    });
  }

  void _checkProximity() {
    if (_userPosition != null) {
      double distance = calculateDistance(
        _currentPosition.latitude,
        _currentPosition.longitude,
        _userPosition!.latitude,
        _userPosition!.longitude,
      );
      if (distance <= 2.0 && !arrivalDialogShown) {
        // Check if within 2 meters and the dialog hasn't been shown yet
        _showArrivalBottomSheet();
      }
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double p = 0.017453292519943295; // Pi/180
    double a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  void _showArrivalBottomSheet() {
    arrivalDialogShown = true; // Mark the dialog as shown
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Arrival Confirmation",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text("You have safely arrived at the destination."),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _showSendPhotoBottomSheet(); // Show the next dialog
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF003B5F),
                  ),
                  child: const Text("I have Arrived"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSendPhotoBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Send Photo",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                    "Please send a photo to HomeBuddy showing your arrival with home repair."),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _openChatScreen(); // Navigate to the chat screen
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF003B5F),
                  ),
                  child: const Text("Connect to Messenger"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openChatScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          userId: widget.userID,
          expertId: widget
              .expertID, // Ensure this matches the parameter name in ChatScreen
          isExpert: true, // Pass this flag to indicate it's the expert
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 15.0,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true, // Enable user's location
            myLocationButtonEnabled: true, // Enable location button
          ),
          Positioned(
            top: 50,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isTracking = !isTracking; // Toggle tracking state
                  if (isTracking) {
                    // Recenter map to current location if tracking is enabled
                    mapController.animateCamera(
                        CameraUpdate.newLatLng(_currentPosition));
                  }
                });
              },
              backgroundColor: isTracking ? Colors.red : Colors.blue,
              child: Icon(
                  isTracking ? Icons.location_off : Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }
}
