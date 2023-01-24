import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mtw_project/main.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/models/banner_main.dart';
import 'package:mtw_project/models/category_product_model.dart';
import 'package:mtw_project/models/category_restaurant.dart';
import 'package:mtw_project/models/hotel_model.dart';
import 'package:mtw_project/models/member_model.dart';
import 'package:mtw_project/models/product_reccomment_model.dart';
import 'package:mtw_project/models/rating_line_one.dart';
import 'package:mtw_project/models/rating_line_two.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/models/rating_two_model.dart';
import 'package:mtw_project/models/restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/vote/vote_central_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen2 extends StatefulWidget {
  final String region, region2, wallet, pageKey, pageKey2;
  const LoadingScreen2(
      {Key? ker,
      required this.region,
      required this.region2,
      required this.wallet,
      required this.pageKey,
      required this.pageKey2});
  @override
  _LoadingScreen2State createState() =>
      _LoadingScreen2State(region, region2, wallet, pageKey, pageKey2);
}

class _LoadingScreen2State extends State<LoadingScreen2> {
  late String region, region2, wallet, pageKey, pageKey2;
  _LoadingScreen2State(
      this.region, this.region2, this.wallet, this.pageKey, this.pageKey2);
  @override
  void initState() {
    super.initState();
    if (pageKey == 'central') {
      indexmain();
      memberList();
    }

    _mockcheckforSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  var account_name;
  var account_wallet;

  List<Member> mem = <Member>[];
  var resultMem;

  Future<Null> memberList() async {
    var link = "https://mtwa.xyz/API/contestant-regions-member";
    var data = {
      'keyword': region2,
    };
    await http.post(Uri.parse(link), body: data).then((response) {
      print(region2);
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultMem = result1;
      mem = <Member>[];
      print('Length ====== ${resultMem.length}');
      for (var j = 0; j < resultMem.length; j++) {
        Member d = Member.fromJson(resultMem[j]);
        mem.add(d);
      }
    });
  }

  Future<Null> indexmain() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    var url = "https://mtwa.xyz/API/index-main";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((response) {
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultData = result1['bannermain'];
      main = <Main>[];
      resultData2 = result1['top1'];
      onecon = <RatingOne>[];
      resultData3 = result1['top3'];
      twocon = <RatingTwo>[];
      resultData4 = result1['top9'];
      onelinecon = <RatingLineone>[];
      resultData5 = result1['top15'];
      twolinecon = <RatingLineTwo>[];
      bannersub = result1['banners']['photo'];
      bannerfooter = result1['bannerf']['photo'];
      resultRestaurant = result1['restaurant'];
      restaurants = <Restaurant>[];
      resultProduct = result1['product'];
      products = <ProductRec>[];
      resultHotel = result1['hotel'];
      hotels = <Hotel>[];
      resultAttraction = result1['location'];
      attractions = <Attraction>[];
      account_name = '${result1['account']['name']}';
      account_wallet = '${result1['account']['wallet']}';
      resultDatacate = result1['cate_p'];
      cate = <CategoryProduct>[];
      resultDatacater = result1['cate_r'];
      cater = <CategoryRestaurant>[];

      print('Length ====== ${resultData2.length}');
      for (var i = 0; i < resultData.length; i++) {
        Main t = Main.fromJson(resultData[i]);
        main.add(t);
      }
      for (var j = 0; j < resultData2.length; j++) {
        RatingOne d = RatingOne.fromJson(resultData2[j]);
        onecon.add(d);
      }
      for (var i = 0; i < resultData3.length; i++) {
        RatingTwo d = RatingTwo.fromJson(resultData3[i]);
        twocon.add(d);
      }
      for (var k = 0; k < resultData4.length; k++) {
        RatingLineone d = RatingLineone.fromJson(resultData4[k]);
        onelinecon.add(d);
      }
      for (var z = 0; z < resultData5.length; z++) {
        RatingLineTwo d = RatingLineTwo.fromJson(resultData5[z]);
        twolinecon.add(d);
      }
      for (var j = 0; j < resultRestaurant.length; j++) {
        Restaurant d = Restaurant.fromJson(resultRestaurant[j]);
        restaurants.add(d);
      }
      for (var j = 0; j < resultProduct.length; j++) {
        ProductRec d = ProductRec.fromJson(resultProduct[j]);
        products.add(d);
      }
      for (var j = 0; j < resultHotel.length; j++) {
        Hotel d = Hotel.fromJson(resultHotel[j]);
        hotels.add(d);
      }
      for (var j = 0; j < resultAttraction.length; j++) {
        Attraction d = Attraction.fromJson(resultAttraction[j]);
        attractions.add(d);
      }
      for (var i = 0; i < resultDatacate.length; i++) {
        CategoryProduct t = CategoryProduct.fromJson(resultDatacate[i]);
        cate.add(t);
      }
      for (var i = 0; i < resultDatacater.length; i++) {
        CategoryRestaurant t = CategoryRestaurant.fromJson(resultDatacater[i]);
        cater.add(t);
      }
    });
  }

  late String bannersub, bannerfooter;
  List<Main> main = <Main>[];
  var resultData;
  bool statusData = false;

  List<RatingOne> onecon = <RatingOne>[];
  var resultData2;

  List<RatingTwo> twocon = <RatingTwo>[];
  var resultData3;

  List<RatingLineone> onelinecon = <RatingLineone>[];
  var resultData4;

  List<RatingLineTwo> twolinecon = <RatingLineTwo>[];
  var resultData5;

  List<Restaurant> restaurants = <Restaurant>[];
  var resultRestaurant;

  List<ProductRec> products = <ProductRec>[];
  var resultProduct;

  List<Hotel> hotels = <Hotel>[];
  var resultHotel;

  List<Attraction> attractions = <Attraction>[];
  var resultAttraction;

  List<CategoryProduct> cate = <CategoryProduct>[];
  var resultDatacate;

  List<CategoryRestaurant> cater = <CategoryRestaurant>[];
  var resultDatacater;

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 1000), () {});

    return true;
  }

  void _navigateToHome() async {
    if (pageKey == 'central') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => VoteCentralScreen(
                region: region,
                region2: region2,
                wallet: account_wallet,
                pageKey: pageKey2,
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
