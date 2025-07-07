import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsAircon1.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsCarpentry.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsElectrician.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsGasRangeHood.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsPlumbing.dart';
import 'package:hombuddy/pages/FlowsBooking/FlowsWaterHeater.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccount.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountSaveLocation.dart';
import 'package:hombuddy/pages/FlowsUser/UserActivity.dart';
import 'package:hombuddy/pages/FlowsUser/UserMessage.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserPayment.dart';

class UserHomePage extends StatefulWidget {
  final UserModel user;

  const UserHomePage({super.key, required this.user});

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  bool showOverlay = false;
  String selectedService = '';
  int _selectedIndex = 2;

  void toggleOverlay(String service) {
    setState(() {
      showOverlay = !showOverlay;
      if (showOverlay) {
        selectedService = service;
      }
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
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
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSpecificService(context, 'Airconditioning',
                                'lib/assets/images/Airconditioning.png'),
                            _buildSpecificService(context, 'Gas Range Hood',
                                'lib/assets/images/GasRangeHood.png'),
                            _buildSpecificService(context, 'Water Heater',
                                'lib/assets/images/WaterHeater.png'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            );
          },
        );
      },
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return; // Do nothing if the tapped index is already selected
    }

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserActivity(user: widget.user),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserPayment(user: widget.user),
          ),
        );
        break;
      case 2:
        // Stay on the same page
        break;
      case 3:
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Work in Progress'),
              content:
                  const Text('This feature is currently under development.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserAccount(user: widget.user),
          ),
        );
        break;
    }
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
                const SizedBox(
                  height: 20,
                ),
                // Ad Container
                Center(
                  child: SizedBox(
                    height: 70, // Adjust the height as needed
                    width: 250, // Make it stretch to full width
                    child: Image.asset(
                      'lib/assets/images/HombuddyAppbar.png', // Replace with your ad image path
                      fit: BoxFit.fill, // Adjust the fit as needed
                    ),
                  ),
                ),

                // Location Text
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SavedLocations(userModel: widget.user),
                      ),
                    );
                  },
                  child: Row(
                    // Center align
                    children: [
                      const SizedBox(width: 20),
                      const Icon(
                        Icons.location_on,
                        color: Colors.blueGrey,
                        size: 20.0, // Adjust the size as needed
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.user.location,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 70, // Adjust the height as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Activity.png',
              'Activity',
              0,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserActivity(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Wallet.png',
              'Payment',
              1,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPayment(user: widget.user),
                ),
              ),
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Hombuddynav.png',
              '',
              2,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserHomePage(user: widget.user),
                ),
              ),
              isMain: true,
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Message.png',
              'Message',
              3,
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserMessagingPage(
                        expertID: "EXPERT_ID_HERE",
                        user: widget
                            .user), // Replace "EXPERT_ID_HERE" with the actual expert ID
                  ),
                );
              },
            ),
            _buildBottomNavigationItem(
              context,
              'lib/assets/images/Account.png',
              'Account',
              4,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAccount(user: widget.user),
                ),
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
        if (serviceName == 'Gas Range Hood') {
          // Navigate to the Gas Range Hood page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GasRangeHood(user: widget.user),
                ),
              );
            },
            child: _buildService(context, serviceName, imagePath),
          );
        } else if (serviceName == 'Plumbing') {
          // Navigate to the Plumbing page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Plumbing(user: widget.user),
                ),
              );
            },
            child: _buildService(context, serviceName, imagePath),
          );
        } else if (serviceName == 'Electrical') {
          // Navigate to the Electrical page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Electrician(user: widget.user),
                ),
              );
            },
            child: _buildService(context, serviceName, imagePath),
          );
        } else if (serviceName == 'Airconditioning') {
          // Navigate to the Electrical page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Aircon(user: widget.user),
                ),
              );
            },
            child: _buildService(context, serviceName, imagePath),
          );
        } else if (serviceName == 'Carpentry') {
          // Navigate to the Electrical page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Carpentry(user: widget.user),
                ),
              );
            },
            child: _buildService(context, serviceName, imagePath),
          );
        } else if (serviceName == 'Water Heater') {
          // Navigate to the Electrical page
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WaterHeater(user: widget.user),
                ),
              );
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
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
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
      ),
    );
  }

  Widget _buildServiceCircle(
      BuildContext context, String title, String imagePath) {
    // Determine if the service is available
    bool isAvailable = title != 'Home Cleaning' &&
        title != 'Wellness Center   ' &&
        title != ' Massage Care     ' &&
        title != 'Delivery Services' &&
        title != 'Home Painting';

    return GestureDetector(
      onTap: isAvailable
          ? () {
              if (title == 'Repair & Maintenance') {
                setState(() {
                  _showBottomSheet(context);
                  selectedService = title;
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Service Unavailable'),
                  ),
                );
              }
            }
          : null,
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.5, // Set opacity based on availability
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
                color: const Color(0xFFD4ECFA),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
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
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 5.0, // Blur radius
            spreadRadius: 1.0, // Spread radius
            offset: Offset(2.0, 2.0), // Offset in x and y direction
          ),
        ],
        color: Colors.white, // Ensure the background is white
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
            context, 'Wellness Center   ', 'lib/assets/images/Wellness.png'),
        _buildServiceCircle(
            context, ' Massage Care     ', 'lib/assets/images/Massage.png'),
        _buildServiceCircle(
            context, 'Delivery Services', 'lib/assets/images/Delivery.png'),
      ],
    );
  }

  Widget _buildDiscoverMoreTop(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Aircon(user: widget.user),
              ),
            );
          },
          child: _buildDiscoverMoreItem(context,
              'lib/assets/images/FresherAirAd.png', 'Book Fresher Air'),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _showBottomSheet(context);
              selectedService = 'Repair & Maintenance';
            });
          },
          child: _buildDiscoverMoreItem(
              context,
              'lib/assets/images/RepairMaintenanceAd.png',
              'Repair Maintenance'),
        ),
      ],
    );
  }

  Widget _buildDiscoverMoreBottom(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Rewards will be coming soon'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFF003B5F),
                      ),
                      child: const Text(
                        'Okay',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: _buildDiscoverMoreItem(
              context, 'lib/assets/images/AsLowAsAd.png', 'Rewards to Enjoy!'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Plumbing(user: widget.user),
              ),
            );
          },
          child: _buildDiscoverMoreItem(
              context, 'lib/assets/images/PlumbingAd.png', 'Smooth Water Flow'),
        ),
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
              left: 5, right: 1), // Add padding around the image
          width: 150,
          height: 110,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
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
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 1.0,
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
          child: Image.asset(
            imagePath,
            width: 550, // Adjust the width of the image as needed
            height: 450, // Adjust the height of the image as needed
            fit: BoxFit.fill, // Adjust the fit of the image as needed
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return const Text('Image not found');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAlagadSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15), // Set Margin Here
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
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Make the text bold
                  color: Color(0xFF003B5F), // Set the color to #003B5F
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Want the same expert on your next Rebook?\n'
                  'Book your favorite Expert for the same service here!',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              // Set Margin Here
              height: 160, // Adjust the height as needed
              width: 300, // Adjust the width as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Adjust border radius as needed
                child: Image.asset(
                  'lib/assets/images/Ekspertong.png', // Path to your image asset
                  fit: BoxFit.cover, // Adjust the fit as needed
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationItem(BuildContext context, String iconPath,
      String label, int index, VoidCallback onTap,
      {bool isMain = false}) {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
          onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 70, // Fix width for the container
        child: ClipPath(
          clipper: PointyTopClipper(),
          child: Container(
            color: _selectedIndex == index
                ? const Color(0xFF0067A5)
                : Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(),
                  child: Container(
                    decoration: isMain
                        ? BoxDecoration(
                            color: const Color(0xFF0067A5),
                            borderRadius: BorderRadius.circular(15),
                          )
                        : null,
                    padding: isMain ? const EdgeInsets.all(8) : EdgeInsets.zero,
                    child: Image.asset(
                      iconPath,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                if (label.isNotEmpty)
                  Text(
                    label,
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.white : null,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
