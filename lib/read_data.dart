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
            return Container(
              padding: EdgeInsets.all(35),
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                color: Color(0x62f9f3f3),
                borderRadius: BorderRadius.circular(55),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${data['name']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(" Email: ${data['email']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(
                    height: 25,
                  ),
                  Text("Phone: ${data['phone']}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                ],
              ),
            );
          }
          return Text("loading");
        });
  }
}
