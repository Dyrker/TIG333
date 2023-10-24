import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame/state_and_api/character_manager.dart';
import 'package:flutter_flame/state_and_api/scores_manager.dart';
import 'package:provider/provider.dart';
import 'test_adventure.dart';
import 'widgets/startmenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'state_and_api/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.signInAnonymously();
  Flame.device.fullScreen();
  Flame.device.setPortrait();

  final TestAdventure game = TestAdventure();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CharacterManager()),
      ChangeNotifierProvider(create: (_) => ScoresManager()),
    ],
    child: MyApp(game: game),
  ));
}

class MyApp extends StatelessWidget {
  final TestAdventure game;
  MyApp({required this.game});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Startmenu(
            onPlayButtonPressed: () {
              startGame(context, game);
            },
            game: game,
          );
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

void startGame(BuildContext context, TestAdventure game) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) {
        return GameScreen(game: game);
      },
    ),
  );
}

class GameScreen extends StatelessWidget {
  final TestAdventure game;

  GameScreen({required this.game});

  @override
  Widget build(BuildContext context) {
    game.gameScreenContext = context;
    return Scaffold(
      body: GameWidget(game: game),
      // floatingActionButton: BackToStartMenuButton(),
    );
  }
}

/*
class BackToStartMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        TestAdventure.level.restartGame();
      },
      child: Icon(Icons.arrow_back),
    );
  }
}
*/
