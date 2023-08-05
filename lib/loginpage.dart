import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/functions.dart';
import 'package:sherlock/signuppage.dart';
import 'package:sherlock/weather/loadingscreen.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void signuserin() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => loadingscreen()),
      );
      showLoggedinMessaage();
    } on FirebaseAuthException catch (e) {
      //if wwe have an eror pop the corcle and show us message
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        //wrong email
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Incorrect Email "),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("Incorrect Password "),
          );
        });
  }

  showLoggedinMessaage() {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: customflashmessage(messagetext: "Logged In"),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE6766FEB),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/login.png"),
                const Text.rich(
                  TextSpan(
                    text: "Unlock Locks with ",
                    style: TextStyle(fontSize: 15.0),
                    children: [
                      TextSpan(
                        text: " SherLock",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xFFFFFF00),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                textField(
                    obsecuretext: false,
                    text: "Email",
                    icon: Icons.email,
                    controller: emailController),
                const SizedBox(height: 30.0),
                textField(
                    obsecuretext: true,
                    text: "Password",
                    icon: Icons.lock,
                    controller: passwordController),
                const SizedBox(
                  height: 20.0,
                ),
                Text.rich(
                  TextSpan(
                    text: "Dont't Have an Account ",
                    style: const TextStyle(fontSize: 15.0),
                    children: [
                      TextSpan(
                          text: " SignUp!!!",
                          style: const TextStyle(
                            color: Color(0xFFFFFF00),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextscreen(
                                context,
                                const signuppage(),
                              );
                            })
                    ],
                  ),
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
                        primary: const Color(0xFF494597),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      onPressed: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content:
                        //         customflashmessage(messagetext: "Logged In"),
                        //     behavior: SnackBarBehavior.floating,
                        //     elevation: 0,
                        //     backgroundColor: Colors.transparent,
                        //   ),
                        // );
                        signuserin();
                        ;
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
