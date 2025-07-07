import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:hombuddy/pages/FlowsCreation/Flow5.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocation extends StatefulWidget {
  final String userID;

  const UserLocation(this.userID, {super.key});

  @override
  _UserLocationState createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  GoogleMapController? _mapController;
  Marker? _userLocationMarker;
  LatLng? _userLocation;
  LatLng? _selectedLocation;
  String? _selectedLocationName;
  bool _showMap = false;
  final GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey:
          'AIzaSyAjMtLGjJZw80TJM3BGgHys7GIEaM6uoYY'); // Replace with your API key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/images/Locationpic.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    await _requestLocationPermission();
                    setState(() {
                      _showMap = true;
                    });
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Row(
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(width: 20),
                              Text('Updating Location'),
                            ],
                          ),
                        );
                      },
                    );
                    await _fetchLocation(3);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor: const Color(0xFF0067A5), // Button color
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 8),
                      Text('Your Location'),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _showMap,
                child: Expanded(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _userLocation ?? const LatLng(0, 0),
                      zoom: 15,
                    ),
                    onTap: _onMapTapped,
                    markers: {
                      if (_selectedLocation != null)
                        Marker(
                          markerId: const MarkerId('selected_location'),
                          position: _selectedLocation!,
                          infoWindow: InfoWindow(
                            title: _selectedLocationName ?? 'Pinned Location',
                          ),
                        ),
                      if (_userLocation != null)
                        Marker(
                          markerId: const MarkerId('user_location'),
                          position: _userLocation!,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                          infoWindow: const InfoWindow(title: 'Your Location'),
                        ),
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic for "Other Location" button if needed
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor: const Color.fromARGB(
                        255, 182, 187, 192), // Button color
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 8),
                      Text('Other Location'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                _selectedLocationName ?? '',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 250, // Adjust the width as needed
                child: ElevatedButton(
                  onPressed: () {
                    if (_selectedLocation != null) {
                      saveLocationToFirestore(_selectedLocation!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NameSection(userID: widget.userID),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // Text color
                    backgroundColor:
                        const Color(0xFF003B5F), // Indigo Dye color
                  ),
                  child: const Text('Continue'),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (!status.isGranted) {
      print('Location permission denied');
    }
  }

  Future<void> _fetchLocation(int attempts) async {
    if (attempts > 0) {
      await _getCurrentLocation();
      if (_userLocation == null) {
        await Future.delayed(const Duration(seconds: 1));
        await _fetchLocation(attempts - 1);
      } else {
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_userLocation!, 15),
        );
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _selectedLocation = _userLocation;
      });
      await _getPlaceNameFromCoordinates(_userLocation!);
    } catch (e) {
      print('Could not fetch location: $e');
    }
  }

  Future<void> _getPlaceNameFromCoordinates(LatLng location) async {
    final response = await _places.searchNearbyWithRadius(
      Location(lat: location.latitude, lng: location.longitude),
      50,
    );

    if (response.results.isNotEmpty) {
      final placeId = response.results.first.placeId;
      final details = await _places.getDetailsByPlaceId(placeId);
      setState(() {
        _selectedLocationName = details.result.name;
      });
    } else {
      setState(() {
        _selectedLocationName = 'Unknown Location';
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  void _onMapTapped(LatLng latLng) async {
    setState(() {
      _selectedLocation = latLng;
    });
    await _getPlaceNameFromCoordinates(latLng);
  }

  void saveLocationToFirestore(LatLng location) {
    String locationName = _selectedLocationName ?? 'Pinned Location';
    FirebaseFirestore.instance.collection('User').doc(widget.userID).set({
      'Location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'name': locationName,
      }
    }, SetOptions(merge: true)).then((value) {
      print('User location saved successfully');
    }).catchError((error) {
      print('Failed to save user location: $error');
    });
  }
}
