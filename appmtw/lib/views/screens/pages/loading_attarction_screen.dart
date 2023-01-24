import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mtw_project/main.dart';
import 'package:mtw_project/models/attraction_img_model.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/models/banner_main.dart';
import 'package:mtw_project/models/category_product_model.dart';
import 'package:mtw_project/models/category_restaurant.dart';
import 'package:mtw_project/models/hotel_model.dart';
import 'package:mtw_project/models/product_reccomment_model.dart';
import 'package:mtw_project/models/rating_line_one.dart';
import 'package:mtw_project/models/rating_line_two.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/models/rating_two_model.dart';
import 'package:mtw_project/models/restaurant_model.dart';
import 'package:mtw_project/models/top_up_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/attractions/attractions_detail_screen.dart';
import 'package:mtw_project/views/screens/attractions/attractions_screen.dart';
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/wallet/wallet_main.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoadingAttractionScreen extends StatefulWidget {
  final String pageKey, productKey;
  const LoadingAttractionScreen(
      {Key? key, required this.pageKey, required this.productKey})
      : super(key: key);
  @override
  _LoadingAttractionScreenState createState() =>
      _LoadingAttractionScreenState(pageKey, productKey);
}

class _LoadingAttractionScreenState extends State<LoadingAttractionScreen> {
  late String pageKey, productKey;
  _LoadingAttractionScreenState(this.pageKey, this.productKey);
  @override
  void initState() {
    super.initState();
    if (pageKey == 'screen') {
      attractionpage();
    } else if (pageKey == 'detail') {
      attracDetail();
    }
  }

  List<Attraction> attraction = <Attraction>[];
  var resultAttraction;

  late String bannersub;

  Future<Null> attractionpage() async {
    var url = "https://mtwa.xyz/API/attraction-page";
    await http.get(Uri.parse(url)).then((response) async {
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      bannersub = result1['banners']['photo'];
      resultAttraction = result1['location'];
      attraction = <Attraction>[];

      for (var j = 0; j < resultAttraction.length; j++) {
        Attraction d = Attraction.fromJson(resultAttraction[j]);
        attraction.add(d);
      }
      _navigateToHome();
    });
  }

  List<Attracimg> attracimg = <Attracimg>[];
  var resultData2, id, name, detail, rating, written;

  Future<Null> attracDetail() async {
    var url = "https://mtwa.xyz/API/attraction-detail-product-page";
    var data = {'attracId': '${productKey}'};
    await http.post(Uri.parse(url), body: data).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        resultData2 = result['attractionimg'];
        attracimg = <Attracimg>[];
        for (var i = 0; i < resultData2.length; i++) {
          Attracimg t = Attracimg.fromJson(resultData2[i]);
          attracimg.add(t);
        }
        print(result);
        id = result['attraction']['id'];
        name = result['attraction']['name'];
        detail = result['attraction']['detail'];
        rating = result['attraction']['rating'];
        if (result['attractionmiss'] != null) {
          written = result['attractionmiss']['f_name'] +
                  ' ' +
                  result['attractionmiss']['l_name'] ??
              '';
        } else {
          written = '';
        }
        _navigateToHome();
      }
    });
  }

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});

    return true;
  }

  void _navigateToHome() async {
    // print(account_name);
    // print(account_wallet);
    if (pageKey == 'screen') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => AttractionScreen(
                attractions: attraction,
                banner: '${bannersub}',
              )));
    } else if (pageKey == 'detail') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => AttractionDetailScreen(
                id: '${id}',
                p_name: '${name}',
                detail: '${detail}',
                images: attracimg,
                rating: '${rating}',
                written: '${written}',
              )));
    }
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
            child: Image.asset('assets/images/bg2.jpg', fit: BoxFit.cover),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          ColorResources.KTextPink),
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
