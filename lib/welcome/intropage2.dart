import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xE6837DED),
        child: Column(
          children: [
            Center(
                heightFactor: 2,
                child: Lottie.asset("assets/90452-access-door.json")),
            const Text.rich(
              TextSpan(
                  text: "Access Locks From ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  children: [
                    TextSpan(
                      text: "Any Where",
                      style: TextStyle(
                        color: Color(
                          0xFFFFFF00,
                        ),
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(6, 6),
                              blurRadius: 15.0),
                        ],
                      ),
                    )
                  ]),
            )
          ],
        ));
  }
}
