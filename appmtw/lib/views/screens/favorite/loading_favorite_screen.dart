import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mtw_project/main.dart';
import 'package:mtw_project/models/attraction_img_model.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/models/banner_main.dart';
import 'package:mtw_project/models/category_product_model.dart';
import 'package:mtw_project/models/category_restaurant.dart';
import 'package:mtw_project/models/fav_attraction_model.dart';
import 'package:mtw_project/models/fav_hotel_model.dart';
import 'package:mtw_project/models/fav_product_model.dart';
import 'package:mtw_project/models/fav_restaurant_model.dart';
import 'package:mtw_project/models/hotel_model.dart';
import 'package:mtw_project/models/product_reccomment_model.dart';
import 'package:mtw_project/models/rating_line_one.dart';
import 'package:mtw_project/models/rating_line_two.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/models/rating_two_model.dart';
import 'package:mtw_project/models/restaurant_model.dart';
import 'package:mtw_project/models/top_up_model.dart';
import 'package:mtw_project/views/screens/attractions/attractions_detail_screen.dart';
import 'package:mtw_project/views/screens/attractions/attractions_screen.dart';
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_screen.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/wallet/wallet_main.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoadingFavScreen extends StatefulWidget {
  final String pageKey, productKey;
  const LoadingFavScreen(
      {Key? key, required this.pageKey, required this.productKey})
      : super(key: key);
  @override
  _LoadingFavScreenState createState() =>
      _LoadingFavScreenState(pageKey, productKey);
}

class _LoadingFavScreenState extends State<LoadingFavScreen> {
  late String pageKey, productKey;
  _LoadingFavScreenState(this.pageKey, this.productKey);
  @override
  void initState() {
    super.initState();

    _mockcheckforSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  List<ProductFav> productFav = <ProductFav>[];
  List<RestaurantFav> restaurantFav = <RestaurantFav>[];
  List<HotelFav> hotelFav = <HotelFav>[];
  List<AttractionFav> attractionFav = <AttractionFav>[];
  var resultDataP, resultDataR, resultDataH, resultDataA;

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});

    return true;
  }

  void _navigateToHome() async {
    await Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => FavoriteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Colors.black),
          ),
          new Container(
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      '   loading....',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
