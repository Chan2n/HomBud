// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat Screen',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const ChatScreen(),
//     );
//   }
// }

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key, required String userID});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Send Message'),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Divider(),
//           const SizedBox(height: 10),
//           const Padding(
//             padding: EdgeInsets.only(right: 170),
//             child: Text(
//               'HomBuddy',
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 60),
//             child: Text(
//               'Typically replies within a few hours',
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           const SizedBox(height: 5),
//           const Divider(),
//           Expanded(
//             child: ListView(
//               children: const [
//                 // ChatMessage(text: 'Sample Message'),
//                 // Add more ChatMessage widgets for chat history
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'Choose an option or type your own message',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'Is anyone available to chat?',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'What Services do you offer?',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.blue),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text(
//               'What are your Payment Methods?',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Write a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: const BorderSide(color: Colors.blue),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () {
//                     // Handle sending message
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ChatMessage extends StatelessWidget {
//   final String text;

//   const ChatMessage({super.key, required this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 bottomLeft: Radius.circular(12),
//                 bottomRight: Radius.circular(12),
//               ),
//             ),
//             child: Text(
//               text,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
