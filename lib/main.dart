import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'
    show
        AppBar,
        CircleAvatar,
        Colors,
        Drawer,
        Icons,
        ListTile,
        MaterialApp,
        MaterialPageRoute,
        Scaffold,
        WidgetsFlutterBinding,
        runApp;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:loginuicolors/authentication.dart';
import 'package:loginuicolors/emergency.dart';
import 'package:loginuicolors/feedback.dart';
import 'package:loginuicolors/lease_agreement.dart';
import 'package:loginuicolors/mantainance_request.dart';
import 'package:loginuicolors/message.dart';
import 'package:loginuicolors/payment_page.dart';
import 'package:loginuicolors/profile.dart';
import 'package:loginuicolors/slpash_sreen.dart';
import 'package:loginuicolors/user_profile.dart';
import 'home.dart';
import 'login.dart';
import 'register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDMyNfjfT02ENgSIvoHAo7ZWr7CZXouK0s",
          authDomain: "tenant-ms-2eba0.firebaseapp.com",
          projectId: "tenant-ms-2eba0",
          storageBucket: "tenant-ms-2eba0.appspot.com",
          messagingSenderId: "54381844554",
          appId: "1:54381844554:web:eddf986220d57dd2292eb3",
          measurementId: "G-16FXFJM7EQ"));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'mantainance_request': (context) => SendEmailScreen(),
      'register': (context) => MyRegister(),
      'message': (context) => ChatScreen(),
      'home': (context) => Homep(),
      'login': (context) => MyLogin(),
      'emergency': (context) => EmergencyContactsPage(),
      'feedback': (context) => FeedbackPage(),
      'profile': (context) => MenuBarScreen(),
      'lease_agreement': (context) => LeaseAgreementScreen(),
      'payment_page': (context) => PaymentPage(),
    },
  ));
}

class MenuBarScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Bar'),
      ),
      body: CustomMenuBar(auth: _auth),
    );
  }
}

class CustomMenuBar extends StatefulWidget {
  final FirebaseAuth auth;

  CustomMenuBar({required this.auth});

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<CustomMenuBar> {
  String? userId; // Define userId variable
  String? displayName; // Define displayName variable

  @override
  void initState() {
    super.initState();
    // Get the current user's ID when the menu bar is created
    if (widget.auth.currentUser != null) {
      userId = widget.auth.currentUser!.uid;
      _fetchDisplayName();
    }
  }

  Future<void> _fetchDisplayName() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      if (userSnapshot.exists) {
        displayName = userSnapshot['name'];
        setState(() {});
      }
    } catch (error) {
      print('Error fetching user name: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.blue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    // Display user profile image here
                  ),
                  SizedBox(height: 10),
                  Text(
                    displayName ??
                        "User Name", // Display the displayName or "User Name" if null
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              if (userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProfilePage(
                          userProfile: UserProfile(
                        email: 'email',
                        name: 'name',
                        phone: 'phone',
                      ));
                    },
                  ),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async {
              await widget.auth.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MyLogin(),
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text("Emergency Contacts"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext content) {
                    return EmergencyContactsPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
