import 'package:flutter/material.dart';
import 'package:sherlock/signuppage.dart';

class NewDevice extends StatefulWidget {
  const NewDevice({Key? key}) : super(key: key);

  @override
  State<NewDevice> createState() => _NewDeviceState();
}

class _NewDeviceState extends State<NewDevice> {
  final formkey = GlobalKey<FormState>();
  String deviceid = "";
  String devicename = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A0E21),
        centerTitle: true,
        title: const Text(
          'New Device',
          style: TextStyle(color: Color(0xFFFFFF00)),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'Device Name',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF00),
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          devicename = val;
                          // print(devicename);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text(
                          'Device ID',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFFF00),
                          ),
                        ),
                      ),
                      onChanged: (val) {
                        setState(() {
                          deviceid = val;
                          // print(deviceid);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          primary: const Color(0xFF494597),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: customflashmessage(
                                  messagetext:
                                      "Device is Registered Successfully"),
                              behavior: SnackBarBehavior.floating,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                            ),
                          );
                        },
                        child: const Text(
                          "Add Device",
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
