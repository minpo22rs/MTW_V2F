import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final String name;

  const User({
    required this.name,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        name: json['name'],
      );
}

class UserApi {
  static Future<List<User>> getUserSuggestion(String query) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final respones = await http.get(url);

    if (respones.statusCode == 200) {
      final List users = json.decode(respones.body);

      return users.map((json) => User.fromJson(json)).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
