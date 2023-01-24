import 'package:faker/faker.dart';

class User {
  final String name;
  final String imageUrl;

  const User({
    required this.name,
    required this.imageUrl,
  });
}

class UserData {
  static final faker = Faker();
  static final List<User> users = List.generate(
    30,
    (index) => User(
        name: faker.person.name(),
        imageUrl: 'https://source.unsplash.com/random?user+face&sig=$index'),
  );

  static List<User> getSuggestion(String query) => List.of(users).where((user) {
        final nameLower = user.name.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
}
