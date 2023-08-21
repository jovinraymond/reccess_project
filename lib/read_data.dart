import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  final String userProfile; // Add this line

  GetUserName({required this.userProfile}); // Add this line

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(userProfile).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(" ${data['name']}" +
                ':' +
                "${data['email']}" +
                ':' +
                "${data['phone']}");
          }
          return Text("loading");
        });
  }
}
