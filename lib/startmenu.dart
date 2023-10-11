import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Startmenu extends StatelessWidget {
  final VoidCallback onPlayButtonPressed; // Callback for the button press

  Startmenu({required this.onPlayButtonPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Homepage'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello, Flutter!',
                style: GoogleFonts.pressStart2p()),
              
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPlayButtonPressed, // Call the callback here
                child: Text('Play Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
