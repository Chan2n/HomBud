import 'package:flutter/material.dart';
import 'package:hombuddy/pages/FlowsBooking/ServiceDetail.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:provider/provider.dart';
import 'CartModel.dart';
import 'BookingFlow1.dart';

class WaterHeater extends StatefulWidget {
  final UserModel user;

  const WaterHeater({super.key, required this.user});

  @override
  _WaterHeaterState createState() => _WaterHeaterState();
}

class _WaterHeaterState extends State<WaterHeater> {
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
                                'lib/assets/images/WaterHeaterbg.png', // Replace with your image path
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
                    child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10), // Add initial padding if needed
                        ],
                      ),
                    ),
                  ),
                  // Your service rows
                  _buildTitle('Water Heater Service'),
                  _buildServiceRow(
                    context,
                    'Filter Cleaning',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱605',
                    '• 1 hr',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PhotoNotAvailable.png',
                    605.0,
                    'Professional Installation',
                    'Experienced Experts',
                    0,
                  ),
                  const SizedBox(height: 20),
                  _buildServiceRow(
                    context,
                    'Pullout',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱2035',
                    '• 1 hr',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PhotoNotAvailable.png',
                    2035.0,
                    'Professional Installation',
                    'Experienced Experts',
                    1,
                  ),
                  const SizedBox(height: 30),
                  _buildServiceRow(
                    context,
                    'Installation',
                    '⭐ 5.00 (bookings)',
                    'PHP ₱2035',
                    '• 1 hr',
                    '- Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'lib/assets/images/PhotoNotAvailable.png',
                    2035.0,
                    'Professional Installation',
                    'Experienced Experts',
                    2,
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

  Widget _buildTitle(
    String title,
  ) {
    return Container(
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
