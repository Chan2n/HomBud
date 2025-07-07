import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:google_maps_webservice/places.dart' as places;

class SavedLocations extends StatefulWidget {
  final UserModel userModel;

  const SavedLocations({super.key, required this.userModel});

  @override
  _SavedLocationsState createState() => _SavedLocationsState();
}

class _SavedLocationsState extends State<SavedLocations> {
  bool isRecentSelected = true;
  bool _isLoading = false; // Loading state
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  String _currentAddress = '';
  LatLng? _newLocation;
  List<Map<String, dynamic>> savedLocations = [];

  final places.GoogleMapsPlaces placesApi = places.GoogleMapsPlaces(
      apiKey:
          'AIzaSyAjMtLGjJZw80TJM3BGgHys7GIEaM6uoYY'); // Add your API key here

  @override
  void initState() {
    super.initState();
    _fetchSavedLocations();
  }

  void _fetchSavedLocations() async {
    setState(() {
      _isLoading = true;
    });
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userModel.idNumber)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        var locations = userDoc['Location'] as Map<String, dynamic>;
        setState(() {
          savedLocations = (locations['saved'] as List<dynamic>?)
                  ?.map((e) => e as Map<String, dynamic>)
                  .toList() ??
              [];
          if (widget.userModel.location.isEmpty) {
            widget.userModel.location =
                locations['recent'] ?? ''; // Update recent location
          }
        });
      }
    } catch (e) {
      print('Error fetching saved locations: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateRecentLocation(Map<String, dynamic> location) async {
    setState(() {
      _isLoading = true;
    });
    try {
      DocumentReference userDoc = FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userModel.idNumber);

      await userDoc.update({
        'Location.recent': location['name'],
        'Location.name': location['name'], // Add this line to update the name
      });

      setState(() {
        widget.userModel.location = location['name'];
      });

      _fetchSavedLocations();
    } catch (e) {
      print('Error updating recent location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Text('Home'),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRecentSelected = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: isRecentSelected
                                  ? const Color(0xFF003B5F)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: isRecentSelected
                                  ? null
                                  : Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              'Recent',
                              style: TextStyle(
                                color: isRecentSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isRecentSelected = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: !isRecentSelected
                                  ? const Color(0xFF003B5F)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              border: !isRecentSelected
                                  ? null
                                  : Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              'Saved',
                              style: TextStyle(
                                color: !isRecentSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: isRecentSelected
                      ? _buildRecentLocations(context)
                      : _buildSavedLocations(context),
                ),
              ],
            ),
    );
  }

  Widget _buildRecentLocations(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 22), // Add padding here
      children: [
        InkWell(
          onTap: () {
            _showFullAddressDialog(context, widget.userModel.location);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20), // Add margin here
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 15,
                ),
                const SizedBox(width: 10),
                const Text(
                  'Current Location',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Tooltip(
                      message: widget.userModel.location,
                      child: Text(
                        widget.userModel.location,
                        style: const TextStyle(fontSize: 14),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                        maxLines: 1, // Allow text to wrap up to 2 lines
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...savedLocations.map((location) => Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 12), // Add margin here
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 15,
                      child: Icon(
                        location['type'] == 'home'
                            ? Icons.home
                            : Icons.business,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        location['name'] ?? 'Unknown Location',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildSavedLocations(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16), // Add padding here
      children: [
        InkWell(
          onTap: () => _showAddLocationModal(context, 'home'),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10), // Add margin here
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Row(
              children: [
                Icon(Icons.add, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Add New Home Location',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        InkWell(
          onTap: () => _showAddLocationModal(context, 'work'),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 1), // Add margin here
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Row(
              children: [
                Icon(Icons.add, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  'Add New Work Location',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        ...savedLocations.map((location) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildSavedLocationItem(location),
            )),
      ],
    );
  }

  Widget _buildSavedLocationItem(Map<String, dynamic> location) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5), // Add margin here
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 15,
            child: Icon(
              location['type'] == 'home' ? Icons.home : Icons.business,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              location['name'] ?? 'Unknown Location',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteLocation(location),
          ),
        ],
      ),
    );
  }

  void _deleteLocation(Map<String, dynamic> location) async {
    setState(() {
      _isLoading = true;
    });
    try {
      DocumentReference userDoc = FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userModel.idNumber);

      await userDoc.update({
        'Location.saved': FieldValue.arrayRemove([location])
      });

      _fetchSavedLocations();
    } catch (e) {
      print('Error deleting location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAddLocationModal(BuildContext context, String locationType) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(10.3157, 123.8854),
                            zoom: 12,
                          ),
                          markers: _markers,
                          onMapCreated: (GoogleMapController controller) {
                            _controller = controller;
                          },
                          onTap: (LatLng latLng) {
                            _addNewLocation(latLng, setState);
                          },
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          compassEnabled: true,
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: FloatingActionButton(
                            onPressed: () {
                              _getUserLocation(setState);
                            },
                            child: const Icon(Icons.gps_fixed),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _saveNewLocation(locationType, context);
                          },
                          child: const Text('Set New Location'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _getUserLocation(StateSetter setState) async {
    try {
      var serviceEnabled = await loc.Location().serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await loc.Location().requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      var permissionGranted = await loc.Location().hasPermission();
      if (permissionGranted == loc.PermissionStatus.denied) {
        permissionGranted = await loc.Location().requestPermission();
        if (permissionGranted != loc.PermissionStatus.granted) {
          return;
        }
      }

      var locData = await loc.Location().getLocation();
      _animateToLocation(
          LatLng(locData.latitude!, locData.longitude!), setState);
    } catch (e) {
      print('Error: $e');
    }
  }

  void _animateToLocation(LatLng latLng, StateSetter setState) {
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 15),
      ),
    );

    setState(() {
      _markers.clear(); // Clear the markers to avoid multiple markers
      _markers.add(
        Marker(
          markerId: const MarkerId('Current Location'),
          position: latLng,
          infoWindow: const InfoWindow(
            title: 'Current Location',
          ),
        ),
      );
    });

    _getNearestEstablishment(latLng).then((name) {
      setState(() {
        _currentAddress = name;
      });
    });
  }

  void _addNewLocation(LatLng latLng, StateSetter setState) async {
    print('Adding new location: $latLng'); // Debugging log

    _markers.clear(); // Clear the markers to avoid multiple markers
    _markers.add(
      Marker(
        markerId: const MarkerId('New Location'),
        position: latLng,
        infoWindow: const InfoWindow(
          title: 'New Location',
        ),
      ),
    );
    _newLocation = latLng;
    _currentAddress = await _getNearestEstablishment(latLng);

    print('New location set: $_newLocation'); // Debugging log
    print('New address set: $_currentAddress'); // Debugging log

    setState(() {});
  }

  Future<String> _getNearestEstablishment(LatLng latLng) async {
    try {
      places.PlacesSearchResponse response =
          await placesApi.searchNearbyWithRadius(
        places.Location(lat: latLng.latitude, lng: latLng.longitude),
        50, // Radius in meters
      );
      if (response.results.isNotEmpty) {
        return response.results.first.name;
      } else {
        return 'No nearby establishments found';
      }
    } catch (e) {
      print('Error getting nearest establishment: $e');
      return 'Unknown location';
    }
  }

  void _saveNewLocation(String locationType, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_newLocation != null) {
      print('Saving new location: $_newLocation'); // Debugging log

      try {
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('User')
            .doc(widget.userModel.idNumber);

        DocumentSnapshot docSnapshot = await userDoc.get();

        if (!docSnapshot.exists) {
          await userDoc.set({
            'Location': {
              'saved': [],
            }
          });
        }

        await userDoc.update({
          'Location.saved': FieldValue.arrayUnion([
            {
              'longitude': _newLocation!.longitude,
              'latitude': _newLocation!.latitude,
              'name': _currentAddress,
              'type': locationType,
            }
          ]),
          'Location.recent': _currentAddress, // Update recent location
          'Location.name': _currentAddress, // Update name of the location
        });

        _fetchSavedLocations();

        setState(() {
          widget.userModel.location =
              _currentAddress; // Update recent location in UI
        });

        Navigator.pop(context);
      } catch (e) {
        print('Error updating Firestore: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context); // Ensure the sheet closes
      }
    } else {
      print('No new location selected');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showFullAddressDialog(BuildContext context, String address) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Full Address'),
          content: SingleChildScrollView(
            child: Text(address),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
