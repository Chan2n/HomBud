// import 'package:flutter/material.dart';

// import 'BookingPages.dart/RepairMaintenance/AirCooler/Aircooler.dart';
// import 'FlowsBooking/FlowsAircon.dart';
// import 'BookingPages.dart/RepairMaintenance/Microwave/Microwave.dart';
// import 'BookingPages.dart/RepairMaintenance/Refrigerator/Refrigerator.dart';
// import 'BookingPages.dart/RepairMaintenance/Washing/Washing.dart';

// class BookingPage extends StatefulWidget {
//   const BookingPage({Key? key}) : super(key: key);

//   @override
//   State<BookingPage> createState() => _BookingPageState();
// }

// class _BookingPageState extends State<BookingPage> {
//   // Create a GlobalKey for the Scaffold to show the Bottom Sheet
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   int _currentIndex = 2;

//   void _showBottomSheet1(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 150.0, // Set the height as needed
//             color: Colors.white,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 45.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSquareButton(
//                       'lib/assets/images/house_cleaning-removebg-preview.png',
//                       'Full Home',
//                     ),
//                     _buildSquareButton(
//                         'lib/assets/images/SofaCarpetClean-removebg-preview.png',
//                         'Sofa/Carpet'),
//                     _buildSquareButton(
//                         'lib/assets/images/PestControl-removebg-preview.png',
//                         'Disinfect'),
//                     _buildSquareButton(
//                         'lib/assets/images/PestControl-removebg-preview.png',
//                         'Pest Control'),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   void _showBottomSheet2(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 250.0, // Set the height as needed
//             color: Colors.white,
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 45.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSquareButton(
//                       'lib/assets/images/ACRepair-removebg-preview.png',
//                       'Aircon',
//                       () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Aircon()));
//                       },
//                     ),
//                     _buildSquareButton(
//                       'lib/assets/images/RefrigeratorRepair-removebg-preview.png',
//                       'Refrigerator',
//                       () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Refrigerator()));
//                       },
//                     ),
//                     _buildSquareButton(
//                       'lib/assets/images/WashingMachineRepair-removebg-preview.png',
//                       'Washing',
//                       () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) => Washing()));
//                       },
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildSquareButton(
//                       'lib/assets/images/OvenRepair-removebg-preview.png',
//                       'Microwave',
//                       () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Microwave()));
//                       },
//                     ),
//                     _buildSquareButton(
//                       'lib/assets/images/pc_repair-removebg-preview.png',
//                       'Laptop/PC',
//                     ),
//                     _buildSquareButton(
//                       'lib/assets/images/cleaning-removebg-preview.png',
//                       'Air Cooler',
//                       () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Aircooler()));
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//   }

//   void _showBottomSheet3(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 150.0, // Set the height as needed
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                     'lib/assets/images/HomePaint-removebg-preview.png',
//                     'Paint'),
//                 _buildSquareButton(
//                     'lib/assets/images/HomePaint-removebg-preview.png',
//                     'Wallpaper'),
//               ],
//             ),
//           );
//         });
//   }

//   void _showBottomSheet4(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 200.0, // Set the height as needed
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                     'lib/assets/images/wellness-removebg-preview.png',
//                     'Facial'),
//                 _buildSquareButton(
//                     'lib/assets/images/WomenSalon-removebg-preview.png',
//                     'Wax and Glow'),
//                 _buildSquareButton(
//                     'lib/assets/images/NailStudio-removebg-preview.png',
//                     'Manicure'),
//               ],
//             ),
//           );
//         });
//   }

//   void _showBottomSheet5(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 150.0, // Set the height as needed
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                     'lib/assets/images/PestControl-removebg-preview.png',
//                     'SOON'),
//               ],
//             ),
//           );
//         });
//   }

//   void _showBottomSheet6(BuildContext context) {
//     showModalBottomSheet<void>(
//         context: context,
//         backgroundColor:
//             Colors.black.withOpacity(0.5), // Semi-transparent black overlay
//         isScrollControlled: true,
//         builder: (BuildContext context) {
//           return Container(
//             height: 150.0, // Set the height as needed
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildSquareButton(
//                     'lib/assets/images/MenSalon-removebg-preview.png',
//                     'Haircut'),
//                 _buildSquareButton(
//                     'lib/assets/images/NailStudio-removebg-preview.png',
//                     'Manicure '),
//                 _buildSquareButton(
//                     'lib/assets/images/MenSalon-removebg-preview.png',
//                     'Anti Dandruff'),
//                 _buildSquareButton(
//                     'lib/assets/images/MenSalon-removebg-preview.png',
//                     'Kids Haircut'),
//               ],
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(50.0), // Adjust the height as needed
//         child: AppBar(
//           backgroundColor: Color(0xFFD4ECFA),
//           elevation: 0.0,
//           automaticallyImplyLeading: false, // Removes the back button
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Your logo here
//               Image.asset('lib/assets/images/HombuddyLogin.jpg', width: 150.0),
//             ],
//           ),
//           actions: [
//             // Notification icon or widget on the right
//             IconButton(
//               icon: Icon(Icons.notifications),
//               onPressed: () {
//                 // Handle notification button press
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//           child: Container(
//         color: Color(0xFFD4ECFA), // Set the background color
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.location_on, color: Colors.black),
//                   Text("Will be Updated After implementing Location API",
//                       style: TextStyle(color: Colors.black)),
//                 ],
//               ),
//             ),
//             Container(
//               color: Color(0xFFD4ECFA), // Set background color
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   filled: true, // Fill the text field background
//                   fillColor: Colors.white, // Background color of the text field
//                   hintText: "Services and Packages",
//                   prefixIcon: Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     // Customize the border
//                     borderRadius: BorderRadius.circular(
//                         20.0), // Adjust the value for roundness
//                     borderSide: BorderSide.none, // Remove the default border
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               color: Color(0xFFD4ECFA),
//               padding: EdgeInsets.symmetric(vertical: 20.0),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: 80.0,
//                       height: 80.0,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildCircleButtonWithText(
//                         'lib/assets/images/PestControl-removebg-preview.png',
//                         'Clean/Pest \nControl',
//                         _showBottomSheet1, // Pass the function to show the first Bottom Sheet
//                       ),
//                       _buildCircleButtonWithText(
//                         'lib/assets/images/Plumbing1-removebg-preview.png',
//                         'Repair/Maintenance',
//                         _showBottomSheet2, // Pass the function to show the second Bottom Sheet
//                       ),
//                       _buildCircleButtonWithText(
//                         'lib/assets/images/HomePaint-removebg-preview.png',
//                         'Painting & \nWallpapers',
//                         _showBottomSheet3,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               color: Color(0xFFD4ECFA),
//               padding: EdgeInsets.symmetric(vertical: 20.0),
//               child: Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildCircleButtonWithText(
//                           'lib/assets/images/MakeupStudio-removebg-preview.png',
//                           'Women\'s \nWellness',
//                           _showBottomSheet4, // Name for the first icon
//                         ),
//                         _buildCircleButtonWithText(
//                           'lib/assets/images/FullHomeClean-removebg-preview.png',
//                           'Home Care            ',
//                           _showBottomSheet5, // Name for the second icon
//                         ),
//                         _buildCircleButtonWithText(
//                           'lib/assets/images/MenSalon-removebg-preview.png',
//                           'Men\'s Wellness',
//                           _showBottomSheet6, // Name for the third icon
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             //
//             //
//             //

//             Divider(
//               color: Color(0xFF00588D),
//               thickness: 10.0,
//             ),
//           ],
//         ),
//       )),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });

//           switch (_currentIndex) {
//             case 0: // Assuming the Activity icon is the first item
//               if (ModalRoute.of(context)?.settings.name != '/activity') {
//                 Navigator.pushNamed(context, '/activity');
//               }
//               break;
//             case 4:
//               if (ModalRoute.of(context)?.settings.name != '/account') {
//                 Navigator.pushNamed(context, '/account');
//               }
//               break;
//             case 2:
//               if (ModalRoute.of(context)?.settings.name != '/booking') {
//                 Navigator.pushNamed(context, '/booking');
//               }
//               break;
//             default:
//               // Handle other bottom navigation bar items or do nothing
//               break;
//           }
//         },
//         selectedItemColor: Colors.blue, // Adjust the color as needed
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/ActivityIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Activity',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/PaymentIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Payment',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/HBIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'HB',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/MessagesIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               'lib/assets/images/ProfileIcon.jpg',
//               width: 24.0,
//               height: 24.0,
//             ),
//             label: 'Account',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCircleButtonWithText(
//       String imagePath, String text, Function(BuildContext) onPressed) {
//     return GestureDetector(
//       onTap: () {
//         onPressed(context); // Show the corresponding Bottom Sheet when clicked
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 80.0,
//             height: 80.0,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.blue,
//             ),
//             child: ClipOval(
//               child: Image.asset(
//                 imagePath,
//                 width: 80.0,
//                 height: 80.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           SizedBox(height: 8.0), // Space between icon and text
//           Container(
//             height: 40.0, // Set a fixed height for the text container
//             child: Center(
//               child: Text(
//                 text,
//                 style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSquareButton(String imagePath, String title,
//       [VoidCallback? onPressed]) {
//     return GestureDetector(
//       onTap: onPressed, // Use the provided onPressed callback if available
//       child: Container(
//         width: 80.0,
//         height: 80.0,
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius:
//               BorderRadius.circular(10.0), // Adjust the value for roundness
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20.0),
//               child: Image.asset(
//                 imagePath,
//                 height: 50.0,
//                 width: 50.0,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 3.0),
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.bold), // Smaller font size
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAds() {
//     return SizedBox(
//       height: 200.0, // Set a specific height for the PageView
//       child: PageView.builder(
//         itemCount: 3,
//         itemBuilder: (context, index) {
//           List<String> imagePaths = [
//             'lib/assets/images/Advv.jpg',
//             'lib/assets/images/Advert2.jpg',
//             'lib/assets/images/Advert3.jpg',
//           ];
//           return Container(
//             color: Colors.white,
//             child: Center(
//               child: Image.asset(
//                 imagePaths[index],
//                 fit: BoxFit.fill,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
