// to change door status in main collection

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// create user fucntion

void openDoorStatus() async {
  final userID = await FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userID)
      .update({"doorstatus": "Open"});
}

void closeDoorStatus() async {
  final userID = await FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userID)
      .update({"doorstatus": "Close"});
}

void passwordWeakMessage(context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Password is weak "),
        );
      });
}

void alreadyExistMessage(context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("The account already exists for that email "),
        );
      });
}
