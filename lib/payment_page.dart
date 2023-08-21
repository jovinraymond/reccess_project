import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui';

void main() {
  runApp(PaymentPage());
}

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Standard Demo',
      home: MyHomePage('Flutterwave Standard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  final currencyController = TextEditingController();
  final narrationController = TextEditingController();
  final publicKeyController = TextEditingController();
  final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String selectedCurrency = "UGX";
  int _selectedIndex = 0;

  bool isTestMode = true;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    this.currencyController.text = this.selectedCurrency;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
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
            image: AssetImage('assets/yo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        //width: double.infinity,
        //margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Form(
          key: this.formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(hintText: "Amount"),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Amount is required",
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.currencyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  readOnly: true,
                  onTap: this._openBottomSheet,
                  decoration: InputDecoration(
                    hintText: "Currency",
                  ),
                  validator: (value) => value != null && value.isNotEmpty
                      ? null
                      : "Currency is required",
                ),
              ),
              /* Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.publicKeyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Public Key",
                  ),
                ),
              ),*/
              /*Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.encryptionKeyController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Encryption Key",
                  ),
                ),
              ),*/
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.emailController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: this.phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),
              /*Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: [
                    Text("Use Debug"),
                    Switch(
                      onChanged: (value) => {
                        setState(() {
                          isTestMode = value;
                        })
                      },
                      value: this.isTestMode,
                    ),
                  ],
                ),
              ),*/
              Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.black,
                    padding: EdgeInsets.all(23),
                    primary: Colors.white,
                  ),
                  onPressed: this._onPressed,
                  child: Text(
                    "Make Payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    final currentState = this.formKey.currentState;
    if (currentState != null && currentState.validate()) {
      this._handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(email: "customer@customer.com");

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey: "FLWPUBK_TEST-7fca23ff4154d6afee133984a6a83f9e-X",
        currency: this.selectedCurrency,
        redirectUrl: 'https://facebook.com',
        txRef: Uuid().v1(),
        amount: this.amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card, payattitude, barter, bank transfer, ussd",
        customization: Customization(title: "Test Payment"),
        isTestMode: this.isTestMode);
    final ChargeResponse response = await flutterwave.charge();
    this.showLoading(response.toString());
    print("${response.toJson()}");
  }

  String getPublicKey() {
    return "FLWPUBK_TEST-7fca23ff4154d6afee133984a6a83f9e-X";
  }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["NGN", "RWF", "UGX", "KES", "ZAR", "USD", "GHS", "TZS"];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    this.setState(() {
      this.selectedCurrency = currency;
      this.currencyController.text = currency;
    });
    Navigator.pop(this.context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: this.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}
