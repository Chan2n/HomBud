import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hombuddy/pages/ExpertPages/ExpertModel.dart';
import 'package:hombuddy/pages/FlowsUser/UserModel.dart';
import 'package:hombuddy/pages/FlowsUser/ChatScreen.dart';

class ExpertMessagingPage extends StatefulWidget {
  final ExpertModel expert;
  final UserModel user;
  final String expertID;

  const ExpertMessagingPage({
    super.key,
    required this.expert,
    required this.user,
    required this.expertID,
  });

  @override
  _ExpertMessagingPageState createState() => _ExpertMessagingPageState();
}

class _ExpertMessagingPageState extends State<ExpertMessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'), // Update with appropriate title
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .where('expertId', isEqualTo: widget.expertID)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No chats available'));
          }

          final chatDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (context, index) {
              final chatDoc = chatDocs[index];
              final userId = chatDoc['userId'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('User')
                    .doc(userId)
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const ListTile(
                      title: Text('Loading...'),
                    );
                  }

                  final userData =
                      userSnapshot.data!.data() as Map<String, dynamic>?;
                  final userName = userData != null
                      ? userData['fullName'] ?? 'Unknown User'
                      : 'Unknown User';

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(userName),
                      subtitle: const Text('Tap to chat'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              userId: userId,
                              expertId: widget.expertID,
                              isExpert:
                                  true, // Ensure the required parameter is passed
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
