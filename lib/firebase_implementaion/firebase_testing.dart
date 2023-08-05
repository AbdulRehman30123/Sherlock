import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sherlock/uiscreen.dart';

class login_page extends StatefulWidget {
  login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signuserin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const uiscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("login page"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(hintText: "Email"),
          ),
          TextField(
            decoration: InputDecoration(hintText: "Password"),
          ),
          ElevatedButton(onPressed: signuserin, child: Text("Login"))
        ],
      ),
    );
  }
}
