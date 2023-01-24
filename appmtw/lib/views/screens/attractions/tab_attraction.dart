import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/attractions/all_attraction.dart';
import 'package:mtw_project/views/screens/attractions/member_attraction.dart';
import 'package:mtw_project/views/screens/favorite/farvorite_product_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_attraction_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_hotel_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_restaurant_screen.dart';

class TacAttracScreen extends StatefulWidget {
  const TacAttracScreen({
    Key? key,
  }) : super(key: key);
  @override
  _TacAttracScreenState createState() => _TacAttracScreenState();
}

class _TacAttracScreenState extends State<TacAttracScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'ทั้งหมด',
                ),
                Tab(
                  text: 'นางงาม',
                ),
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              'สถานที่ท่องเที่ยว',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              AllAttracScreen(),
              MemAttracScreen(),
            ],
          ),
        ));
  }
}
