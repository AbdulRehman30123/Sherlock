import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xE6918BEF),
      child: Column(
        children: [
          Center(
            heightFactor: 1.5,
            child: Lottie.asset("assets/75705-welcome-animation.json"),
          ),
          const Text.rich(
            TextSpan(
                text: "Welcome to ",
                children: [
                  TextSpan(
                    text: " SherLock",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFFF00),
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(6, 6),
                            blurRadius: 15.0),
                      ],
                    ),
                  ),
                ],
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
