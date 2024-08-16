import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/constant/constant.dart';
import 'package:transcribe/settings/about.dart';
import 'package:transcribe/settings/profile.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 60,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Settings',
          style: size20,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          Btn(
            text: 'Profile',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ViewProfile()));
            },
          ),
          Btn(
            text: 'About Project',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          Btn(
            text: 'Feedback',
            onTap: () {
              launchEmail();
            },
          ),
          Btn(
            text: 'Sign out',
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
          Btn(
              text: 'Delete Account',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete your Account?'),
                      content: const Text(
                          ''' If you select Delete we will delete your account on our server.'''),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () {
                            deleteUserAccount();
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        ],
      ),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData =
          FirebaseAuth.instance.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}

class Btn extends StatelessWidget {
  const Btn({super.key, required this.text, required this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.grey[300],
      child: ListTile(
        onTap: onTap,
        title: Text(text),
        trailing: Transform.rotate(
            angle: pi,
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            )),
      ),
    );
  }
}
