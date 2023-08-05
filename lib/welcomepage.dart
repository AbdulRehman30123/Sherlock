import 'package:flutter/material.dart';
import 'package:sherlock/loginpage.dart';
import 'functions.dart';
import 'package:lottie/lottie.dart';

class welcomepage extends StatefulWidget {
  const welcomepage({Key? key}) : super(key: key);

  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF766FEB),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100.0,
            ),
            //Image.asset("assets/welcome.png"),

            Lottie.network(
                "https://assets10.lottiefiles.com/packages/lf20_1pxqjqps.json"),
            //Lottie.asset("assets/75705-welcome-animation.mp4"),
            const SizedBox(height: 20.0),
            const Text.rich(
              TextSpan(
                text: "Welcome to   ",
                children: [
                  TextSpan(
                    text: "SherLock",
                    style: TextStyle(
                        color: Color(0xFFFFFF00),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              height: 150,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0.0,
                    primary: Color(0xFF494597)),
                onPressed: () {
                  nextscreen(
                    context,
                    loginpage(),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
