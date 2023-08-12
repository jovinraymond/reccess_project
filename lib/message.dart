import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //String currentUserId = 'your_sender_id'; // Replace with actual sender ID

  void setupMessageListener(String receiverId) {
    final CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection('messages');

    messagesCollection
        .where('receiverId', isEqualTo: receiverId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((querySnapshot) {
      // Handle received messages as needed
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushNamed(context, "home");
              },
            ),
            ListTile(
              title: Text('View Profile'),
              onTap: () {
                Navigator.pushNamed(context, 'user_profile');
              },
            ),
            ListTile(
              title: Text('Contact landlord'),
              onTap: () {
                Navigator.pushNamed(context, 'mantainance_request');
              },
            ),
            ListTile(
              title: Text('Feedback'),
              onTap: () {
                Navigator.pushNamed(context, 'feedback');
              },
            ),
            ListTile(
              title: Text('Emergency Contacts'),
              onTap: () {
                Navigator.pushNamed(context, 'emergency');
              },
            ),
            ListTile(
              iconColor: Colors.amber,
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, 'login');
              },
            ),
          ],
        ),
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

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final String messageText = message['text'];
                      final String senderId = message['senderId'];

                      final isSender = senderId == _currentUser;

                      return Container(
                        padding: EdgeInsets.only(
                          left: 14,
                          right: 14,
                          top: 10,
                          bottom: 10,
                        ),
                        child: Align(
                          alignment:
                              isSender ? Alignment.topRight : Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isSender
                                  ? Colors.blue[200]
                                  : Colors.grey.shade200,
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messageText,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
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
                  SizedBox(width: 5),
                  Container(
                    color: Colors.amber,
                    child: IconButton(
                      color: Colors.black,
                      icon: Icon(Icons.send),
                      onPressed: () {
                        String message = _messageController.text.trim();
                        if (message.isNotEmpty) {
                          sendMessage(
                              _currentUser!.uid, 'your_receiver_id', message);
                          _messageController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
