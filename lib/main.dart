import 'package:flame/flame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flutter_flame/state_and_api/scores_provider.dart';
import 'package:provider/provider.dart';
import 'test_adventure.dart';
import 'widgets/startmenu.dart';
import 'state_and_api/scores_api.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setPortrait();

  final TestAdventure game = kDebugMode ? TestAdventure() : TestAdventure();

  final ApiUserScore apiUserScore = ApiUserScore();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScoresProvider()), // Use ScoresProvider
        ChangeNotifierProvider.value(value: apiUserScore), // Use ScoresProviderNew
      ],
      
      child: MyApp(game: game),
    ) 
  );
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
      ), debugShowCheckedModeBanner: false, 
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
      floatingActionButton: BackToStartMenuButton(),
    );
  }
}

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
