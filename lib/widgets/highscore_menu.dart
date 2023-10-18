import 'package:flutter/material.dart';
import 'package:flutter_flame/test_adventure.dart';
import 'package:google_fonts/google_fonts.dart';

class HighScoreMenu extends StatelessWidget {
  final TestAdventure game;

  const HighScoreMenu({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final platformCount = game.getPlatformCount();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: (DecorationImage(
                image: AssetImage("assets/images/staticBackground.jpg"), fit: BoxFit.cover))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _score("Miguel", platformCount),
            _score("Elmer", platformCount),
            _score("Anton", platformCount),
            _score("Samuel", platformCount),
            _score("Anthony", platformCount)
          ],
        ),
      ),
    );
  }
}

Widget _score(String name, int? platformCount) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: GoogleFonts.pressStart2p()),
          SizedBox(width: 10),
          Text(
            "Score: $platformCount",
            style: GoogleFonts.pressStart2p(),
          )
        ],
      ),
    )
  ]);
}
