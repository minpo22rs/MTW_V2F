import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/seller_image_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/review_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/food_detail_screen.dart';
import 'package:mtw_project/views/screens/restaurant/food_listview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectRestaurantScreen extends StatefulWidget {
  final String rating;
  final String id, name, image, location, open, close;
  final List vouchers;
  const SelectRestaurantScreen(
      {Key? key,
      required this.rating,
      required this.id,
      required this.name,
      required this.image,
      required this.location,
      required this.open,
      required this.close,
      required this.vouchers})
      : super(key: key);

  @override
  _SelectRestaurantScreenState createState() => _SelectRestaurantScreenState(
      rating, id, name, image, location, open, close, vouchers);
}

class _SelectRestaurantScreenState extends State<SelectRestaurantScreen> {
  late String rating;
  late String id, name, image, location, open, close;
  late List vouchers;
  _SelectRestaurantScreenState(this.rating, this.id, this.name, this.image,
      this.location, this.open, this.close, this.vouchers);

  List<Sellerimg> images = <Sellerimg>[];
  var resultDataI;

  slideImage() async {
    var link = "https://mtwa.xyz/API/seller-images";
    var data = {
      'sId': '${id}',
    };
    print(data);
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataI = result;
      print(resultDataI);
      images = <Sellerimg>[];
      for (var i = 0; i < resultDataI.length; i++) {
        Sellerimg t = Sellerimg.fromJson(resultDataI[i]);
        images.add(t);
      }
    });
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'ร้านอาหาร',
          style: TextStyle(
            color: ColorResources.ICON_Black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          FutureBuilder(
            future: slideImage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return ImageSlider(
                image: images,
                pageKey: 'restaurant',
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200.sp,
                      // color: Colors.redAccent.withOpacity(0.2),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('แชร์');
                          },
                          child: Icon(
                            Icons.ios_share_outlined,
                            color: ColorResources.ICON_Gray,
                          ),
                        ),
                        LikeWidget(
                          itemId: '${id}',
                          type: 'H',
                          color: 'LG',
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: 75.sp,
                  height: 26,
                  // color: Colors.black.withOpacity(0.2),
                  child: StarWidget(
                      sizestar: '12', sId: '${id}', type: 'restaurant'),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${rating}/5.00',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 1,
                      height: 16,
                      color: Colors.black87,
                    ),
                    SizedBox(
                      width: 5,
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
                    ] else if (double.parse(rating) >= 0.01) ...[
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
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/location.svg',
                      width: 14,
                      height: 14,
                      color: ColorResources.ICON_Red,
                    ),
                    Container(
                      width: 300,
                      child: GestureDetector(
                        onTap: () {
                          launch(location);
                        },
                        child: Text(
                          'สถานที่ตั้งร้าน',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: ColorResources.KTextLightBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'เปิด ' + open + '-' + close,
                      style: TextStyle(color: ColorResources.ICON_Green),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('ดูข้อมูลร้าน');
                      },
                      child: Container(
                        width: 65.sp,
                        height: 22.sp,
                        // color: Colors.redAccent,
                        child: DecoratedBox(
                            child: Center(
                              child: Text(
                                'ดูข้อมูลร้าน',
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.cyan[600],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          FoodListView(title: name, vouchers: vouchers),
          Divider(
            thickness: 0.5,
          ),
          ReviewWidget(
            sId: id,
            type: 'R',
          ),
        ],
      ),
    );
  }
}
