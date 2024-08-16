import 'package:flutter/material.dart';
import 'package:transcribe/constant/constant.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          'About Project',
          style: size20,
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[900],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Akinode Khalid Olamide',
                  style: size20w,
                  textAlign: TextAlign.start,
                ),
                Text(
                  'EDUC2002031',
                  style: size20w,
                ),
                Text(
                  'Computer science ',
                  style: size20w,
                ),
                Text(
                  'Olabisi Onabanjo University',
                  style: size20w,
                ),
                Text(
                  '09035348933',
                  style: size20w,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[900],
            ),
            child: Text(
              'The primary aim of this study is to develop a speech-to-text software application designed to improve the academic and social experiences of students with hearing impairments. This application seeks to bridge the communication gap in educational settings by converting spoken language into written text in real-time, thereby facilitating better comprehension and participation in classroom activities',
              style: size20w,
            ),
          ),
        ],
      ),
    );
  }
}
