import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sherlock/screens/information.dart';

import '../models/historymodel.dart';

class Teams_screen extends StatefulWidget {
  const Teams_screen({Key? key}) : super(key: key);
  @override
  State<Teams_screen> createState() => _Teams_screenState();
}

class _Teams_screenState extends State<Teams_screen> {
  TextEditingController teamnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Team team = Team.fromJson(snapshot.data!.docs[index]
                                .data()! as Map<String, dynamic>);
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
                                      height: 50,
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
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    team.id.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Information(team: team)),
                                            );
                                          }),
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
    );
  }
}
