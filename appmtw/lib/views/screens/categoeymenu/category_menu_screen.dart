import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/categoeymenu/widgets/category_menu.dart';

class CategoryMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: CategoryMenuWidget(),
    );
  }
}
