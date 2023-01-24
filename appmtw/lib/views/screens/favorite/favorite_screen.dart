import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/favorite/farvorite_product_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_attraction_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_hotel_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_restaurant_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              isScrollable: true,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  text: 'ร้านอาหาร',
                ),
                Tab(
                  text: 'โรงแรม',
                ),
                // Tab(
                //   text: 'สินค้า',
                // ),
                Tab(
                  text: 'สถานที่ท่องเที่ยว',
                )
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
              'สิ่งที่ถูกใจ',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              FavResScreen(),
              FavHotelScreen(),
              // FavProScreen(),
              FavAttracScreen(),
            ],
          ),
        ));
  }
}
