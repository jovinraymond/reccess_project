import 'package:flutter/material.dart';
import 'login.dart';
import 'payment_page.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Tenant Management system"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: [
              //TextField(autofillHints: ,)
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 50, left: 40, right: 45, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/ava1.jpg"),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Your Name",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(
          //height: 30,
          //),
          Container(
            width: 400,
            height: 250,
            padding: EdgeInsets.only(top: 50, left: 50, right: 45, bottom: 30),
            decoration: BoxDecoration(
              color: Colors.blue[300],
              borderRadius: BorderRadius.circular(23),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.green,
                      //decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(10)),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentPage()),
                          );
                        },
                        child: Text("Payment"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.amber,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "mantainance_request");
                        },
                        child: Text("Maintenance"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(7),
                      color: Colors.purple,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "message");
                        },
                        child: Text("Chatroom"),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(9),
                      color: Color(0xffff0713),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
