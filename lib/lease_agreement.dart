import 'dart:async';

//import 'dart:js' as js;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:signature/signature.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeaseAgreementScreen extends StatefulWidget {
  @override
  _LeaseAgreementScreenState createState() => _LeaseAgreementScreenState();
}

class _LeaseAgreementScreenState extends State<LeaseAgreementScreen> {
  bool _isAccepted = false;

  int _selectedIndex = 0;
  String _tenantName = ''; // Initialize the tenant name
  String _tenantEmail = '';
  //String _tenantName = ''; // Initialize the tenant name

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the screen initializes
  }

  Future<void> _fetchUserData() async {
    // Assuming you're using Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      // Now you have the user ID

      // Fetch user data from your authentication system
      setState(() {
        _tenantName = user.displayName ?? '';
        _tenantEmail = user.email ?? '';
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.white,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void dispose() {
    super.dispose();
  }

  _loadAcceptanceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAccepted = prefs.getBool('isAccepted') ?? false;
    });
  }

  _saveAcceptanceStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAccepted', _isAccepted);
  }

  @override
  Widget build(BuildContext context) {
    // Signature Pad Widget
    Signature _signatureCanvas = Signature(
      controller: _controller,
      width: 200,
      height: 200,
      backgroundColor: Colors.black,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Lease Agreement'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lease Agreement',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'This is the content of the lease agreement. Please read it carefully and accept the terms before proceeding.  ',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '1_LEASE TYPE. This Agreement shall be considered a'
                '_May continue to lease the Premises under the same terms of this Agreement under a month-to-month arrangement.'
                '_Must vacate the Premises.'
                '_Month-to-Month Lease. The Tenant shall be allowed to occupy the Premises on a month-to-month arrangement starting on ________________, 20____ and ending upon notice of ____ days from either Party to the other Party.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  '2_OCCUPANT(S). The Premises is to be occupied strictly as a residential dwelling with the following individual(s) in addition to the Tenant'
                  '______________________________________________ (Occupant(s))\n\n'
                  '3_PURPOSE. The Tenant and Occupant(s) may only use the Premises as\n'
                  '_A residential dwelling only.'
                  '_A residential dwelling and: _______________________________________.\n\n'
                  '4_RENT PAYMENT.\n'
                  'The Tenant shall pay the Landlord, in equal monthly installments, (amount). The Rent shall be due on the after every month (Due Date) and paid via mobile money or cash.\n\n'
                  '_NON-SUFFICIENT FUNDS (NSF CHECKS).\n If the Tenant pays the Rent with a check that is not honored due to insufficient funds (NSF).\n'
                  '_There shall be a fee of ____ per incident.\n'
                  '_LATE FEE. If Rent is not paid on the Due Date: \n'
                  '_There shall be a penalty of ____ due as _One (1) Time Payment ☐ Every Day Rent is Late. Rent is considered late when it has not been paid within ____ day(s) after the Due Date.\n\n'
                  '_FIRST (1ST) MONTHS RENT. The Tenant is required to pay the first (1st) months \n'
                  '_Upon the execution of this Agreement.\n\n'
                  '5_MOVE-IN INSPECTION.\n Before, at the time of the Tenant accepting possession, or shortly thereafter, the Landlord and Tenant: \n'
                  '_Agree to inspect the Premises and write any present damages or needed repairs on a move-in checklist.\n\n'
                  '6_PARKING.\n The Landlord'
                  'Shall provide parking space(s) to the Tenant for a fee to be paid at the execution of this Agreement \n\n'
                  '7_SALE OF PROPERTY.\n If the Premises is sold, the Tenant is to be notified of the new Owner, and if there is a new Manager, their contact details for repairs and'
                  'maintenance shall be forwarded.\n\n'
                  '8_ EARLY TERMINATION. \nThe Tenant: '
                  '_Shall have the right to terminate this Agreement at any time by providing at least ___ days written notice to the Landlord along with an early termination fee of ___________ . During the notice period for termination the Tenant will remain responsible for Rent, utilities, and other fees.\n\n'
                  '9_LANDLORD ACCESS.\n The Landlord'
                  '_Shall give the Tenant at least ___ hours’ notice before entering the Premises.\n\n'
                  '10_PET POLICY.\n The Tenant:'
                  '_Is not allowed to keep pets on the Premises.\n\n'
                  '11_SMOKING POLICY.\n Smoking is'
                  '_NOT allowed inside the Premises.\n\n'
                  '12_ALTERATIONS.\n The Tenant: '
                  'Shall not make any alterations, additions, or improvements to the Premises without the prior written consent of the Landlord.\n\n'
                  '13_MAINTENANCE AND REPAIRS.\n The responsibilities of maintenance and repairs are as follows: \n'
                  '_The Landlord shall be responsible for all maintenance and repairs to the Premises but if the tenant causes the damage, he or she will cover the maintenance costs .\n\n\n'
                  'Tenant(s): _______________________\n'
                  'Signature: ______________________\n'
                  'Date: ______________________\n'),
              Row(
                children: [
                  Text('Accept the Agreement'),
                  Switch(
                    value: _isAccepted,
                    onChanged: (newValue) {
                      setState(() {
                        _isAccepted = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              // Signature Pad

              // Signature Pad Widget
              Text("Tenant's signature:"),
              _signatureCanvas,
              SizedBox(height: 16),
              Text("Landlord's signature:"),
              _signatureCanvas,

              SizedBox(height: 16),

              Row(
                children: [
                  SizedBox(
                    width: 90,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .pink, // Set the desired background color of the button
                      onPrimary:
                          Colors.white, // Set the text color of the button
                      elevation: 8, // Set the elevation of the button
                      // Add more properties here as needed
                    ),
                    onPressed: () async {
                      // Save signature and proceed
                      _saveSignature();
                      _saveAcceptanceStatus();
                      if (_isAccepted) {
                        // Proceed with the next steps in your app.
                        LeaseAgreement agreement = LeaseAgreement(
                          tenantName: _tenantName.isNotEmpty
                              ? _tenantName
                              : _tenantEmail, // Use name or email
                          tenantEmail:
                              _tenantEmail, // Use the fetched tenant email
                          propertyDetails: 'Property details...',
                        );
                        // Save the lease agreement to the database.
                        // Assuming you have the user ID available
                        // Retrieve the user ID using Firebase Authentication
                        FirebaseAuth auth = FirebaseAuth.instance;
                        User? user = auth.currentUser;

                        if (user != null) {
                          String userId = user.uid;

                          LeaseAgreementDatabase database =
                              LeaseAgreementDatabase();
                          await database.saveLeaseAgreement(userId, agreement);

                          Navigator.pushNamed(context, "home");
                        }
                        // For example, navigate to the next screen or perform necessary actions.
                      } else {
                        // Handle the case when the user declines the agreement.
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.blueGrey,
                              title: Text("Error"),
                              content: Text(
                                  "You can't continue untill you sign the agreement. Please try again."),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            );
                          },
                        );
                        // You might want to show a warning or navigate away from this screen.
                      }
                    },
                    child: Text('Continue'),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
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
    );
  }

  // Function to save the signature as an image or in your desired format
  // Function to save the signature as an image locally
  //
  //

  void _saveSignature() async {
    final signatureImage = await _controller.toPngBytes();
    if (signatureImage != null) {
      // Convert Uint8List to List<int>
      List<int> signatureBytes = signatureImage;

      // Get the application's documents directory
      Directory appDocumentsDirectory =
          await getApplicationDocumentsDirectory();

      // Generate a unique filename for the image
      String filename =
          DateTime.now().millisecondsSinceEpoch.toString() + '.png';

      // Create the File object for the image
      File file = File('${appDocumentsDirectory.path}/$filename');

      // Write the signature image to the file
      await file.writeAsBytes(signatureImage);

      // Now you have the signature image saved locally and can access it using 'file' variable.
    }
  }
}

class LeaseAgreementDatabase {
  Future<void> saveLeaseAgreement(
      String userId, LeaseAgreement agreement) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection(
              'lease_agreements') // Subcollection under the user's document
          .add(agreement.toMap());
    } catch (e) {
      print('Error saving lease agreement: $e');
      // Handle the error as needed, such as showing an error message.
    }
  }
}

class LeaseAgreement {
  String tenantName; // Current user's name
  String tenantEmail; // Current user's email
  String propertyDetails;
  // Add more fields as needed.

  LeaseAgreement({
    required this.tenantName,
    required this.tenantEmail,
    required this.propertyDetails,
  });

  Map<String, dynamic> toMap() {
    return {
      'tenantName': tenantName,
      'tenantEmail': tenantEmail,
      'propertyDetails': propertyDetails,
      // Add more fields as needed.
    };
  }
}
