import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/data/user_data.dart';

class UserDetailPage extends StatelessWidget {
  final User user;
  const UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: ListView(
        children: [
          Image.network(
            user.imageUrl,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
