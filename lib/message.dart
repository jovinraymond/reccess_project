import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> chatMessages = [];

  void sendMessage(String senderId, String receiverId, String message) async {
    final CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection('messages');

    await messagesCollection.add({
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': FieldValue.serverTimestamp(),
      'text': message,
    });
  }

  void setupMessageListener(String senderId, String receiverId) {
    final CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection('messages');

    messagesCollection
        .where('senderId', isEqualTo: senderId)
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        chatMessages = querySnapshot.docs
            .map<Map<String, dynamic>>(
                (doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Container(
        color: Colors.purpleAccent,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      // TODO: Build the chat message UI based on the data
                      return ListTile(title: Text(message['text']));
                    },
                    itemCount: messages.length,
                  );
                },
              ),
            ),
            Divider(height: 1),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration:
                          InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      String message = _messageController.text.trim();
                      if (message.isNotEmpty) {
                        sendMessage(
                            'your_sender_id', 'your_receiver_id', message);
                        _messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
