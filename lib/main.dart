import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'
    show MaterialApp, WidgetsFlutterBinding, runApp;
import 'package:firebase_core/firebase_core.dart';
import 'package:loginuicolors/emergency.dart';
import 'package:loginuicolors/feedback.dart';
import 'package:loginuicolors/lease_agreement.dart';
import 'package:loginuicolors/mantainance_request.dart';
import 'package:loginuicolors/message.dart';
import 'package:loginuicolors/payment_page.dart';
import 'package:loginuicolors/user_profile.dart';
import 'home.dart';
import 'login.dart';
import 'register.dart';
//import 'message.dart';
//import 'mantainance_request.dart';

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
    home: MyLogin(),
    routes: {
      'mantainance_request': (context) => SendEmailScreen(),
      'register': (context) => MyRegister(),
      'message': (context) => ChatScreen(),
      'home': (context) => Homep(),
      'login': (context) => MyLogin(),
      'emergency': (context) => EmergencyContactsPage(),
      'feedback': (context) => FeedbackPage(),
      'user_profile': (context) => ProfilePage(
          userProfile: UserProfile(
              email: 'email',
              name: 'name',
              phoneNumber: 'phoneNumber',
              roomNumber: 'roomNumber')),
      'lease_agreement': (context) => LeaseAgreementScreen(),
      'payment_page': (context) => PaymentPage(),
    },
  ));
}
