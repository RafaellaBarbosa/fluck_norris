import 'dart:convert';

import 'package:http/http.dart' as http;

class JokeRepositories {
  Future<List<String>> getCategories() async {
    final response = await http
        .get(Uri.parse('https://api.chucknorris.io/jokes/categories'));

    final decoded = jsonDecode(response.body) as List;

    return List.generate(
      decoded.length,
      (index) => decoded[index],
    );
  }
}
