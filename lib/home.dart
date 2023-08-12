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
  //String _searchQuery = '';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 5,
              ),
              Text("Home"),
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage("assets/ava1.jpg"),
              ),
            ],
          ),
          backgroundColor: Color(0xff120f13),
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
                  Navigator.pop(context);
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
                image: AssetImage('assets/pic.jpg'), fit: BoxFit.cover),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                            onPressed: () {
                              Navigator.pushNamed(context, "payment_page");
                            },
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
                              Navigator.pushNamed(context, "lease_agreement");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(37),
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
                            onPressed: () {
                              Navigator.pushNamed(context, "feedback");
                            },
                            child: Text(
                              "Feedback",
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
                    padding: EdgeInsets.all(29),
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
                            onPressed: () {
                              Navigator.pushNamed(context, "emergency");
                            },
                            child: Text(
                              "Emergency lines",
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
