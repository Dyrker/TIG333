import 'package:flutter/material.dart';

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
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPlayButtonPressed, // Call the callback here
                child: Text('Click Me'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
