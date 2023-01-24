import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CircleAvatarTopThreeWidget extends StatelessWidget {
  final int rating;
  final String name;
  final String province;
  final int score;
  final double raduis;

  const CircleAvatarTopThreeWidget({
    required this.rating,
    required this.name,
    required this.province,
    required this.score,
    required this.raduis,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  province,
                  style: TextStyle(fontSize: 2.5.w),
                ),
              ],
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 10.sp),
        ),
        Text(
          '$score' + ' คะแนน',
          style: TextStyle(
            fontSize: 10.5.sp,
          ),
        ),
      ],
    );
  }
}
