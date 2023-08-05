import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sherlock/loginpage.dart';

import 'firebasefucntions/firebasefunctions.dart';

class signuppage extends StatefulWidget {
  const signuppage({Key? key}) : super(key: key);

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  @override
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String ctime = DateFormat("HH:mm:ss").format(DateTime.now());
  //function section

//1 create user
  void createUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then(
            (value) => storeData(),
          );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const loginpage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        passwordWeakMessage(context);
      } else if (e.code == 'email-already-in-use') {
        alreadyExistMessage(context);
      }
    } catch (e) {
      print(e);
    }
  }

  //2 store user data
  void storeData() async {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("Users").doc(userid).set(
      {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "name": nameController.text.trim(),
        "doorstatus": "null"
      },
    );
  }

  // create a collection to sotre history of lock
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE6766FEB),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/signup.png"),
                const Text.rich(
                  TextSpan(
                    text: "Sign-up to see The Magic of ",
                    style: TextStyle(fontSize: 15.0),
                    children: [
                      TextSpan(
                        text: " SherLock",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            0xFFFFFF00,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                textField(
                  obsecuretext: false,
                  text: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                textField(
                    obsecuretext: true,
                    text: "Password",
                    icon: Icons.password,
                    controller: passwordController),
                const SizedBox(
                  height: 10.0,
                ),
                textField(
                    obsecuretext: false,
                    text: "Name",
                    icon: Icons.drive_file_rename_outline,
                    controller: nameController),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color(0xFF494597)),
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    onPressed: () {
                      createUser();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class textField extends StatelessWidget {
  final text;
  final IconData icon;
  final controller;
  bool obsecuretext;
  textField(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.obsecuretext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecuretext,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xff8f89f1),
        label: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFFFFFF00),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFFF00),
          ),
        ),
      ),
    );
  }
}

class customflashmessage extends StatelessWidget {
  customflashmessage({Key? key, required this.messagetext}) : super(key: key);
  String messagetext;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 90.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(children: [
        Text(
          messagetext,
          style: const TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
