import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsAircon1.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class UserHomePage1 extends StatefulWidget {
  final UserModel user;

  const UserHomePage1({super.key, required this.user});

  @override
  _UserHomePage1State createState() => _UserHomePage1State();
}

class _UserHomePage1State extends State<UserHomePage1> {
  bool showOverlay = false;
  String selectedService = '';

  void toggleOverlay(String service) {
    setState(() {
      showOverlay = !showOverlay;
      if (showOverlay) {
        selectedService = service;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ad Container
                SizedBox(
                  height: 80, // Adjust the height as needed
                  width: double.infinity, // Make it stretch to full width
                  child: Image.asset(
                    'lib/assets/images/HombuddyAppbar.png', // Replace with your ad image path
                    // Adjust the fit as needed
                  ),
                ),
                const SizedBox(height: 20),
                // Location Text
                SizedBox(
                  height: 40, // Adjust the height as needed
                  child: Text(
                    '    📍 ${widget.user.location}', // Location emoji
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for services and packages',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildServiceAndDiscoverGroup(context),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Discover More',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _buildDiscoverMoreTop(context),
                const SizedBox(height: 40),
                _buildDiscoverMoreBottom(context),
                const SizedBox(height: 20),
                _buildVouchers(context),
                const SizedBox(height: 2),
                _buildAlagadSection(context),
              ],
            ),
          ),
          if (showOverlay)
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showOverlay = false;
                    });
                  },
                  child: Container(
                    color:
                        Colors.transparent, // Transparent color to capture taps
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0, // Position at the bottom of the screen
                  child: GestureDetector(
                    onTap:
                        () {}, // Prevent taps from propagating to the parent GestureDetector
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedService,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    showOverlay = false;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSpecificService(
                                      context,
                                      'Airconditioning',
                                      'lib/assets/images/Airconditioning.png'),
                                  _buildSpecificService(
                                      context,
                                      'Gas Range Hood',
                                      'lib/assets/images/GasRangeHood.png'),
                                  _buildSpecificService(context, 'Water Heater',
                                      'lib/assets/images/WaterHeater.png'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildSpecificService(context, 'Plumbing',
                                      'lib/assets/images/Plumbinglogo.png'),
                                  _buildSpecificService(context, 'Electrical',
                                      'lib/assets/images/Electricallogo.png'),
                                  _buildSpecificService(context, 'Carpentry',
                                      'lib/assets/images/Carpentrylogo.png'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    // Adjust the top padding as needed
                    child: Image.asset(
                      'lib/assets/images/Activity.png',
                      // Change 'lib/assets/img_3.png' to your image asset path
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                  ),
                  const Text('Activity'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/Payment.png',
                    // Change 'lib/assets/img_4.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Payment'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 24, 77, 121), // Change the background color here
                      borderRadius: BorderRadius.circular(
                          15), // Optional: Add border radius
                    ),
                    padding: const EdgeInsets.all(8), // Optional: Add padding
                    child: Image.asset(
                      'lib/assets/images/Hombuddynav.png',
                      width: 30, // Adjust the width as needed
                      height: 30, // Adjust the height as needed
                    ),
                  ),
                  const Text('Home'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/Message.png',
                    // Change 'lib/assets/img_6.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Messages'),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  5, // Adjust according to the number of items
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/images/Account.png',
                    // Change 'lib/assets/img_7.png' to your image asset path
                    width: 30, // Adjust the width as needed
                    height: 30, // Adjust the height as needed
                  ),
                  const Text('Account'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecificService(
      BuildContext context, String serviceName, String imagePath) {
    // Render services based on the selected category
    switch (selectedService) {
      case 'Repair & Maintenance':
        if (serviceName == 'Airconditioning' ||
            serviceName == 'Gas Range Hood' ||
            serviceName == 'Plumbing' ||
            serviceName == 'Electrical' ||
            serviceName == 'Carpentry' ||
            serviceName == 'Water Heater') {
          // Render service widget for "Airconditioning"
          return GestureDetector(
            onTap: () {
              if (serviceName == 'Airconditioning') {
                // Navigate to the Aircon page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Aircon(user: widget.user), // Pass the user model here
                  ),
                );
              } else {
                // Toggle overlay for other services
                toggleOverlay(serviceName);
              }
            },
            child: _buildService(context, serviceName, imagePath),
          );
        }
        break;
      default:
        // Return an empty SizedBox for other categories
        return const SizedBox.shrink();
    }

    // Return an empty SizedBox for non-matching services
    return const SizedBox.shrink();
  }

  Widget _buildService(
      BuildContext context, String serviceName, String imagePath) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8), // Adjust padding as needed
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 8), // Adjust padding as needed
          child: Text(
            serviceName,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCircle(
      BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: title ==
              'Repair & Maintenance' // Check if the service is Repair & Maintenance
          ? () {
              // If it is, toggle overlay
              setState(() {
                showOverlay = true;
                selectedService = title;
              });
            }
          : () {
              // If it's not, show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Service Unavailable'),
                ),
              );
            },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
              color: Colors.grey,
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceAndDiscoverGroup(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildServiceGroupTop(context),
          const SizedBox(height: 20),
          _buildServiceGroupBottom(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildServiceGroupTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceCircle(
            context, 'Home Cleaning', 'lib/assets/images/HomeCleaning.png'),
        _buildServiceCircle(context, 'Repair & Maintenance',
            'lib/assets/images/RepairMaintenance.png'),
        _buildServiceCircle(
            context, 'Home Painting', 'lib/assets/images/HomePaint.png'),
      ],
    );
  }

  Widget _buildServiceGroupBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceCircle(
            context, 'Wellness Center', 'lib/assets/images/Wellness.png'),
        _buildServiceCircle(
            context, 'Massage Care', 'lib/assets/images/Massage.png'),
        _buildServiceCircle(
            context, 'Delivery Services', 'lib/assets/images/Delivery.png'),
      ],
    );
  }

  Widget _buildDiscoverMoreTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDiscoverMoreItem(
            context, 'lib/assets/images/FresherAirAd.png', 'Book Fresher Air'),
        _buildDiscoverMoreItem(context,
            'lib/assets/images/RepairMaintenanceAd.png', 'Repair Maintenance'),
      ],
    );
  }

  Widget _buildDiscoverMoreBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDiscoverMoreItem(
            context, 'lib/assets/images/AsLowAsAd.png', 'Rewards to Enjoy!'),
        _buildDiscoverMoreItem(
            context, 'lib/assets/images/PlumbingAd.png', 'Smooth Water Flow'),
      ],
    );
  }

  Widget _buildDiscoverMoreItem(
      BuildContext context, String image, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 1, right: 1), // Add padding around the image
          width: 180,
          height: 150,
          child: Image.asset(
            image,
            height: 200,
            width: 200,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text('Image not found');
            },
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.left, // Align text to the left
        ), // Add space between texts
        const Text(
          'Book Now!', // Add your additional text here
          textAlign: TextAlign.left, // Align text to the left
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildVouchers(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildVoucherItem(context, 'lib/assets/images/15offAd.png'),
          _buildVoucherItem(context, 'lib/assets/images/15offAd2.png'),
          _buildVoucherItem(context, 'lib/assets/images/15offAd.png'),
        ],
      ),
    );
  }

  Widget _buildVoucherItem(BuildContext context, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5),
      width: 270,
      child: Center(
        child: Image.asset(
          imagePath,
          width: 550, // Adjust the width of the image as needed
          height: 450, // Adjust the height of the image as needed
          fit: BoxFit.fill, // Adjust the fit of the image as needed
        ),
      ),
    );
  }
}

Widget _buildAlagadSection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey), // Border color
      borderRadius: BorderRadius.circular(5), // Border radius
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '      Expertong Nag Alagad Sayo',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Want the same expert on your next Rebook?\n'
                'Book your favorite Expert for the same service here!',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildCircleImage(), // Replace with your circle image widget
            _buildCircleImage(), // Replace with your circle image widget
          ],
        ),
        const SizedBox(height: 5),
        const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 35), // Adjust the left padding as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mr. Alan C.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(width: 25), // Add space between the texts
                  Text(
                    'Mr. Danni P.',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            const SizedBox(width: 45),
            _buildSmallBlueCircle(),
            const SizedBox(
                width: 5), // Replace with your small blue circle widget
            _buildSmallBlueCircle(),
            const SizedBox(width: 50),
            _buildSmallBlueCircle(),
            const SizedBox(
                width: 5), // Replace with your small blue circle widget
            _buildSmallBlueCircle(), // Replace with your small blue circle widget
          ],
        ),
      ],
    ),
  );
}

Widget _buildCircleImage() {
  // Replace this with your circle image widget
  return Padding(
    padding:
        const EdgeInsets.only(left: 30), // Adjust the left padding as needed
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue), // Add blue border
      ),
      // Add your image here if applicable
    ),
  );
}

Widget _buildSmallBlueCircle() {
  // Replace this with your small blue circle widget
  return Padding(
    padding: const EdgeInsets.only(), // Adjust the left padding as needed
    child: Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Adjust color as needed
      ),
    ),
  );
}
