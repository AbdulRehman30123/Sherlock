import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  const Devices({Key? key}) : super(key: key);

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A0E21),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Manage Devices',
          style: TextStyle(
            color: Color(0xFFFFFF00),
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
