import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String ENDPOINT = "https://todoapp-api.apps.k8s.gu.se";
String apiKey = "4b4bbd3e-63c0-4e6a-bb40-2aa65ea125a1";

class apiUserScore {
  String? id;
  final String title;

  apiUserScore({this.id, required this.title});

  factory apiUserScore.fromJson(Map<String, dynamic> json) {
    return apiUserScore(id: json['id'], title: json['title'] ?? 'untitled');
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      "title": title,
    };
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}

class ApiUserScore extends ChangeNotifier {
  List<apiUserScore> _apiScores = [];
  int platformCount = 0;
  List<apiUserScore> get apiScores => _apiScores;
  bool _scoresFetched = false;

  Future<void> fetchScores() async {
    try {
      _scoresFetched = false; // Reset the flag to force fetching again
      if (!_scoresFetched) {
        var apiScores = await getScores();
        _apiScores = apiScores;
        _scoresFetched = true;
        print('API items fetched successfully: $_apiScores');
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching todos: $e');
    }
  }

  Future<List<apiUserScore>> getScores() async {
    print('Testing API');
    http.Response response =
        await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));
    String body = response.body;
    print(body);
    List<dynamic> jsonResponse = jsonDecode(body);
    print("success");

    List<apiUserScore> sortedScores =
        jsonResponse.map((json) => apiUserScore.fromJson(json)).toList();
    sortedScores.sort((a, b) {
      final scoreA = int.tryParse(a.title.split(' ')[1]) ?? 0;
      final scoreB = int.tryParse(b.title.split(' ')[1]) ?? 0;
      return scoreB.compareTo(scoreA);
    });

    _apiScores = sortedScores;

    return sortedScores;
  }

  void addApiScore(String playerName, int score) async {
    final playerAndScore = '$playerName $score';
    await http.post(
      Uri.parse('$ENDPOINT/todos?key=$apiKey'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(apiUserScore(title: playerAndScore).toJson()),
    );
    await fetchScores();
    if (_apiScores.length > 10) {
      final id = _apiScores.last.id;
      await http.delete(
        Uri.parse('$ENDPOINT/todos/$id?key=$apiKey'),
        headers: {
            'Content-Type': 'application/json',
          },
      );
      await fetchScores();
    }

    _scoresFetched = false;
    notifyListeners();
  }

  Future<void> removeApiScoresBelowTop() async {
    final int topN = 10; // Change this value as needed for the top scores you want to keep
    _apiScores.sort((a, b) {
      final scoreA = int.tryParse(a.title.split(' ')[1]) ?? 0;
      final scoreB = int.tryParse(b.title.split(' ')[1]) ?? 0;
      return scoreB.compareTo(scoreA);
    });

    if (_apiScores.length > topN) {
      // Delete scores beyond the top of the leaderboard
      for (int i = topN; i < _apiScores.length; i++) {
        final id = _apiScores[i].id;
        await http.delete(
          Uri.parse('$ENDPOINT/todos/$id?key=$apiKey'),
          headers: {
            'Content-Type': 'application/json',
          },
        );
      }
      _apiScores.removeRange(topN, _apiScores.length);
    }
    notifyListeners();
  }

  apiUserScore convertToApiUserScore(String scoreString) {
    return apiUserScore(title: scoreString);
  }
}
