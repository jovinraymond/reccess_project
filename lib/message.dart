import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Replace 'your_sender_id' with the current user's ID
  String currentUserId = 'your_sender_id';

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

  void setupMessageListener(String receiverId) {
    final CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection('messages');

    messagesCollection
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp',
            descending: true) // Sort by timestamp in descending order
        .snapshots()
        .listen((querySnapshot) {
      setState(() {
        // Instead of using chatMessages, use querySnapshot directly
        // Use querySnapshot.docs directly without assigning it to chatMessages
        final messages = querySnapshot.docs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', textAlign: TextAlign.center),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
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

                  // Start listening to messages specific to the current user as receiver
                  setupMessageListener(currentUserId);

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final String messageText = message['text'];
                      final String senderId = message['senderId'];

                      // Customize the UI to show different styles for sender and receiver messages
                      return ListTile(
                        title: Text(
                          messageText,
                          textAlign: senderId == currentUserId
                              ? TextAlign
                                  .end // Align sender's messages to the right
                              : TextAlign
                                  .start, // Align receiver's messages to the left
                          style: TextStyle(
                            color: senderId == currentUserId
                                ? Colors.white
                                : Colors.green,
                          ),
                        ),
                      );
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
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        fillColor: Color(0xffe4e0ec),
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    color: Colors.amber,
                    child: IconButton(
                      //padding: EdgeInsets.,//double.infinity,
                      color: Colors.black,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        String message = _messageController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(
                              currentUserId, 'your_receiver_id', message);
                          _messageController.clear();
                        }
                      },
                    ),
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
