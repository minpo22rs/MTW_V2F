import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';

class LikeWidget extends StatefulWidget {
  final String itemId, type, color;
  LikeWidget(
      {Key? key, required this.itemId, required this.type, required this.color})
      : super(key: key);
  @override
  _LikeWidgetState createState() => _LikeWidgetState(itemId, type, color);
}

class _LikeWidgetState extends State<LikeWidget> {
  late String itemId, type, color;
  _LikeWidgetState(this.itemId, this.type, this.color);
  var resultDataL;
  checkLikeItem() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var link = "https://mtwa.xyz/API/check-wishlists";
    var data = {'uId': userId, 'iId': '${itemId}', 'type': type};
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataL = result;
    });
    return resultDataL;
  }

  Future<Null> add_wishlists(var wishlist_id, var type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/add-wishlists";
    var data = {
      'userid': '${userId}',
      'wishlist_id': '${wishlist_id}',
      'type': '${type}'
    };
    await http.post(Uri.parse(url), body: data).then((value) {
      var result = jsonDecode(value.body);
      if (result['status_wishlist'] == 'S') {
        setState(() {
          resultDataL = resultDataL!;
        });
        Fluttertoast.showToast(
            msg: "เพิ่มในรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      } else if (result['status_wishlist'] == 'SD') {
        setState(() {
          resultDataL = resultDataL!;
        });
        Fluttertoast.showToast(
            msg: "ลบออกจากรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLikeItem(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Center(
              child: Container(
                width: 10,
                height: 10,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: (resultDataL['check'] == '2')
                ? (color == 'W')
                    ? Colors.white
                    : ColorResources.ICON_Light_Gray
                : ColorResources.ICON_Red,
            size: 15.sp,
          ),
          onPressed: () {
            add_wishlists(itemId, type);
          },
        );
      },
    );
  }
}
