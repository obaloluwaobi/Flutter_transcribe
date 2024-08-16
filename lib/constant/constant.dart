import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

TextStyle size16 = GoogleFonts.poppins(fontSize: 16, color: Colors.black);
TextStyle size20 = GoogleFonts.poppins(fontSize: 20, color: Colors.black);
TextStyle size20w = GoogleFonts.poppins(fontSize: 20, color: Colors.white);
TextStyle size16w = GoogleFonts.poppins(fontSize: 16, color: Colors.white);
TextStyle size20b = GoogleFonts.poppins(fontSize: 20, color: Colors.blue);
TextStyle size16b = GoogleFonts.poppins(fontSize: 16, color: Colors.blue);

Future<void> launchEmail() async {
  // ios specification
  final String subject = "Subject:";
  final String stringText = "Some Message:";
  String uri =
      'mailto:hubstech0@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(stringText)}';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    print("No email client found");
  }
}
