import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:transcribe/constant/constant.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final _key = GlobalKey<FormState>();

  final nameController = TextEditingController();

  final _departmentController = TextEditingController();

  final _phoneController = TextEditingController();

  final _matricController = TextEditingController();
  File? photo;

  final ImagePicker picker = ImagePicker();
  Future imgPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        //   avatarUrl = null;
      } else {
        print('No image selected');
      }
    });
  }

  bool isLoading = false;
  Future _createProfile() async {
    setState(() {
      isLoading = true;
    });
    try {
      if (nameController.text.isNotEmpty &&
          _departmentController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _matricController.text.isNotEmpty) {
        final User? _user = FirebaseAuth.instance.currentUser;

        final String _uid = _user!.uid;
        String? downloadURL;
        if (photo != null) {
          final fileName = basename(photo!.path);
          final destination = 'files/$fileName';

          UploadTask uploadTask = FirebaseStorage.instance
              .ref(destination)
              .child('profile$_uid/')
              .putFile(photo!);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          downloadURL = await taskSnapshot.ref.getDownloadURL();

          print(downloadURL);
        }

        await FirebaseFirestore.instance.collection('users').doc(_uid).set({
          // 'url': imageUrl,
          'email': _user.email,
          'lastName': nameController.text.trim(),
          'phoneNumber': _phoneController.text.trim(),
          'matricNum': _matricController.text.trim(),
          'department': _departmentController.text.trim(),
          if (downloadURL != null) 'url': downloadURL.toString(),
        });
      }
    } on FirebaseException catch (e) {
      print('empty field');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  imgPick();
                },
                child: photo != null //|| avatarUrl != null
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(photo!),
                                // photo != null
                                //     ? FileImage(photo!) as ImageProvider
                                //     : AssetImage(avatarUrl!),
                                fit: BoxFit.fitWidth)),
                        // child: Image.file(
                        //   photo!,
                        //   fit: BoxFit.cover,
                        // )
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.person,
                              size: 130,
                            ),
                          ),
                          const Positioned(
                            top: 90,
                            left: 130,
                            right: 0,
                            bottom: 10,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                    hintStyle: size16),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintStyle: size16),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _matricController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Matric Number.',
                    hintStyle: size16),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _departmentController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Department',
                    hintStyle: size16),
              ),
              SizedBox(
                height: 70,
              ),
              SizedBox(
                  height: 60,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: isLoading
                          ? null
                          : () {
                              _createProfile();
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Create Profile',
                              style: size20w,
                            ))),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
