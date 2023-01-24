import 'package:flutter/material.dart';
import 'package:mtw_project/utill/images.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg.png',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
