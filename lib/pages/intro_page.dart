import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_page.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = 40;
    double width = 40;
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Image.asset(
              "assets/quote.png",
              height: height,
              width: width,
            ),
            SizedBox(
              height: 50,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(fontSize: 50, color: Colors.black),
                ),
                children: [
                  TextSpan(text: "Get\n"),
                  TextSpan(
                      text: "Inspired",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the desired text color
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Set the desired background color
                ),
                child: Text('Next'),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
