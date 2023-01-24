import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/models/restaurant_readyuse_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantOrder extends StatefulWidget {
  final String resId, vId;
  const RestaurantOrder({Key? key, required this.resId, required this.vId})
      : super(key: key);

  @override
  _RestaurantOrderState createState() => _RestaurantOrderState(resId, vId);
}

class _RestaurantOrderState extends State<RestaurantOrder> {
  late String resId, vId;
  _RestaurantOrderState(this.resId, this.vId);
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: SvgPicture.asset(
            'assets/icons/check.svg',
            width: 40,
            height: 40,
            color: ColorResources.ICON_Green,
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('ยืนยัน')),
            ),
          ],
        );
      },
    );
  }

  List<Proimg> proimg = <Proimg>[];
  var resultData2;
  var resultData;
  listImage() async {
    var url = "https://mtwa.xyz/API/restaurant-image";
    var data = {
      'resId': resId,
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

  vouchersDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/vouchers-order-detail";
    var data = {
      'oId': vId,
      'userId': userId,
    };
    print(data);
    await http.post(Uri.parse(url), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultData = result;
      print(resultData);
    });
    return resultData;
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
        title: Column(
          children: [
            Text(
              'ร้านอาหาร',
              style: TextStyle(
                color: ColorResources.ICON_Black,
              ),
            ),
            Text(
              'Vouchers',
              style:
                  TextStyle(color: ColorResources.ICON_Black, fontSize: 11.sp),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
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
          Expanded(
            child: FutureBuilder(
              future: vouchersDetail(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Container(
                  width: double.infinity,
                  height: 280,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
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
                              resultData['name'].toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                if (resultData['unit_price'] != null) ...[
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
                                        .format(resultData['unit_price'])
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: ColorResources.KTextGray,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                                SizedBox(
                                  width: 4,
                                ),
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
                                      .format(resultData['purchase_price'])
                                      .toString(),
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
                              'เวลาที่ใช้ได้ : ถึง ' +
                                  resultData['dateend'].split('-')[2] +
                                  '/' +
                                  resultData['dateend'].split('-')[1] +
                                  '/' +
                                  resultData['dateend'].split('-')[0],
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
                                Text(' ' + resultData['details']),
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
                                    ((resultData['howto'] != null)
                                        ? resultData['howto']
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
                                    ((resultData['howto'] != null)
                                        ? resultData['howto']
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
                      SizedBox(
                        height: 10,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 40),
                      //   child: CustomButton(
                      //       onTap: () {
                      //         showModalBottomSheet(
                      //           context: context,
                      //           builder: (ctx) {
                      //             return Column(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 Stack(
                      //                   children: [
                      //                     Positioned(
                      //                       left: 20,
                      //                       top: 16,
                      //                       child: GestureDetector(
                      //                           onTap: () {
                      //                             Navigator.pop(context);
                      //                           },
                      //                           child: Icon(Icons.close)),
                      //                     ),
                      //                     Padding(
                      //                       padding: const EdgeInsets.symmetric(
                      //                           vertical: 16),
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         children: [
                      //                           Text(
                      //                             'ใช้เมื่อ : ',
                      //                             style: TextStyle(
                      //                                 fontWeight:
                      //                                     FontWeight.bold,
                      //                                 fontSize: 12.sp),
                      //                           ),
                      //                           Text(
                      //                             '30 ส.ค. 2021 14:45',
                      //                             style: TextStyle(
                      //                                 fontSize: 12.sp),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 Expanded(
                      //                   flex: 3,
                      //                   child: Container(
                      //                       // color: Colors.redAccent,
                      //                       ),
                      //                 ),
                      //                 Expanded(
                      //                   flex: 2,
                      //                   child: Container(
                      //                     // color: Colors.green,
                      //                     child: Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Row(
                      //                           mainAxisAlignment:
                      //                               MainAxisAlignment.center,
                      //                           children: [
                      //                             GestureDetector(
                      //                                 onTap: () {
                      //                                   print('Barcode');
                      //                                 },
                      //                                 child: Icon(
                      //                                     Icons
                      //                                         .qr_code_2_rounded,
                      //                                     size: 55)),
                      //                             SizedBox(width: 50),
                      //                             GestureDetector(
                      //                                 onTap: () {
                      //                                   print('Qrcode');
                      //                                 },
                      //                                 child: Icon(
                      //                                     Icons
                      //                                         .qr_code_2_rounded,
                      //                                     size: 55)),
                      //                           ],
                      //                         ),
                      //                         SizedBox(height: 22),
                      //                         Text(
                      //                           'Time Left : ' + '09:30',
                      //                           style: TextStyle(
                      //                               fontSize: 14.5.sp,
                      //                               fontWeight: FontWeight.bold,
                      //                               color: ColorResources
                      //                                   .KTextBlue),
                      //                         ),
                      //                         SizedBox(height: 22),
                      //                         Text(
                      //                           'กรุณาแสดงรหัสที่ร้านค้าเพื่อรับสิทธิ์',
                      //                           style: TextStyle(
                      //                               color: ColorResources
                      //                                   .KTextGray),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             );
                      //           },
                      //         );
                      //       },
                      //       buttonText: 'ใช้เลย',
                      //       size: 45),
                      // ),
                      if (resultData['status_pay'] == 'W') ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: GestureDetector(
                            onTap: () {
                              launch(
                                  'https://mtwa.xyz/API/e-pay-again?id=${resultData['customer']}&email=${resultData['email']}&total=${resultData['purchase_price']}&refno=${resultData['refno']}&type=R');
                              setState(() {
                                Navigator.pop(context);
                                _showMyDialog();
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.cyan,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                              child: Center(
                                child: Text(
                                  'ชำระเงิน',
                                  style: TextStyle(
                                    color: ColorResources.KTextWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ] else if (resultData['status_pay'] == 'S') ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/check.svg',
                                    width: 15,
                                    height: 15,
                                    color: ColorResources.ICON_Green,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('ชำระเงินเรียบร้อยแล้ว'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                          indent: 16,
                          endIndent: 16,
                        ),
                      ],
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
