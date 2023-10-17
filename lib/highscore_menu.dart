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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _score("Hello world", "100")
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
            style: TextStyle(fontSize: 15),
            ),
            SizedBox(width: 10),
            Text(number,
            style: TextStyle(fontSize: 15)
          )
        ],
      ),
    )
    ]
  );
}
