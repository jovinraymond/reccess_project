import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'authentication.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _userSignedIn = false;
  final Authentication _authentication = Authentication();

  void initState() {
    super.initState();

    /// Events are fired when the following occurs:
    /// - Right after the listener has been registered.
    /// - When a user is signed in.
    /// - When the current user is signed out.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() => _userSignedIn = false);
      } else {
        print('User is signed in!');
        setState(() => _userSignedIn = true);
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save the user data to Cloud Firestore
      String email = emailController.text;
      String name = nameController.text;
      String password = passwordController.text;
      String phone = phoneController.text;

      // Add user data to Firestore
      FirebaseFirestore.instance.collection('users').add({
        'email': email,
        'name': name,
        'password': password,
        'phone': phone,
      }).then((value) {
        // Data added successfully
        print('User data added to Firestore!');
        // You can perform additional actions here
      }).catchError((error) {
        // Error occurred while adding data
        print('Error adding user data to Firestore: $error');
        // You can handle the error gracefully here
      });
    }
  }

  void _signUpPressed() async {
    _authentication.signUp(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  void _signInPressed() async {
    _authentication.signIn(
      emailController.text.trim(),
      passwordController.text.trim(),
    );
  }

  void _signOutPressed() async {
    _authentication.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/pihc.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(children: [
          Container(
            padding: EdgeInsets.only(left: 30, top: 20),
            child: Text(
              'Create Your Account',
              style: TextStyle(color: Colors.amber, fontSize: 33),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Name",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                _submitForm();
                                _signUpPressed();
                                Navigator.pushNamed(context, 'lease_agreement');
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xfff5f6f9),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Add more TextFormFields or other form fields here
                        // ...
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
