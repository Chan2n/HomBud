// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:hombuddy/pages/FlowsBooking/BookingSuccess.dart';
// import 'package:hombuddy/pages/FlowsBooking/CartModel.dart';
// import 'package:hombuddy/pages/FlowsUser/UserFlow3.dart';
// import 'package:hombuddy/pages/FlowsUser/UserModel.dart';

// class BookingFinal extends StatefulWidget {
//   final UserModel user;
//   final String bookingId;
//   final List<CartItem> cartItems;
//   final String? imageUrl; // Add imageUrl parameter

//   const BookingFinal({
//     Key? key,
//     required this.user,
//     required this.bookingId,
//     required this.cartItems,
//     this.imageUrl, // Make imageUrl nullable
//   }) : super(key: key);

//   @override
//   _BookingFinalState createState() => _BookingFinalState();
// }

// class _BookingFinalState extends State<BookingFinal> {
//   String? _dateBooked;
//   String? _timeSlot;
//   late double totalCost;

//   @override
//   void initState() {
//     super.initState();
//     _fetchBookingDetails();
//     totalCost = calculateTotalCost(widget.cartItems);
//   }

//   double calculateTotalCost(List<CartItem> cartItems) {
//     double total = 0;
//     for (var item in cartItems) {
//       total += item.price;
//     }
//     return total;
//   }

//   Future<void> _fetchBookingDetails() async {
//     try {
//       DocumentSnapshot bookingSnapshot = await FirebaseFirestore.instance
//           .collection('bookings')
//           .doc(widget.bookingId)
//           .get();
//       if (bookingSnapshot.exists) {
//         Timestamp dateTimestamp =
//             bookingSnapshot['dateBooked'] ?? Timestamp.now();
//         DateTime dateTime = dateTimestamp.toDate();
//         setState(() {
//           _dateBooked = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
//         });

//         String timeSlot =
//             bookingSnapshot['timeSlot'] ?? 'No time slot selected';
//         setState(() {
//           _timeSlot = timeSlot;
//         });
//       } else {
//         print('Booking does not exist');
//       }
//     } catch (error) {
//       print('Error fetching booking details: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Service Details',
//           style: TextStyle(color: Color(0xFF0067A5)),
//         ),
//         centerTitle: true,
//         actions: [
//           Image.asset(
//             'lib/assets/images/BookingLogo.png',
//             width: 50,
//             height: 50,
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Booking Details',
//               style: TextStyle(
//                 color: Color(0xFF0067A5),
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             SizedBox(height: 5),
//             // Display the image if available
//             if (widget.imageUrl != null)
//               Image.network(
//                 widget.imageUrl!,
//                 width: 150,
//                 height: 150,
//               ),
//             if (widget.imageUrl == null) // Display message if imageUrl is null
//               Text(
//                 'No Additional Photo Added by you',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Text(
//                   'Location',
//                   style: TextStyle(color: Colors.black, fontSize: 13),
//                 ),
//                 SizedBox(width: 15),
//                 Text(
//                   widget.user.location,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//                 SizedBox(width: 80),
//                 Text(
//                   '|Edit',
//                   style: TextStyle(color: Colors.grey, fontSize: 13),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5),
//             Row(
//               children: [
//                 Text(
//                   'Date & Time',
//                   style: TextStyle(color: Colors.black, fontSize: 13),
//                 ),
//                 SizedBox(width: 15),
//                 Text(
//                   _dateBooked ?? 'Loading date...',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//                 SizedBox(width: 80),
//                 Text(
//                   _timeSlot ?? 'Loading time...',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 5),
//             Divider(),
//             SizedBox(height: 5),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Booking Summary',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 // Display the title and price of each booked item
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: widget.cartItems.length,
//                   itemBuilder: (context, index) {
//                     final CartItem cartItem = widget.cartItems[index];
//                     return ListTile(
//                       title: Text(cartItem.serviceTitle),
//                       subtitle: Text('Price: PHP ₱${cartItem.price}'),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 100),
//                 Divider(),
//                 SizedBox(height: 5),
//                 Text(
//                   'PAYMENT METHOD',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.grey),
//                 ),
//                 SizedBox(height: 8),
//                 Padding(
//                   padding: EdgeInsets.only(left: 46.0),
//                   child: Row(
//                     children: [
//                       Text('Cash',
//                           style: TextStyle(color: Colors.black, fontSize: 13)),
//                       SizedBox(width: 175),
//                       Text('| Change',
//                           style: TextStyle(color: Colors.blue, fontSize: 13)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Divider(),
//                 Padding(
//                   padding: EdgeInsets.only(left: 35.0),
//                   child: Row(
//                     children: [
//                       Text('HB Voucher'),
//                       SizedBox(width: 177),
//                       Text('Select'),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 25.0),
//                   child: Row(
//                     children: [
//                       Text(''),
//                       SizedBox(width: 220),
//                       Text(''),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 25.0),
//                   child: Row(
//                     children: [
//                       Text('TOTAL COST'),
//                       SizedBox(width: 153),
//                       Text('PHP ₱$totalCost'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       _showBookingReviewOverlay(context);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF0067A5),
//                     ),
//                     child: Text(
//                       'Continue',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void _showBookingReviewOverlay(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: SingleChildScrollView(
//           // Use SingleChildScrollView to handle overflow
//           child: Column(
//             mainAxisSize:
//                 MainAxisSize.min, // Make column height only as tall as needed
//             children: [
//               Image.asset(
//                 'lib/assets/images/BookReview.png',
//                 width: 180, // Reduce the width for a smaller image
//                 height: 180, // Reduce the height as well
//               ),
//               SizedBox(height: 8), // Reduce space between image and text
//               Text(
//                 'Please review all details before finalizing your booking as there will be No Cancellation',
//                 textAlign: TextAlign
//                     .center, // Center align text for better readability
//                 style: TextStyle(
//                     fontSize: 14), // Optional: adjust font size for space
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               int count = 0;
//               Navigator.popUntil(context, (route) {
//                 return count++ == 6;
//               });
//             },
//             child: Text(
//               'Continue',
//               style: TextStyle(color: Color(0xFF0067A5)),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               // Review details button functionality
//             },
//             child: Text(
//               'Review Details',
//               style: TextStyle(color: Colors.grey),
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
