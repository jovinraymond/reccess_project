import 'dart:html';

import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(MaterialApp(
    home: MyLogin(),
  ));
}

class Homep extends StatefulWidget {
  const Homep({Key? key}) : super(key: key);

  @override
  State<Homep> createState() => _HomepState();
}

class _HomepState extends State<Homep> {
  String _searchQuery = '';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tenant Management system"),
          backgroundColor: Color(0xff120f13),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/pic.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 50, left: 40, right: 45, bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(23),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/ava1.jpg"),
                      ),
                      Text(
                        "Your Name",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Card(
                              color: Colors.white, // Set the desired color here
                              elevation: 10,
                              child: Column(
                                children: [
                                  Icon(Icons.phone_android, size: 50),
                                  MaterialButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Payment",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Icon(Icons.key, size: 50),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, 'mantainance_request');
                                    },
                                    child: Text(
                                      "Maintenance",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(35),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  Icon(Icons.message_outlined, size: 50),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, "message");
                                    },
                                    child: Text(
                                      "Chatroom",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: Card(
                              elevation: 10,
                              child: Column(
                                children: [
                                  //IconButton(onPressed: (){}),
                                  Icon(
                                    Icons.assignment_return_outlined,
                                    size: 50,
                                    color: Colors.black,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "lease_agreement");
                                    },
                                    child: Text(
                                      "Lease agreem",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
