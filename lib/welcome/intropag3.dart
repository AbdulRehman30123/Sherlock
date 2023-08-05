import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xE6766FEB),
      child: Column(
        children: [
          Center(
            heightFactor: 1.5,
            child: Lottie.asset("assets/88252-data-security.json"),
          ),
          const Text.rich(
            TextSpan(
              text: "Fully ",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: " Manageable ",
                  style: TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(6, 6),
                          blurRadius: 15.0),
                    ],
                  ),
                ),
                TextSpan(
                  text: " and ",
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " Accessible ",
                  style: TextStyle(
                    color: Color(0xFFFFFF00),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(6, 6),
                          blurRadius: 15.0),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
