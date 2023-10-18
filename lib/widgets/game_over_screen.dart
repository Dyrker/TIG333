import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreenOverlay extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/images/staticBackground.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)
                    ), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black), // Customize the focus color here.
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    hintText: 'Type in your name if you want to register your score',
                  ),
                  style: TextStyle(color: Colors.black)),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Send score', style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    Navigator.of(context).pop(); }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Back to main menu', style: GoogleFonts.pressStart2p()),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
