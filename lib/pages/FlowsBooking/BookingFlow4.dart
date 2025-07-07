import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/FlowsUser/UserAccountSaveLocation.dart';
import 'package:intl/intl.dart';
import 'package:hombuddy/pages/FlowsBooking/BookingOnTheDay.dart';
import 'package:hombuddy/pages/FlowsBooking/BookingSuccess.dart';
import 'package:hombuddy/pages/FlowsBooking/CartModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

class ServiceDetailsScreen4 extends StatefulWidget {
  final UserModel user;
  final String bookingId;
  final List<CartItem> cartItems;
  final String? imageUrl;

  const ServiceDetailsScreen4({
    super.key,
    required this.user,
    required this.bookingId,
    required this.cartItems,
    this.imageUrl,
  });

  @override
  _ServiceDetailsScreen4State createState() => _ServiceDetailsScreen4State();
}

class _ServiceDetailsScreen4State extends State<ServiceDetailsScreen4> {
  late String _paymentMethod = 'Cash';
  String? _dateBooked;
  String? _timeSlot;
  double totalCost = 0.0;
  bool hasSurcharge = false;
  bool hasConvenienceFee = false;

  @override
  void initState() {
    super.initState();
    _fetchBookingDetails();
  }

  Future<void> _fetchBookingDetails() async {
    try {
      DocumentSnapshot bookingSnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .doc(widget.bookingId)
          .get();
      if (bookingSnapshot.exists) {
        Timestamp dateTimestamp =
            bookingSnapshot['dateBooked'] ?? Timestamp.now();
        DateTime dateTime = dateTimestamp.toDate();

        String day = dateTime.day.toString().padLeft(2, '0');
        String month = dateTime.month.toString().padLeft(2, '0');
        String year = dateTime.year.toString();
        setState(() {
          _dateBooked = '$day/$month/$year';
        });

        String timeSlot =
            bookingSnapshot['timeSlot'] ?? 'No time slot selected';
        setState(() {
          _timeSlot = timeSlot;
        });

        bool surcharge = _hasSurcharge(_timeSlot ?? "");
        totalCost = calculateTotalCost(widget.cartItems, surcharge);
        setState(() {
          hasSurcharge = surcharge;
        });

        bool convenienceFee =
            _hasConvenienceFee(bookingSnapshot['materials'] ?? []);
        setState(() {
          hasConvenienceFee = convenienceFee;
          if (hasConvenienceFee) {
            totalCost += 200;
          }
        });

        await updateTotalCost(widget.bookingId, totalCost);
      } else {
        print('Booking does not exist');
      }
    } catch (error) {
      print('Error fetching booking details: $error');
    }
  }

  double calculateTotalCost(List<CartItem> cartItems, bool hasSurcharge) {
    double total = 0;
    for (var item in cartItems) {
      total += item.price;
    }

    if (hasSurcharge) {
      total *= 1.1;
    }

    return total;
  }

  bool _hasSurcharge(String time) {
    if (time.isEmpty) {
      return false;
    }

    time = time.trim();

    List<String> parts = time.split(' ');
    if (parts.length != 2) {
      return false;
    }

    String hourPart = parts[0];
    String meridian = parts[1];

    if (hourPart.contains(':')) {
      List<String> timeParts = hourPart.split(':');
      int hour = int.tryParse(timeParts[0]) ?? 0;

      if (meridian.toUpperCase() == 'PM') {
        hour += 12;
      }

      return hour >= 17 && hour <= 21;
    }

    return false;
  }

  bool _hasConvenienceFee(String? materials) {
    if (materials != null && materials.contains("Pay")) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Service Details',
          style: TextStyle(color: Color(0xFF0067A5)),
        ),
        centerTitle: true,
        actions: [
          Image.asset(
            'lib/assets/images/BookingLogo.png',
            width: 50,
            height: 50,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Details',
              style: TextStyle(
                color: Color(0xFF0067A5),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 5),
            if (widget.imageUrl != null)
              Image.network(
                widget.imageUrl!,
                width: 150,
                height: 150,
              ),
            if (widget.imageUrl == null)
              const Text(
                'No Additional Photo Added by you',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text(
                  'Location',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                const SizedBox(width: 15),
                Text(
                  widget.user.location,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 80),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedLocations(
                          userModel: widget.user,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    '| Edit',
                    style: TextStyle(color: Colors.blue, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Text(
                  'Date & Time',
                  style: TextStyle(color: Colors.black, fontSize: 13),
                ),
                const SizedBox(width: 15),
                Text(
                  _dateBooked ?? 'Loading date...',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 80),
                Text(
                  _timeSlot ?? 'Loading time...',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            if (hasSurcharge)
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text('Surcharge: '),
                    SizedBox(width: 5),
                    Text(
                      '10%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            if (hasConvenienceFee)
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text('Convenience Fee: '),
                    SizedBox(width: 5),
                    Text(
                      '₱200',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Booking Summary',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.cartItems.length,
                  itemBuilder: (context, index) {
                    final CartItem cartItem = widget.cartItems[index];
                    return ListTile(
                      title: Text(cartItem.serviceTitle),
                      subtitle: Text('Price: ₱${cartItem.price}'),
                    );
                  },
                ),
                const SizedBox(height: 100),
                const Divider(),
                const SizedBox(height: 5),
                const Text(
                  'PAYMENT METHOD',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 46.0),
                  child: Row(
                    children: [
                      Text(
                        _paymentMethod,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 13),
                      ),
                      const SizedBox(width: 175),
                      GestureDetector(
                        onTap: () {
                          _showPaymentOptions(context);
                        },
                        child: const Text(
                          '| Change',
                          style: TextStyle(color: Colors.blue, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.only(left: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'HB Voucher',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Select',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(''),
                      ),
                      Expanded(
                        child: Text(''),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: Text(
                          'TOTAL COST',
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '₱${totalCost.toStringAsFixed(1)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_dateBooked != null) {
                        _showBookingReviewOverlay(
                          context,
                          totalCost,
                          _dateBooked!,
                          widget.bookingId,
                          widget.user,
                        );
                      } else {
                        // Handle the case where _dateBooked is null
                      }
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
          ],
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: const Text('Cash'),
              onTap: () {
                setState(() {
                  _paymentMethod = 'Cash';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Credit Card'),
              onTap: () {
                setState(() {
                  _paymentMethod = 'Credit Card';
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateTotalCost(String bookingId, double newTotalCost) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({'totalCost': newTotalCost});
      print('Total cost updated successfully');
    } catch (error) {
      print('Error updating total cost: $error');
    }
  }

  Future<void> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(bookingId)
          .update({'status': newStatus});
      print('Booking status updated successfully');
    } catch (error) {
      print('Error updating booking status: $error');
    }
  }

  void _showBookingReviewOverlay(BuildContext context, double totalCost,
      String dateBooked, String bookingId, UserModel loggedInUser) {
    String selectedPayment = 'Cash';
    DateTime now = DateTime.now();
    DateTime bookingDate = DateFormat('dd/MM/yyyy').parse(dateBooked);
    bool isTodayBooking = now.year == bookingDate.year &&
        now.month == bookingDate.month &&
        now.day == bookingDate.day;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/images/BookReview.png',
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please review all details before finalizing your booking as there will be No Cancellation',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await updateBookingStatus(bookingId, 'active');
                if (isTodayBooking) {
                  if (bookingId.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodayBooking(
                          bookingId: bookingId,
                          loggedInUser: loggedInUser,
                        ),
                      ),
                    );
                  } else {
                    print('Error: bookingId is empty or invalid.');
                  }
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingSuccessPage(updatedTotalCost: totalCost),
                    ),
                  );
                }
              },
              child: const Text(
                'Continue',
                style: TextStyle(color: Color(0xFF0067A5)),
              ),
            ),
            TextButton(
              onPressed: () {
                // Review details button functionality
              },
              child: const Text(
                'Review Details',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        );
      },
    );
  }
}
