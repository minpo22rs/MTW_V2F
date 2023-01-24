import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircleAvatarWidget extends StatelessWidget {
  final int rating;
  final String name;
  final String province;
  final int score;
  final double raduis;

  const CircleAvatarWidget({
    required this.name,
    required this.score,
    required this.raduis,
    required this.rating,
    required this.province,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
      child: Column(
        children: [
          CircleAvatar(
            radius: raduis,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'อันดับที่ ' + '$rating',
                    style: TextStyle(fontSize: 6.5.sp),
                  ),
                  Text(
                    province,
                    style: TextStyle(fontSize: 5.5.sp),
                  ),
                ],
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 6.5.sp),
          ),
          Text(
            '$score' + ' คะแนน',
            style: TextStyle(
              fontSize: 7.sp,
            ),
          ),
        ],
      ),
    );
  }
}
