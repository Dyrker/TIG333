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
  List<apiUserScore> _scores = [];
  int platformCount = 0;
  List<apiUserScore> get scores => _scores;
  bool _scoresFetched = false;

  void fetchScores() async {
    try {
      if (!_scoresFetched) {
        var scores = await getScores();
        _scores = scores;
        _scoresFetched = true;
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

  
}
