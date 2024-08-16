import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcribe/authetications/forgetpass.dart';
import 'package:transcribe/authetications/signup.dart';
import 'package:transcribe/constant/constant.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegister;
  const Login({super.key, required this.showRegister});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visible = false;
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Future login() async {
    try {
      load();
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e.toString());
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('invalid-email',
                    style: GoogleFonts.poppins(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-disabled") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-disabled',
                    style: GoogleFonts.poppins(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-not-found") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-not-found',
                    style: GoogleFonts.poppins(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-credential") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('wrong-password',
                    style: GoogleFonts.poppins(fontSize: 16)),
              );
            });
        print(e.message);
      }
    }
  }

  Future<dynamic> load() {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        });
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
                'Welcome to Transcribe',
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
                controller: _emailController,
                style: size16,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email',
                    hintStyle: size16,
                    suffixIcon:
                        Icon(Icons.email_outlined, color: Colors.grey[400])),
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
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPasswordPage()));
                    },
                    child: Text(
                      'Reset Password',
                      style: size16b,
                    ),
                  ),
                ],
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
                          login();
                        }
                      },
                      child: Text(
                        'Login ',
                        style: size16w,
                      ))),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New to Transcribe?',
                    style: size16,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: widget.showRegister,
                    child: Text(
                      'Sign Up',
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
