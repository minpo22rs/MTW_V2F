import 'package:flutter/material.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:sizer/sizer.dart';

class CategoryZoneWidget extends StatelessWidget {
  final String nameProvince;
  final VoidCallback onPressed;
  final ImageProvider image;

  const CategoryZoneWidget({
    required this.nameProvince,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.sp,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          image: image,
          fit: BoxFit.fill,
        ),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            nameProvince,
            style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
