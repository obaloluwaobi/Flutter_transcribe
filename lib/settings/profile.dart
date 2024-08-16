import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcribe/constant/constant.dart';

class ViewProfile extends StatefulWidget {
  const ViewProfile({super.key});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  final User? _user = FirebaseAuth.instance.currentUser;
  final viewText = size20;
  final labelText = size20;

  @override
  Widget build(BuildContext context) {
    final String _uid = _user!.uid;
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
          centerTitle: true,
          title: Text(
            'Profile',
            style: GoogleFonts.poppins(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(_uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                Map<String, dynamic> userData =
                    snapshot.data!.data() as Map<String, dynamic>;
                String firstName = userData['firstName'] ?? 'User';
                String lastName = userData['lastName'] ?? '';
                String email = userData['email'] ?? 'No email';
                String phoneNo = userData['phoneNumber'] ?? 'User';
                String matricNo = userData['matricNum'] ?? '';
                String department = userData['department'] ?? '';
                String? profile = userData['url'] as String?;
                // String firstName = snapshot.data?.get('firstName') ?? 'User';
                // String lastName = snapshot.data?.get('lastName') ?? 'User';
                // String email = snapshot.data?.get('email') ?? 'User';
                // String phoneNo = snapshot.data?.get('phoneNumber') ?? 'User';
                // String matricNo = snapshot.data?.get('matricNum') ?? 'User';
                // String department = snapshot.data?.get('department') ?? 'User';

                return Center(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          image: profile != null
                              ? DecorationImage(
                                  image: NetworkImage(profile),
                                  fit: BoxFit.cover)
                              : null,
                        ),
                        child: profile == null
                            ? Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey[300],
                              )
                            : null,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'full name',
                        style: labelText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          lastName,
                          style: viewText,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'phone number',
                        style: labelText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          ' $phoneNo',
                          style: viewText,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'email address',
                        style: labelText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          email,
                          style: viewText,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'matric number',
                        style: labelText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          matricNo,
                          style: viewText,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Department',
                        style: labelText,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Text(
                          department,
                          style: viewText,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
