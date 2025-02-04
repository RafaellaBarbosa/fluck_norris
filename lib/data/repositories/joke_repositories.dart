import 'dart:convert';

import 'package:fluck_norris/data/models/jokes.dart';
import 'package:http/http.dart' as http;

class JokeRepositories {
  final String url = 'api.chucknorris.io';

  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.https(url, 'jokes/categories'));

      final decoded = jsonDecode(response.body) as List;

      return List.generate(
        decoded.length,
        (index) => decoded[index],
      );
    } on Exception {
      rethrow;
    }
  }

  Future<JokeModel> getJokesByCategory(String category) async {
    try {
      final response = await http
          .get(Uri.https(url, 'jokes/random', {'category': category}));

      final decoded = jsonDecode(response.body);
      final joke = JokeModel.fromJson(decoded);
      return joke;
    } on Exception {
      rethrow;
    }
  }
}
