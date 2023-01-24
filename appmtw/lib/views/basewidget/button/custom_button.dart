import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String buttonText;
  final double size;

  CustomButton({
    required this.onTap,
    required this.buttonText,
    required this.size,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: Colors.cyanAccent[700],
        padding: EdgeInsets.all(0),
      ),
      child: Container(
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
