import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherlock/firebasefucntions/firebasefunctions.dart';
import 'package:sherlock/functions.dart';
import 'package:sherlock/screens/Devices.dart';
import 'package:sherlock/screens/historyscreen.dart';
import 'package:sherlock/screens/newdevice.dart';
import 'package:sherlock/signuppage.dart';

import 'loginpage.dart';

const Color open = Colors.green;
const Color close = Colors.red;
const Color defaultcolor = Color(0xFF1D1E33);

class uiscreen extends StatefulWidget {
  const uiscreen({Key? key, this.locationweather}) : super(key: key);
  final locationweather;

  @override
  State<uiscreen> createState() => _uiscreenState();
}

enum DeviceStatus { opendevice, closedevice }

class _uiscreenState extends State<uiscreen> {
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String ctime = DateFormat("HH:mm:ss").format(DateTime.now());
  var city, temp;
  var devicecolor = defaultcolor;
  final userid = FirebaseAuth.instance.currentUser!.uid;
  String userName = "";
  String email = "";
  int index = 0;
  int newindex = 0;
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => loginpage()),
    );
  }

// to ccreate and stpre lock history
  void lockHistoryUpdateOn() async {
    final useremail = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection("lockhistory")
        .doc(cdate)
        .collection("today")
        .doc(ctime)
        .set(
      {"status": "On", "time": ctime, "userid": useremail},
    );
  }

  void lockHistoryUpdateOff() async {
    final useremail = FirebaseAuth.instance.currentUser!.email;
    await FirebaseFirestore.instance
        .collection("lockhistory")
        .doc(cdate)
        .collection("today")
        .doc(ctime)
        .set(
      {"status": "Off", "time": ctime, "userid": useremail},
    );
  }

  // cretae date collection with its id
  void createDataCollection() async {
    var userid = await FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection("lockhistory").doc(cdate).set(
      {"id": cdate},
    );
  }

  // fetch record of user
  void getUserDetails() async {
    var _doc =
        await FirebaseFirestore.instance.collection("Users").doc(userid).get();
    Map<String, dynamic>? data = _doc.data();
    var _username = data!['name'];
    var _email = data['email'];
    setState(() {
      userName = _username;
      email = _email;

      print(_username);
      print(_email);
    });
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref("");
  //realtime database
  void createDoorStatus() async {
    await ref.set(
      {
        "stringi": "OFF",
      },
    );
  }

  void dooron() async {
    await ref.update(
      {
        "stringi": "ON",
      },
    );
  }

  void dooroff() async {
    await ref.update({
      "stringi": "OFF",
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
    createDoorStatus();
    createDataCollection();
    updategui(widget.locationweather);
  }

  void updategui(var weatherdata) {
    city = weatherdata['name'];
    temp = weatherdata['main']['temp'];
    print(city);
    print(temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "SherLock",
          style: TextStyle(
            color: Color(0xFFFFFF00),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: 150.0,
                  width: 150.0,
                  child: Container(
                    margin: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150.0,
                  width: 200,
                  child: reuseablecard(
                    colour: Color(0xFF1D1E33),
                    cardchild: ifocard(
                      username: userName,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFF0A0E21),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        const Text(
                          "Temperature",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          '$temp C',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xFF0A0E21)),
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50.0,
                        ),
                        const Text(
                          "Location",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '$city',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          devicecolor = open;
                          ctime = DateFormat("HH:mm:ss").format(DateTime.now());
                          newindex++;
                        },
                      );
                      openDoorStatus();
                      dooron();
                      lockHistoryUpdateOn();
                    },
                    onDoubleTap: () {
                      setState(() {
                        devicecolor = close;
                        ctime = DateFormat("HH:mm:ss").format(DateTime.now());
                        newindex++;
                      });
                      closeDoorStatus();
                      dooroff();
                      lockHistoryUpdateOff();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: devicecolor,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white70,
                            offset: Offset(6, 6),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          children: const [
                            Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 80.0,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Lock",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Teams_screen()),
                      );
                    },
                    child: reuseablecard(
                      colour: Color(0xFF1D1E33),
                      cardchild: historycard(cardname: 'Check History'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: const [
                Expanded(
                    child: reuseablecard(
                  cardchild: newdevicescard(cardname: 'Add Device'),
                  colour: defaultcolor,
                )),
                Expanded(
                  child: reuseablecard(
                    colour: Color(0xFF1D1E33),
                    cardchild: devicescard(cardname: 'Devices'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50.0,
            width: double.infinity,
            child: Container(
              color: const Color(0xFF1D1E33),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: const Color(0xFF1D1E33),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: customflashmessage(messagetext: "Logged Out"),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                  signUserOut();
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class reuseablecard extends StatelessWidget {
  const reuseablecard({Key? key, required this.cardchild, required this.colour})
      : super(key: key);
  final cardchild;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardchild,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: colour,
          boxShadow: const [
            BoxShadow(color: Colors.white70, offset: Offset(6, 6))
          ]),
    );
  }
}

class icondata extends StatelessWidget {
  icondata({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(label)
      ],
    );
  }
}

//this card id for userinfo at top
class ifocard extends StatelessWidget {
  const ifocard({Key? key, required this.username}) : super(key: key);
  final String username;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          const Text(
            "Welcome",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
          const SizedBox(height: 15.0),
          Text(
            username,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}

//this card is for devices tiles
class devicescard extends StatelessWidget {
  const devicescard({Key? key, required this.cardname}) : super(key: key);
  final String cardname;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextscreen(context, const Devices());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Text(
              cardname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

//this card is for newdevices tiles
class newdevicescard extends StatelessWidget {
  const newdevicescard({Key? key, required this.cardname}) : super(key: key);
  final String cardname;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextscreen(context, const NewDevice());
      },
      child: Container(
        height: 200,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Text(
              cardname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

//this card is for history tiles
class historycard extends StatelessWidget {
  const historycard({Key? key, required this.cardname}) : super(key: key);
  final String cardname;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 200,
        width: 200,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70.0),
            Text(
              cardname,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
//profile pic or profile info ka card ban gya h
// next baki k containers lagane hain
