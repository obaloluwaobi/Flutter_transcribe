import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcribe/authetications/createprofile.dart';
import 'package:transcribe/constant/constant.dart';

class Signup extends StatefulWidget {
  final VoidCallback showLogin;
  const Signup({super.key, required this.showLogin});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var visible = false;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  Future signup() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
    try {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmpasswordController.text.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e.toString());
      if (e.code == "email-already-in-use") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'The email address is already in use by another account.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('This email address does not exist.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "operation-not-allowed") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('this operation is not allowed',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "weak-password") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Weak Password!',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _key,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: [
              Text(
                'Sign up to Transcribe',
                style: size20,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Email Address',
                style: size16,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Please enter your email';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                    hintStyle: size16),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Password',
                style: size16,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                obscureText: !visible,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please enter your password';
                  } else if (_passwordController.text.length < 8) {
                    return 'Password length must be 8 characters or longer';
                  } else {
                    return null;
                  }
                },
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your password',
                    hintStyle: size16,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible
                            ? Icon(Icons.visibility_outlined,
                                color: Colors.grey[400])
                            : Icon(Icons.visibility_off_outlined,
                                color: Colors.grey[400]))),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Confirm Password',
                style: size16,
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                obscureText: !visible,
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmpasswordController,
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Please confirm password';
                  } else if (_confirmpasswordController.text.characters !=
                      _passwordController.text.characters) {
                    return 'Password does not match';
                  } else if (_confirmpasswordController.text.length < 8) {
                    return 'Password length must be 8 characters or longer';
                  } else {
                    return null;
                  }
                },
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm your password',
                    hintStyle: size16,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible
                            ? Icon(Icons.visibility_outlined,
                                color: Colors.grey[400])
                            : Icon(Icons.visibility_off_outlined,
                                color: Colors.grey[400]))),
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
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          signup();
                        }
                      },
                      child: Text(
                        'Register',
                        style: size16w,
                      ))),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already had an account?',
                    style: size16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: widget.showLogin,
                    child: Text(
                      'Sign in',
                      style: size16b,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
