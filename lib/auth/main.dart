import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcribe/auth/togglepage.dart';
import 'package:transcribe/authetications/createprofile.dart';
import 'package:transcribe/home/transcribe.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //   final String _uid = _user!.uid;
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshotdata) {
                    if (snapshotdata.hasData) {
                      if (snapshotdata.data!.exists) {
                        return const TranscribePage();
                      } else {
                        return const CreateProfile();
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.black,
                      ));
                    }
                  });
            } else {
              return const Togglepage();
            }
          }),
    );
  }
}
