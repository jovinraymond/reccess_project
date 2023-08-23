import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(home: ChatScreen()));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void sendMessage(String message) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Create a new subcollection under the sender's user document for sent messages
    CollectionReference senderMessagesCollection =
        usersCollection.doc(_currentUser!.uid).collection('messages');

    // Create a new document in the "messages" collection for the sent message
    DocumentReference messagesCollection =
        FirebaseFirestore.instance.collection('messages').doc();

    final Map<String, dynamic> messageData = {
      'senderId': _currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
      'text': message,
    };

    // Add the message to the sender's subcollection
    await senderMessagesCollection.add(messageData);

    // Add the message to the "messages" collection
    await messagesCollection.set(messageData);
  }

  Future<String> getCurrentUserName() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(_currentUser!.uid)
        .get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      return userData['name'];
    } else {
      return "Member";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat', textAlign: TextAlign.center),
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
                Navigator.pushNamed(context, 'profile');
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection(
                      'messages') // Use the top-level 'messages' collection
                  .orderBy('timestamp', descending: true)
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

                    final isSender = senderId == _currentUser!.uid;

                    return FutureBuilder(
                      future: getCurrentUserName(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final senderName = snapshot.data as String;

                        return Align(
                          alignment: isSender
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSender
                                  ? Colors.blue[100]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isSender ? 'You' : senderName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isSender ? Colors.blue : Colors.black,
                                  ),
                                ),
                                Text(
                                  // Format the timestamp to display date and time
                                  DateFormat('MMM d, y HH:mm').format(
                                    (message['timestamp'] as Timestamp)
                                        .toDate(),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(messageText),
                              ],
                            ),
                          ),
                        );
                      },
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
                        sendMessage(message);
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
              backgroundColor: Colors.pink),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 0) {
            // Navigate to the homepage when the home icon is tapped
            Navigator.pushReplacementNamed(context, "home");
          } else {
            _onItemTapped(
                index); // Continue with the existing logic for other icons
          }
        },
      ),
    );
  }
}
