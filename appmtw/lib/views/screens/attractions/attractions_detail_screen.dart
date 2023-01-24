import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/floatingbutton.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/review_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/products/similar_producr.dart';
import 'package:mtw_project/views/screens/review/product_review.dart';
import 'package:mtw_project/views/screens/score/score_one.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class AttractionDetailScreen extends StatefulWidget {
  final String id, p_name, detail, rating, written;
  final List images;
  const AttractionDetailScreen({
    Key? key,
    required this.id,
    required this.p_name,
    required this.detail,
    required this.images,
    required this.rating,
    required this.written,
  }) : super(key: key);

  @override
  _AttractionDetailScreenState createState() =>
      _AttractionDetailScreenState(id, p_name, detail, images, rating, written);
}

class _AttractionDetailScreenState extends State<AttractionDetailScreen> {
  late String id, p_name, detail, rating, written;
  late List images;
  _AttractionDetailScreenState(this.id, this.p_name, this.detail, this.images,
      this.rating, this.written);

  int qty = 1;
  bool _favorite = false;

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
          _favorite = true;
        });
        Fluttertoast.showToast(
            msg: "เพิ่มในรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      } else if (result['status_wishlist'] == 'SD') {
        setState(() {
          _favorite = false;
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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          p_name,
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          ImageSlider(
            image: images,
            pageKey: 'attraction',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 20),
                child: Container(
                  width: 190.sp,
                  // color: Colors.redAccent.withOpacity(0.2),
                  child: Text(
                    widget.p_name,
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('แชร์');
                      },
                      child: Icon(
                        Icons.ios_share_rounded,
                        color: ColorResources.ICON_Gray,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    LikeWidget(
                      itemId: '${id}',
                      type: 'A',
                      color: 'LG',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(rating + '/5.00'),
                    SizedBox(
                      width: 10,
                    ),
                    if (double.parse(rating) >= 4.5) ...[
                      Text(
                        'ดีมาก',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorResources.ICON_Green,
                        ),
                      ),
                    ] else if (double.parse(rating) >= 4.00) ...[
                      Text(
                        'ดี',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorResources.ICON_Green,
                        ),
                      ),
                    ] else if (double.parse(rating) >= 3.00) ...[
                      Text(
                        'ปานกลาง',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorResources.ICON_Yellow,
                        ),
                      ),
                    ] else if (double.parse(rating) >= 2.00) ...[
                      Text(
                        'น้อย',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.orange,
                        ),
                      ),
                    ] else if (double.parse(rating) > 0) ...[
                      Text(
                        'ควรปรับปรุง',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorResources.ICON_Red,
                        ),
                      ),
                    ] else if (double.parse(rating) < 0.01) ...[
                      Text(
                        'ยังไม่มีการรีวิว',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: ColorResources.ICON_Red,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 15, top: 0, bottom: 20),
                  child: StarWidget(
                    sizestar: '10',
                    sId: '${id}',
                    type: 'attrac',
                  )),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 1, top: 5, bottom: 5),
                child: Container(
                  width: 190.sp,
                  // color: Colors.redAccent.withOpacity(0.2),
                  child: Text(
                    'คำอธิบายสถานที่',
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                child: Container(
                  width: double.infinity,
                  child: Text(detail),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (written != '') ...[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  child: Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('เขียนโดย ' + written),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
              Divider(
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 8, top: 8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ScoreOne(
                          sId: '${id}',
                          type: 'A',
                        ),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'รีวิวสถานที่ท่องเที่ยว',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
            ],
          ),
          ReviewWidget(sId: '${id}', type: 'A')
        ],
      ),
    );
  }
}
