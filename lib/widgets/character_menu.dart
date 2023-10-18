import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CharacterMenu extends StatelessWidget {
  const CharacterMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/staticBackground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200, // Adjust the size as needed
                    height: 200, // Adjust the size as needed
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/pinkdude.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

                    },
                    child: Text(
                      ('Please Select Character'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      ('Return to Menu (PlaceHolder)'),
                      style: GoogleFonts.pressStart2p(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
