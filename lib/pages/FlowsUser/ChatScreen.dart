import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String expertId;
  final bool isExpert; // Flag to determine if the current user is an expert

  const ChatScreen({
    super.key,
    required this.userId,
    required this.expertId,
    required this.isExpert, // Pass this flag when navigating to ChatScreen
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late String chatId;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .where('userId', isEqualTo: widget.userId)
        .where('expertId', isEqualTo: widget.expertId)
        .limit(1)
        .get();

    if (chatDoc.docs.isNotEmpty) {
      chatId = chatDoc.docs.first.id;
    } else {
      final newChatDoc =
          await FirebaseFirestore.instance.collection('chats').add({
        'userId': widget.userId,
        'expertId': widget.expertId,
        'createdAt': FieldValue.serverTimestamp()
      });
      chatId = newChatDoc.id;
    }
    setState(() {});
  }

  Future<void> _sendMessage(String message, {String? imageUrl}) async {
    if (message.isNotEmpty || imageUrl != null) {
      final messageData = {
        'senderId': widget.isExpert
            ? widget.expertId
            : widget.userId, // Determine sender based on the flag
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (imageUrl != null) {
        messageData['imageUrl'] = imageUrl;
      }

      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(messageData);

      _messageController.clear();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // Upload image to Firebase Storage and get the URL
      String imageUrl = await _uploadImage(imageFile);
      _sendMessage('', imageUrl: imageUrl);
    }
  }

  Future<String> _uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child("chat_images/$fileName");
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => null);
    String downloadUrl = await storageReference.getDownloadURL();
    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    if (chatId.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          backgroundColor: Colors.white,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('Expert')
              .doc(widget.expertId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.hasError) {
              return const Text('Error');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Expert');
            }

            final expertData = snapshot.data!.data() as Map<String, dynamic>;
            final expertName = expertData['FullName'] ?? 'Expert';

            return Text(
              expertName,
              style: const TextStyle(
                color: Color(0xFF041F30),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message =
                        messages[index].data() as Map<String, dynamic>;
                    final senderId = message['senderId'];
                    final isUser = senderId == widget.userId;
                    final imageUrl = message.containsKey('imageUrl')
                        ? message['imageUrl']
                        : null;

                    return ListTile(
                      title: Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (imageUrl != null)
                              Image.network(
                                imageUrl,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            if (message['message'] != '')
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                  color:
                                      isUser ? Colors.blue : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  message['message'],
                                  style: TextStyle(
                                      color:
                                          isUser ? Colors.white : Colors.black),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration:
                        const InputDecoration(hintText: 'Enter message...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
