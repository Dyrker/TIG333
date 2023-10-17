import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighScoreMenu extends StatelessWidget {

  const HighScoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
                      image: (DecorationImage(image: AssetImage("assets/images/staticBackground.jpg"),
                      fit: BoxFit.cover))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _score("Miguel", "100"),
              _score("Elmer", "99"),
              _score("Anton", "99"),
              _score("Samuel", "99"),
              _score("Anthony", "98")
            ],
          ),
        ),
      );
  }
}

Widget _score(String name, String number) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    child: Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Text(name,
            style:GoogleFonts.pressStart2p()
            ),
            SizedBox(width: 10),
            Text(number,
            style:GoogleFonts.pressStart2p()
          )
        ],
      ),
    )
    ]
  );
}
