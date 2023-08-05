import 'package:flutter/material.dart';
import 'package:sherlock/welcome/intropage1.dart';
import 'package:sherlock/welcome/intropage2.dart';
import 'package:sherlock/welcome/intropag3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sherlock/loginpage.dart';

class BoardingPae extends StatefulWidget {
  const BoardingPae({Key? key}) : super(key: key);

  @override
  State<BoardingPae> createState() => _BoardingPaeState();
}

class _BoardingPaeState extends State<BoardingPae> {
  //controller to track page numbers
  PageController _controller = PageController();
  //check we are on last paage or not
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //page view
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          //Smooth Page Indicator
          Container(
            alignment: const Alignment(0, 0.7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip button
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text("Skip"),
                ),
                //smooth page indicator
                SmoothPageIndicator(controller: _controller, count: 3),
                //done or next
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const loginpage();
                          }));
                        },
                        child: const Text("Done"),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text("Next"),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
