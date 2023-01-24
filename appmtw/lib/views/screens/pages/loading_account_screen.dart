import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mtw_project/main.dart';
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
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/wallet/wallet_main.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoadingAccScreen extends StatefulWidget {
  final String pageKey, pageKey2;
  const LoadingAccScreen(
      {Key? key, required this.pageKey, required this.pageKey2})
      : super(key: key);
  @override
  _LoadingAccScreenState createState() =>
      _LoadingAccScreenState(pageKey, pageKey2);
}

class _LoadingAccScreenState extends State<LoadingAccScreen> {
  late String pageKey, pageKey2;
  _LoadingAccScreenState(this.pageKey, this.pageKey2);
  @override
  void initState() {
    super.initState();
    if (pageKey == 'wallet' || pageKey == 'walletx') {
      accountDetail();
      listpay();
    } else if (pageKey == 'in_wallet') {
      accountDetail();
    } else if (pageKey == 'account') {
      accountDetail();
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

  Future<Null> accountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    var url = "http://10.0.2.2/flutter/account-detail.php";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        var detail = jsonDecode(response.body);
        print(detail);
        print("test1111111111");

        // var numformat = NumberFormat('#,###.##').format(detail['wallet']);
        var numformat = detail['wallet'];
        print(detail);
        print(numformat);
        print("test2222222222");

        account_name = '${detail['name']}';
        account_wallet = '${numformat}';
      }
    });
  }

  List<TopUp> topups = <TopUp>[];
  var resultData;

  Future<Null> listpay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/account-list-payment";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);

        resultData = result;
        topups = <TopUp>[];
        for (var j = 0; j < resultData.length; j++) {
          TopUp d = TopUp.fromJson(resultData[j]);
          topups.add(d);
        }
      }
    });
  }

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});

    return true;
  }

  void _navigateToHome() async {
    if (pageKey == 'account') {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => AcountScreen()));
    } else if (pageKey == 'wallet') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => WalletMain(
                wallet: account_wallet,
                topups: topups,
                pageMain: pageKey,
                pageKey2: pageKey2,
              )));
    } else if (pageKey == 'walletx') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => WalletMain(
                wallet: account_wallet,
                topups: topups,
                pageMain: pageKey,
                pageKey2: pageKey2,
              )));
    } else if (pageKey == 'in_wallet') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => WalletOneScreen(
                wallet: account_wallet,
                pageKey2: pageKey2,
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
