import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsBooking/BookingFlow2.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountSaveLocation.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsBooking/CartModel.dart';
import 'package:provider/provider.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final List<CartItem> prices; // Define a named parameter prices
  final UserModel user;

  const ServiceDetailsScreen({
    super.key,
    required this.prices,
    required this.user,
  });

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  late TextEditingController _addressInfoController;

  @override
  void initState() {
    super.initState();
    _addressInfoController = TextEditingController();
  }

  @override
  void dispose() {
    _addressInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);

    double totalCost = cartModel.getTotalAmount();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Service Details'),
            Image.asset(
              'lib/assets/images/BookingLogo.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the SavedLocations page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SavedLocations(
                              userModel: widget.user,
                            ), // Ensure you have this page created
                          ),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.home),
                          SizedBox(width: 8),
                          Text('Home'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        widget.user.location,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 38),
              child: Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _addressInfoController,
                  decoration: const InputDecoration(
                    hintText: 'Enter additional address info',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text('Item/s'),
                Text('${cartModel.cartItems.length}'),
              ],
            ),
            const SizedBox(height: 16),
            for (var item in cartModel.cartItems) _buildCartItem(item),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Cost'),
                Text('PHP ${totalCost.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String bookingId = await saveBookingDetails(
                    widget.user,
                    widget.prices,
                    _addressInfoController.text,
                  );
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailsScreen2(
                        user: widget.user,
                        bookingId: bookingId,
                        cartItems: cartModel.cartItems,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0067A5),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> saveBookingDetails(
    UserModel user,
    List<CartItem> prices,
    String addressInfo,
  ) async {
    CollectionReference bookings =
        FirebaseFirestore.instance.collection('bookings');

    int bookingID = await getLatestBookingID() + 1;
    double totalCost = prices.fold(0, (sum, item) => sum + item.price);

    DocumentReference bookingDoc = await bookings.add({
      'bookingID': bookingID,
      'expertID': '',
      'userID': user.idNumber,
      'jobName': prices.map((item) => item.serviceTitle).join(", "),
      'status': 'incomplete',
      'rating': 0,
      'dateBooked': DateTime.now(),
      'dateFinished': null,
      'totalCost': totalCost,
      'addressInfo': addressInfo, // Save additional address info
    });

    print("Booking Added with ID: ${bookingDoc.id}");
    return bookingDoc.id; // Return the newly created document ID
  }

  Future<int> getLatestBookingID() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .orderBy('bookingID', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var docData = querySnapshot.docs.first.data();
      if (docData is Map<String, dynamic>) {
        int? bookingID = docData['bookingID'] as int?;
        return bookingID ?? 0;
      }
    }
    return 0;
  }

  Widget _buildCartItem(CartItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.serviceTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Price: ₱${item.price.toStringAsFixed(2)}'),
        const SizedBox(height: 8),
      ],
    );
  }
}
