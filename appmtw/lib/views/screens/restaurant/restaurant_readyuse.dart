import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/models/restaurant_readyuse_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/screens/score/score_one.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class RestaurantReadyUseScreen extends StatefulWidget {
  final String resId, vId;
  const RestaurantReadyUseScreen(
      {Key? key, required this.resId, required this.vId})
      : super(key: key);

  @override
  _RestaurantReadyUseScreenState createState() =>
      _RestaurantReadyUseScreenState(resId, vId);
}

class _RestaurantReadyUseScreenState extends State<RestaurantReadyUseScreen> {
  late String resId, vId;
  _RestaurantReadyUseScreenState(this.resId, this.vId);

  bool openCode = false;
  bool barAQr = false;
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
    var url = "https://mtwa.xyz/API/vouchers-show-detail";
    var data = {
      'vId': vId,
      'userId': userId,
    };
    await http.post(Uri.parse(url), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultData = result;
      print(result);
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
                  height: 550,
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
                              resultData['name'],
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
                            if (resultData['status'] == 'on') ...[
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
                            ] else if (resultData['status'] == 'off') ...[
                              Text(
                                'ใช้งานแล้ว',
                                style: TextStyle(
                                  fontSize: 9.5.sp,
                                  color: ColorResources.ICON_Red,
                                ),
                              )
                            ],
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        child: Center(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (resultData['status'] == 'on') ...[
                                  Text('ใช้ Vouchers '),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        openCode = true;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/barcode-svgrepo-com_1.svg',
                                          width: 16,
                                          height: 16,
                                          color: ColorResources.ICON_Black,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.qr_code_2_sharp),
                                      ],
                                    ),
                                  )
                                ] else if (resultData['status'] == 'off') ...[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ScoreOne(
                                            sId: '${resultData['seller']}',
                                            type: 'R',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'รีวิวร้านอาหาร',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios_rounded)
                                ]
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
                      openCode
                          ? Container(
                              height: 300,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    children: [
                                      Positioned(
                                        left: 20,
                                        top: 16,
                                        child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                openCode = false;
                                              });
                                            },
                                            child: Icon(Icons.arrow_circle_up)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'ใช้งาน QRcode & Barcode',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      color: ColorResources.KTextLightBlue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: barAQr
                                            ? SfBarcodeGenerator(
                                                value:
                                                    'MTW,${resultData['refno']},${resultData['seller']},${resultData['customer']},R,${vId}',
                                                symbology: Code128A(),
                                                barColor:
                                                    ColorResources.KTextBlack,
                                              )
                                            : SfBarcodeGenerator(
                                                value:
                                                    'MTW,${resultData['refno']},${resultData['seller']},${resultData['customer']},R,${vId}',
                                                symbology: QRCode(),
                                                barColor:
                                                    ColorResources.KTextBlack,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      // color: Colors.green,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print('Barcode');
                                                  setState(() {
                                                    barAQr = true;
                                                  });
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/icons/barcode-svgrepo-com_1.svg',
                                                  width: 50,
                                                  height: 50,
                                                  color:
                                                      ColorResources.ICON_Black,
                                                ),
                                              ),
                                              SizedBox(width: 50),
                                              GestureDetector(
                                                  onTap: () {
                                                    print('Qrcode');
                                                    setState(() {
                                                      barAQr = false;
                                                    });
                                                  },
                                                  child: Icon(
                                                      Icons.qr_code_2_sharp,
                                                      size: 55)),
                                            ],
                                          ),
                                          Text(
                                            'กรุณาแสดงรหัสที่ที่พักเพื่อรับสิทธิ์',
                                            style: TextStyle(
                                                color:
                                                    ColorResources.KTextGray),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                ],
                              ),
                            )
                          : Text(''),
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
                                Text(
                                  '  ' +
                                      ((resultData['howto'] != null)
                                          ? resultData['howto']
                                          : ''),
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
                        height: 15,
                      ),
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
