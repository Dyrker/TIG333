import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttons {
  static Widget retroElevatedButton({
    required VoidCallback onPressed,
    required String label,
    double fontSize = 16.0,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: retroElevatedButtonStyle(),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          label,
          style: GoogleFonts.pressStart2p(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }

  // Style used for the button above
  static ButtonStyle retroElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 91, 157, 185),
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }
}
