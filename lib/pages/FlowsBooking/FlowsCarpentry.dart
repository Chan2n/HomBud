import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsBooking/ServiceDetail.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:provider/provider.dart';
import 'CartModel.dart';
import 'BookingFlow1.dart';

class Carpentry extends StatefulWidget {
  final UserModel user;

  const Carpentry({super.key, required this.user});

  @override
  _CarpentryState createState() => _CarpentryState();
}

class _CarpentryState extends State<Carpentry> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  // GlobalKeys for each section
  final GlobalKey _balcony = GlobalKey();
  final GlobalKey _cupboard = GlobalKey();
  final GlobalKey _door = GlobalKey();
  final GlobalKey _drill = GlobalKey();
  final GlobalKey _window = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Repair & Maintenance',
          style: TextStyle(
              color: Color(0xFF0067A5),
              fontSize: 20 // Adjust the font size as needed
              ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset(
              'lib/assets/images/BookingLogo.png', // Replace 'assets/logo.png' with the path to your logo image asset
              width: 50, // Adjust width as needed
              height: 50, // Adjust height as needed
            ),
            onPressed: () {
              // Add any functionality you need when the logo is pressed
            },
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 1 / 3,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              top:
                                  null, // Remove top positioning to use the alignment
                              child: Image.asset(
                                'lib/assets/images/Carpentrybg.png', // Replace with your image path
                                fit: BoxFit.fill,
                                alignment: Alignment
                                    .topCenter, // Align the image to the top center
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    color: Colors.transparent, // Make the container transparent
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                              width: 10), // Add initial padding if needed
                          _buildSquareButtons(),
                        ],
                      ),
                    ),
                  ),
                  // Your service rows
                  _buildTitle('Balcony', _balcony),
                  _buildServiceRow(
                    context,
                    'AC Check up',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    0,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Divider here
                  const SizedBox(
                    height: 20, // Adjust the height of the divider as needed
                    child: Divider(
                      color: Color(0xFF0067A5),
                      thickness:
                          1, // Adjust the thickness of the divider as needed
                    ),
                  ),

                  _buildTitle('Cupboard & Drawer', _cupboard),
                  _buildServiceRow(
                    context,
                    'Installation/replacement of cupboard hinge',
                    '⭐ 4.32 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    1,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Drawer channel Replacement (up to 2 set)',
                    '⭐ 4.43 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    2,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Cupboard handle installation/replacement',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    3,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Cupboard lock installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    4,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Cupboard lock replacement',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    5,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 20, // Adjust the height of the divider as needed
                    child: Divider(
                      color: Color(0xFF0067A5),
                      thickness:
                          1, // Adjust the thickness of the divider as needed
                    ),
                  ),
                  _buildTitle('Door', _door),
                  _buildServiceRow(
                    context,
                    'Door accessory installation (latch, chain, stopper, magnet)',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    6,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Wooden door replacement',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱1650',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    1650.0,
                    'Professional Installation',
                    'Experienced Experts',
                    7,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Door hinge replacement',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    8,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Door lock replacement',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    9,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Overhead door closer installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱1320',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    1320.0,
                    'Professional Installation',
                    'Experienced Experts',
                    10,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Wall mounted door closer installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱1320',
                    '• 1 hr - 2 hrs',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PowerJetACServiceSplit.jpg',
                    1320.0,
                    'Professional Installation',
                    'Experienced Experts',
                    11,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 20, // Adjust the height of the divider as needed
                    child: Divider(
                      color: Color(0xFF0067A5),
                      thickness:
                          1, // Adjust the thickness of the divider as needed
                    ),
                  ),
                  _buildTitle('Drill & Hang', _drill),
                  _buildServiceRow(
                    context,
                    'Bathroom holder & hanger installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    12,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Drill & hang (wall decor)',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    13,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Bathroom mirror installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    14,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Glass shelf installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    15,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Wooden shelf Installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    16,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Corner guard/ safety lock installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconInstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    17,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  const SizedBox(
                    height: 20, // Adjust the height of the divider as needed
                    child: Divider(
                      color: Color(0xFF0067A5),
                      thickness:
                          1, // Adjust the thickness of the divider as needed
                    ),
                  ),
                  _buildTitle('Window & Curtain', _window),
                  _buildServiceRow(
                    context,
                    'Curtain blinds measurement (up to 10)',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconUninstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    18,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Curtain rods installation (2 brackets)',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconUninstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    19,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Shower curtain rod installation (2 brackets)',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconUninstall.jpg',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildServiceRow(
                    context,
                    'Non motorised blinds fitting up to 5ft ',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱1100',
                    '• 1 hr - 2 hrs',
                    '- Intense cleaning of indoor unit \nand outdoor unit\n- Does not include foam',
                    'lib/assets/images/AirconUninstall.jpg',
                    1100.0,
                    'Professional Installation',
                    'Experienced Experts',
                    21,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Add other service rows as needed
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildStickyCartSheet(context),
        ],
      ),
    );
  }

  Widget _buildTitle(String title, GlobalKey key) {
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0067A5),
          ),
        ),
      ),
    );
  }

  Widget _buildStickyCartSheet(BuildContext context) {
    final cartModel = Provider.of<CartModel>(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20), // Adjust padding as needed
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius:
            BorderRadius.circular(10), // Adjust border radius as needed
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align items at the ends
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Items: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003B5F), // Text color for "Items"
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${cartModel.cartItems.length}', // Show the total number of items
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            Color(0xFF2F9BDC), // Text color for number of items
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Align items at the ends
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Total Cost: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF003B5F), // Text color for "Total Cost"
                      ),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '₱${cartModel.getTotalAmount().toStringAsFixed(2)}', // Show the total cost
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(
                            0xFF2F9BDC), // Text color for total cost amount
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsScreen(
                      user: widget.user,
                      prices: cartModel.cartItems,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF003B5F), // Button background color
                elevation: 5, // Add elevation for shadow effect
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSquareButton(
            'lib/assets/images/BookingLogo.png', 'Balcony ', _balcony),
        _buildSquareButton(
            'lib/assets/images/BookingLogo.png', 'Cupboard ', _cupboard),
        _buildSquareButton('lib/assets/images/BookingLogo.png', 'Door ', _door),
        _buildSquareButton(
            'lib/assets/images/BookingLogo.png', 'Drill ', _drill),
        _buildSquareButton(
            'lib/assets/images/BookingLogo.png', 'Window ', _window),
      ],
    );
  }

  Widget _buildSquareButton(String imagePath, String titleText, GlobalKey key) {
    return GestureDetector(
      onTap: () {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        width: 70.0, // Adjust the width as needed
        height: 100.0, // Adjust the height as needed
        margin: const EdgeInsets.symmetric(
            horizontal: 4.0), // Add margin between buttons
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50.0, // Adjust the width as needed
              height: 71.0, // Adjust the height as needed
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(
                    8.0), // Adjust the border radius as needed
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8.0), // Match the container's border radius
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
                height: 8), // Add spacing between the image and the title
            Text(
              titleText,
              style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceRow(
    BuildContext context,
    String serviceTitle,
    String ratings,
    String price,
    String hour,
    String serviceDescription,
    String imagePath,
    double priceValue,
    String desc1,
    String desc2,
    int index,
  ) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    int itemCount = _getItemCount(serviceTitle, cartModel.cartItems);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceTitle,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(ratings,
                      style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey)),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        hour,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF003B5F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  Row(
                    children: [
                      const Icon(Icons.house, size: 12), // House icon
                      Text(desc1,
                          style:
                              const TextStyle(fontSize: 12)), // Text for desc1
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 12), // Person icon
                      Text(desc2,
                          style:
                              const TextStyle(fontSize: 12)), // Text for desc2
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceDetailsPage(
                            serviceTitle: serviceTitle,
                            desc1: desc1,
                            desc2: desc2,
                            serviceDescription: serviceDescription,
                            price: price,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                itemCount > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              // Find the correct item to remove
                              final itemIndex = cartModel.cartItems.indexWhere(
                                (item) => item.serviceTitle == serviceTitle,
                              );

                              if (itemIndex >= 0 &&
                                  itemIndex < cartModel.cartItems.length) {
                                cartModel.removeFromCart(
                                    itemIndex); // Corrected removal logic
                              }

                              if (_getItemCount(
                                      serviceTitle, cartModel.cartItems) ==
                                  0) {
                                setState(() {});
                              }
                            },
                          ),
                          Text(
                            '$itemCount',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartModel.addToCart(priceValue, serviceTitle);
                            },
                          ),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () {
                          cartModel.addToCart(priceValue, serviceTitle);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF003B5F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Adjust the radius as needed
                          ),
                        ),
                        child: const Text(
                          '    ADD    ',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getItemCount(String serviceTitle, List<CartItem> cartItems) {
    return cartItems.where((item) => item.serviceTitle == serviceTitle).length;
  }
}
