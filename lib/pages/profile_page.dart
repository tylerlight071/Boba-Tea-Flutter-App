// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print

import 'package:boba_tea_app/read_data/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  // document IDs

  List<String> docIDs = [];

  // get docIDs
  Future getDocId() async {
    docIDs.clear();
    await FirebaseFirestore.instance.collection('users').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB0A599),
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black54),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text("Profile Page",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xFFB0A599),
        ),
        body: Column(
          children: [
            const Divider(
              thickness: 0.5,
              color: Colors.black54,
            ),
            Expanded(
                child: FutureBuilder(
              future: getDocId(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: docIDs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                        title: GetUserName(documentId: docIDs[index]));
                  },
                );
              },
            )),
          ],
        ));
  }
}
