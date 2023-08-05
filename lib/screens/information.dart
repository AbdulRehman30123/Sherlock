import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/models/historymodel.dart';

import '../models/today_model.dart';

class Information extends StatefulWidget {
  final Team team;
  const Information({Key? key, required this.team}) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    var useremail = FirebaseAuth.instance.currentUser!.email;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SingleChildScrollView(
        child: Column(
          children: [
// for real time we use stream builder
            Container(
              height: MediaQuery.of(context).size.height * 0.58,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("lockhistory")
                    .doc(widget.team.id)
                    .collection("today")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Today today = Today.fromJson(
                                snapshot.data!.docs[index].data()!
                                    as Map<String, dynamic>);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xFF494597),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: ListTile(
                                          focusColor: Colors.red,
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Lock Status: ${today.status.toString()}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Text(
                                                    "Lock ${today.status.toString()} at ${today.time.toString()}"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20),
                                                child: Text(
                                                    "Lock opened by: ${today.useremail.toString()}"),
                                              )
                                            ],
                                          ),
                                          onTap: () {}),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
// floating action button to add new team to the firebase// This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),
    ));
  }
}
