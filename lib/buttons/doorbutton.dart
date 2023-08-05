import 'package:flutter/material.dart';

class doorbutton extends StatelessWidget {
  doorbutton({Key? key, this.ontap, required this.isbuttonpressed})
      : super(key: key);
  final ontap;
  bool isbuttonpressed;
  MaterialColor check() {
    if (isbuttonpressed == true) {
      return Colors.green;
    } else if (isbuttonpressed == false) {
      return Colors.red;
    }
    return Colors.cyan;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(0xFF1D1E33),
          boxShadow: const [
            BoxShadow(
                color: Color(0xFF393b64),
                offset: Offset(6, 6),
                blurRadius: 15,
                spreadRadius: 1),
          ],
        ),
        child: Column(
          children: const [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Door",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Icon(
              Icons.door_back_door,
              color: Colors.green,
              size: 80.0,
            )
          ],
        ),
      ),
    );
  }
}
