import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/screens/vouchers/vouchers_restautant_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FoodDetailScreen extends StatefulWidget {
  final String title, v_id;
  const FoodDetailScreen({Key? key, required this.title, required this.v_id})
      : super(key: key);

  @override
  _FoodDetailScreenState createState() => _FoodDetailScreenState(title, v_id);
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  late String title, v_id;
  _FoodDetailScreenState(this.title, this.v_id);

  var detail;

  vouchersDetail() async {
    var url = "https://mtwa.xyz/API/vouchers-detail";
    var data = {'vouchersId': '${v_id}'};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        detail = jsonDecode(response.body);
      }
    });
    return detail;
  }

  List<Proimg> proimg = <Proimg>[];
  var resultData2;
  listImage() async {
    var url = "https://mtwa.xyz/API/restaurant-image";
    var data = {
      'resId': '${v_id}',
    };
    await http.post(Uri.parse(url), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultData2 = result;
      proimg = <Proimg>[];
      for (var i = 0; i < resultData2.length; i++) {
        Proimg t = Proimg.fromJson(resultData2[i]);
        proimg.add(t);
      }
    });
    return proimg;
  }

  int count = 0;
  bool text_to_cart = false;
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
          title,
          style: TextStyle(
            color: ColorResources.ICON_Black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            FutureBuilder(
                future: listImage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ImageSlider(
                    pageKey: 'food',
                    image: proimg,
                  );
                }),
            Container(
              child: FutureBuilder(
                future: vouchersDetail(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      height: 280.sp,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          // ImageSlider(
                          //   image: '',
                          // ),
                          SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  detail['name'],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    if (detail['unit_price'] != null) ...[
                                      Text(
                                        '฿',
                                        style: TextStyle(
                                          fontSize: 10.5.sp,
                                          color: ColorResources.KTextGray,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        NumberFormat('#,###.##')
                                            .format(detail['unit_price']),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: ColorResources.KTextGray,
                                          fontWeight: FontWeight.bold,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                    ],
                                    Text(
                                      '฿',
                                      style: TextStyle(
                                        fontSize: 10.5.sp,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      NumberFormat('#,###.##')
                                          .format(detail['purchase_price']),
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: ColorResources.KTextRed,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'เวลาที่ใช้ได้ : ' +
                                      detail['datestart'].split('-')[2] +
                                      '/' +
                                      detail['datestart'].split('-')[1] +
                                      '/' +
                                      detail['datestart'].split('-')[0] +
                                      ' ถึง ' +
                                      detail['dateend'].split('-')[2] +
                                      '/' +
                                      detail['dateend'].split('-')[1] +
                                      '/' +
                                      detail['dateend'].split('-')[0],
                                  style: TextStyle(
                                    fontSize: 9.5.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, top: 14),
                            child: Text(
                              'ใช้สิทธิ์ได้ที่...',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, top: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/shop.svg',
                                  width: 20,
                                  height: 20,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ชื่อสาขา',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'รายละเอียดที่อยู่',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Center(
                            child: GestureDetector(
                                onTap: () {
                                  print('ดูสาขาทั้งหมด');
                                },
                                child: Text(
                                  'ดูสาขาทั้งหมด',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorResources.KTextLightBlue,
                                  ),
                                )),
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                            indent: 16,
                            endIndent: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22, top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('สิ่งที่คุณจะได้รับ'),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 5.5.sp,
                                      color: Colors.black26,
                                    ),
                                    Container(
                                      width: 245.sp,
                                      child: Text(
                                        '  ' +
                                            ((detail['details'] != null)
                                                ? detail['details']
                                                : ''),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                            indent: 16,
                            endIndent: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22, top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ขั้นตอนการใช้สิทธิ์'),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 5.5.sp,
                                      color: Colors.black26,
                                    ),
                                    Text('  ' +
                                        ((detail['howto'] != null)
                                            ? detail['howto']
                                            : '')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                            indent: 16,
                            endIndent: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22, top: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ข้อกำหนดและเงื่อนไข'),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle_rounded,
                                      size: 5.5.sp,
                                      color: Colors.black26,
                                    ),
                                    Text('  ' +
                                        ((detail['term'] != null)
                                            ? detail['term']
                                            : '')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Divider(
                            thickness: 0.5,
                            color: Colors.grey,
                            indent: 16,
                            endIndent: 16,
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            // color: Colors.amberAccent,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print('remove');
                                      setState(() {
                                        if (count >= 1) {
                                          count--;
                                        }
                                        if (count == 0) {
                                          text_to_cart = false;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.remove_circle_outline_rounded,
                                      size: 38.sp,
                                    ),
                                  ),
                                  Text(
                                    '$count',
                                    style: TextStyle(
                                      fontSize: 40.sp,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      print('add');
                                      setState(() {
                                        if (count >= 0) {
                                          count++;
                                          text_to_cart = true;
                                        }
                                      });
                                    },
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 38.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 50),
                            child: GestureDetector(
                              onTap: () async {
                                if (count <= 0) {
                                  Fluttertoast.showToast(
                                    gravity: ToastGravity.CENTER,
                                    msg: 'กรุณาเลือกจำนวนก่อนค่ะ',
                                  );
                                } else {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final String? userId =
                                      prefs.getString('username');
                                  var url =
                                      "https://mtwa.xyz/API/carts-restaurant";
                                  var data = {
                                    'customer': '${userId}',
                                    'seller': '${detail['seller_id']}',
                                    'product': '${detail['id']}',
                                    'qty': '${count}',
                                    'price': '${detail['purchase_price']}',
                                    'total':
                                        '${count * detail['purchase_price']}'
                                  };
                                  await http
                                      .post(Uri.parse(url), body: data)
                                      .then((value) {
                                    var result = jsonDecode(value.body);
                                    if (result['status_cart'] == 'S') {
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (ctx) =>
                                      //             VouchersRestautantScreen(
                                      //               sellerId:
                                      //                   '${detail['seller_id']}',
                                      //               title: title,
                                      //             )),
                                      //     (route) => false);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  VouchersRestautantScreen(
                                                    sellerId:
                                                        '${detail['seller_id']}',
                                                    title: title,
                                                  )));
                                    } else if (result['status_cart'] == 'F') {
                                      Fluttertoast.showToast(
                                          msg: "พบปัญหากรุณาติดต่อผู้ดูแลระบบ",
                                          gravity: ToastGravity.CENTER,
                                          toastLength: Toast.LENGTH_SHORT);
                                    }
                                  });
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 55,
                                // color: Colors.red,
                                child: DecoratedBox(
                                    child: Center(
                                      child: text_to_cart
                                          ? Text(
                                              'ใส่ในตะกร้า',
                                              style: TextStyle(
                                                fontSize: 14.5.sp,
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              'เลือกจำนวน',
                                              style: TextStyle(
                                                fontSize: 14.5.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.cyan[600],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(13)),
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 55,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
