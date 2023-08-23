import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loginuicolors/read_data.dart';
//import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  final UserProfile userProfile; // Add this line

  ProfilePage({required this.userProfile}); // Add this line

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late UserProfile userProfile;

  @override
  final user = FirebaseAuth.instance.currentUser;
  //CollectionReference user = FirebaseFirestore.instance.collection("users");
  //doc ids
  List<String> docIDs = [];

  // get user data
  Future GetDocId() async {
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }));
  }

  Future<void> UpdateUserInfo(String name, String email, int phone) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid) // Use the user's UID to reference their document
          .set({
        "Name": name,
        "Email": email,
        "Phone": phone,
      });
    } else {
      // Handle the case where the user is not authenticated
      print("User not authenticated");
    }
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout, semanticLabel: 'Edit profile'),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ews.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: 100,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/ava1.jpg"),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User Profile Page',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "");
                  },
                  child: Text(
                    "Edit profile",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),

            Expanded(
                child: FutureBuilder(
                    future: GetDocId(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GetUserName(userProfile: docIDs[index]),
                          );
                        },
                      );
                    }))
            //ElevatedButton(onPressed: onPressed, child: child);
            // Display user profile information here
            //SizedBox(height: 20),
            //Text('Name: ${widget.userProfile.name}'), // Access via widget
            //Text('Email: ${widget.userProfile.email}'), // Access via widget
            //Text(
            // 'Phone Number: ${widget.userProfile.phoneNumber}'), // Access via widget
            // Text(
            // 'Room Number: ${widget.userProfile.roomNumber}') // Access via widget
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
      ), // This trailing comm
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String phone;
  //final String roomNumber;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    // required this.roomNumber,
  });
}
