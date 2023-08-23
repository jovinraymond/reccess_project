import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final UserProfile userProfile; // Add this line

  ProfilePage({required this.userProfile}); // Add this line

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User Profile Page',
              style: TextStyle(fontSize: 20),
            ),

            // Display user profile information here
            SizedBox(height: 20),
            Text('Name: ${widget.userProfile.name}'), // Access via widget
            Text('Email: ${widget.userProfile.email}'), // Access via widget
            Text(
                'Phone Number: ${widget.userProfile.phoneNumber}'), // Access via widget
            Text(
                'Room Number: ${widget.userProfile.roomNumber}') // Access via widget
          ],
        ),
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String phoneNumber;
  final String roomNumber;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.roomNumber,
  });
}
