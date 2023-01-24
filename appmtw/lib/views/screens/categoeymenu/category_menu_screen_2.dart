import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/categoeymenu/widgets/category_menu_2.dart';

class CategoryMenuScreen2 extends StatelessWidget {
  final List restaurants, categoryrestaurants;
  final String bannersub;
  CategoryMenuScreen2(
      {Key? key,
      required this.restaurants,
      required this.categoryrestaurants,
      required this.bannersub})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: CategoryMenuWidget2(
          restaurants: restaurants,
          categoryrestaurants: categoryrestaurants,
          bannersub: bannersub),
    );
  }
}
