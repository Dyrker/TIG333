import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String ENDPOINT = "https://todoapp-api.apps.k8s.gu.se";
String apiKey = "5c737970-b8f3-44b9-8bbb-d93f96962098";

class apiUserScore {
  String? id;
  final String title;


  apiUserScore({this.id, required this.title});

  factory apiUserScore.fromJson(Map<String, dynamic> json) {
    return apiUserScore(
      id: json['id'], 
      title: json['title'] ?? 'untitled'); 
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


  void fetchScores() async {
    try {
      if (!_scoresFetched) {
        var apiScores = await getScores();
        _apiScores = apiScores;
        _scoresFetched = true;
        print('API items fetched successfully: $_apiScores');
        notifyListeners();
      }
    } catch (e) {
      // Error testing
      print('Error fetching todos: $e');
    }
  }

  Future<List<apiUserScore>> getScores() async {
    print('Testing API');
    http.Response response = await http.get(Uri.parse('$ENDPOINT/todos?key=$apiKey'));
    String body = response.body;
    print(body);
    List<dynamic> jsonResponse = jsonDecode(body);
    print("success");
    return jsonResponse.map((json) => apiUserScore.fromJson(json)).toList();
  }

  void addApiScore(String playerAndScore) async {
  await http.post(
    Uri.parse('$ENDPOINT/todos?key=$apiKey'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(apiUserScore(title: playerAndScore).toJson()),
  );
  _scoresFetched = false;
  notifyListeners();
}

  apiUserScore convertToApiUserScore(String scoreString) {
    return apiUserScore(title: scoreString);

  }


}
