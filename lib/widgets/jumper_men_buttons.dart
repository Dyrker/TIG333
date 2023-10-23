import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonStyles {
  static ButtonStyle retroElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(186, 229, 248, 1),
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(0),
      ),
    );
  }

  static Widget retroElevatedButton({
    required VoidCallback onPressed,
    required String label,
    double fontSize = 16.0,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: retroElevatedButtonStyle(),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
        ),
        padding: EdgeInsets.all(10),
        child: Text(
          label,
          style: GoogleFonts.pressStart2p(
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}