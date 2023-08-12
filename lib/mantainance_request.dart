import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendEmailScreen extends StatefulWidget {
  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  final _formKey = GlobalKey<FormState>(); // Step 1

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Send a Maintenance request'),
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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/ews.jpg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            // Wrap your content in a Form widget and use _formKey.
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Landlord Email',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    fillColor: Colors.grey.shade100,
                    filled: true,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Body',
                      fillColor: Colors.transparent,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await sendEmail(
                        _nameController.text, // Step 2
                        _emailController.text, // Step 2
                        _messageController.text, // Step 2
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        response == 200
                            ? const SnackBar(
                                content: Text('Message Sent!'),
                                backgroundColor: Colors.green)
                            : const SnackBar(
                                content: Text('Failed to send message!'),
                                backgroundColor: Colors.red),
                      );
                      _nameController.clear(); // Step 2
                      _emailController.clear(); // Step 2
                      _messageController.clear(); // Step 2
                    }
                  },
                  child: Text("Send Email",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_hko6mjh';
    const templateId = 'template_bsnot6a';
    const userId = 'J9NG4xRyTIcv1ER9h';

    final response = await http.post(url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json'
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message
          }
        }));
    return response.statusCode;
  }
}
