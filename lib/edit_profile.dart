import 'package:flutter/material.dart';
import 'package:loginuicolors/user_profile.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile userProfile;

  EditProfilePage({required this.userProfile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _phoneController = TextEditingController(text: widget.userProfile.phone);
    // _roomNumberController =
    //TextEditingController(text: widget.userProfile.roomNumber);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void _saveChanges() {
    // Perform the update logic here
    String newName = _nameController.text;
    String newEmail = _emailController.text;
    String newPhoneNumber = _phoneController.text;

    // Update the user's profile
    UserProfile updatedProfile = UserProfile(
      name: newName,
      email: newEmail,
      phone: newPhoneNumber,
    );

    // You can send the updated profile to an API, update the database, etc.

    // Optionally, navigate back to the profile page after saving
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(controller: _nameController),
            TextField(controller: _emailController),
            TextField(controller: _phoneController),
          ],
        ),
      ),
    );
  }
}
