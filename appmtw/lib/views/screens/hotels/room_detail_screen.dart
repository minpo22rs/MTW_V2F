import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/models/seller_image_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mtw_project/views/basewidget/widget_slider_image.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RoomDetailScreen extends StatefulWidget {
  final String title, hotelId, start, end;

  const RoomDetailScreen(
      {Key? key,
      required this.title,
      required this.hotelId,
      required this.start,
      required this.end})
      : super(key: key);

  @override
  _RoomDetailScreenState createState() =>
      _RoomDetailScreenState(title, hotelId, start, end);
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  late String title, hotelId, start, end;
  _RoomDetailScreenState(this.title, this.hotelId, this.start, this.end);

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('จองห้องพักเรียบร้อยแล้วค่ะ'),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ยืนยัน')),
          ],
        );
      },
    );
  }

  int countDay(var form, var to) {
    var ex1 = form.split('/');
    var ex2 = to.split('/');
    DateTime dayform =
        DateTime(int.parse(ex1[2]), int.parse(ex1[1]), int.parse(ex1[0]));
    DateTime dayto =
        DateTime(int.parse(ex2[2]), int.parse(ex2[1]), int.parse(ex2[0]));
    return (dayto.difference(dayform).inHours / 24).round();
  }

  var room;

  roomDetail() async {
    var url = "https://mtwa.xyz/API/room-detail";
    var data = {'roomId': '${hotelId}'};
    await http.post(Uri.parse(url), body: data).then((value) {
      room = jsonDecode(value.body);
    });
    return room;
  }

  List<Proimg> images = <Proimg>[];
  var resultDataI;

  slideImage() async {
    var link = "https://mtwa.xyz/API/room-images";
    var data = {
      'sId': '${hotelId}',
    };
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataI = result;
      images = <Proimg>[];
      for (var i = 0; i < resultDataI.length; i++) {
        Proimg t = Proimg.fromJson(resultDataI[i]);
        images.add(t);
      }
    });
    return images;
  }

  @override
  Widget build(BuildContext context) {
    var textstyleHead = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.bold,
    );
    var textstyle = TextStyle(
      fontSize: 9.5.sp,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.ICON_Gray,
            )),
        title: Column(
          children: [
            Text(
              'เลือกห้องพัก',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 8.sp, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
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
                pageKey: 'rooms',
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: FutureBuilder(
              future: roomDetail(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  var day = countDay('${start}', '${end}');
                  return ListView(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 90,
                        color: Colors.blue[100],
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/document.svg',
                                    width: 22,
                                    height: 22,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('เงื่อนไขในการจองห้อง'),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // WidgetSliderImage(),
                      // ImageSlider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${room['name']}',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  'ราคาสำหรับ : ',
                                ),
                                for (int i = 1; i <= 5; i++) ...[
                                  SvgPicture.asset(
                                    'assets/icons/user.svg',
                                    width: 18,
                                    height: 18,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                ],
                                if (room['person'] > 5) ...[
                                  Text('+' + (room['person'] - 5).toString())
                                ]
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            if (room['prepaid'] == '1') ...[
                              Text(
                                'ต้องชำระล่วงหน้า',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.KTextLightBlue,
                                ),
                              ),
                            ] else if (room['prepaid'] == '2') ...[
                              Text(
                                'จ่ายเมื่อเข้าพักไม่ต้องชำระล่วงหน้า',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorResources.KTextLightBlue,
                                ),
                              ),
                            ],
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              'เหลืออีก ' +
                                  room['quant_room_for_mtwa'].toString() +
                                  ' ห้องเท่านั้นบน MWT Hotel',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorResources.KTextRed,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text('ราคาสำหรับ ${day} คืน (' +
                                start +
                                ' - ' +
                                end +
                                ')'),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                if (room['unit_price'] != null) ...[
                                  Text(
                                    '฿' +
                                        NumberFormat('#,###.##')
                                            .format(room['unit_price'] * day)
                                            .toString(),
                                    style: TextStyle(
                                      color: ColorResources.KTextGray,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                ],
                                Text(
                                  '฿' +
                                      NumberFormat('#,###.##')
                                          .format(room['purchase_price'] * day)
                                          .toString(),
                                  style: TextStyle(
                                    color: ColorResources.KTextLightBlue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/check.svg',
                                  width: 16,
                                  height: 16,
                                  color: ColorResources.ICON_Green,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('รวมภาษีและค่าธรรมเนียมแล้ว')
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ยกเลิกได้ไหม?',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (room['cancellation'] == '1') ...[
                                  SvgPicture.asset(
                                    'assets/icons/check.svg',
                                    width: 16,
                                    height: 16,
                                    color: ColorResources.ICON_Green,
                                  ),
                                ],
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (room['cancellation'] == '1') ...[
                                        Text(
                                          'ยกเลิกการจองได้ฟรี',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ] else if (room['cancellation'] ==
                                          '2') ...[
                                        Text(
                                          'ไม่สามารถยกเลิกได้',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        room['cancellation_condition']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 18),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text('รวม'),
                      //       Text(
                      //           'ภาษีมูลค่าเพิ่ม (VAT) 7%,ภาษีเมือง(City Tax) THB10 ต่าการเข้าพัก'),
                      //       Text('การชำระล่วงหน้า'),
                      //       Text('ไม่ต้องชำระเงินล่วงหน้า'),
                      //       Text('ตัวเลือกประเภทเตียง'),
                      //       Text('1 เตียงเดี่ยว : ความกว้าง 90 - 30 เซนติเมตร'),
                      //     ],
                      //   ),
                      // ),
                      // Divider(
                      //   thickness: 0.5,
                      //   color: Colors.grey,
                      //   indent: 25,
                      //   endIndent: 25,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'รายละเอียดห้องพัก',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(room['details'].toString()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/double-bed.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'ห้องนอน',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(room['typeroom'].toString()),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/couch.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'พื้นที่นั่งเล่น',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(room['living_room'].toString()),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/kitchen.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  'สิ่งอำนวยความสะดวกภายในห้องครัว',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(room['kitchen'].toString()),
                            SizedBox(
                              height: 18,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                            height: 400,
                                            width: 300,
                                            child: ListView(
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/double-bed.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('ห้องนอน',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    room['typeroom'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/couch.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('พื้นที่นั่งเล่น',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    room['living_room']
                                                        .toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/kitchen.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        'สิ่งอำนวยความสะดวกภายในห้องครัว',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(room['kitchen'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/bathtub.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('ห้องน้ำ',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    room['bathroom_facility']
                                                        .toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/information (1).svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('ทั่วไป',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(room['general'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/restaurant.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('อาหารและเครื่องดื่ม',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(room['food'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/mountains.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('ทิวทัศน์',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(room['view'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/sun.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('พื้นที่กลางแจ้ง',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    room['exterior'].toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/television.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                        'อุปกรณ์สื่อและเทคโนโลยี',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Text(
                                                    room['electronic']
                                                        .toString(),
                                                    style: textstyle),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/parked-car.svg',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text('ที่จอดรถ',
                                                        style: textstyleHead),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 6,
                                                ),
                                                if (room['parking_lot'] ==
                                                    '1') ...[
                                                  Text(
                                                    'บริการที่จอดฟรี',
                                                    style: textstyle,
                                                  ),
                                                ] else if (room[
                                                        'parking_lot'] ==
                                                    '2') ...[
                                                  Text(
                                                    'ไม่มีบริการที่จอดรถฟรี',
                                                    style: textstyle,
                                                  ),
                                                ],
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'เด็กและเตียงเสริม',
                                                  style: TextStyle(
                                                    fontSize: 14.5.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    'นโยบายเกี่ยวกับผู้เข้าพักเด็ก',
                                                    style: textstyleHead),
                                                Text(
                                                  room['kid_policy'] != null
                                                      ? room['kid_policy']
                                                      : 'ยังไม่มีระบุข้อมูล',
                                                  style: textstyle,
                                                ),
                                                Text(
                                                  'นโยบายเกี่ยวกับเปลเด็กและเตียงเสริม',
                                                  style: textstyleHead,
                                                ),
                                                Text(
                                                  room['kid_policy_bed'] != null
                                                      ? room['kid_policy_bed']
                                                      : 'ยังไม่มีระบุข้อมูล',
                                                  style: textstyle,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: ColorResources
                                                          .BG_Blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                      'ปิดหน้าต่างนี้',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: ColorResources
                                                            .KTextWhite,
                                                      ),
                                                    )),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // content: setupAlertDialoadContainer(),
                                        );
                                      });
                                },
                                child: Text(
                                  'อ่านเพิ่มเติม',
                                  style: TextStyle(
                                      color: ColorResources.KTextLightBlue),
                                ),
                              ),
                            )
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('ห้องน้ำ'),
                            //   ],
                            // ),
                            // Text('การดาษชำระ'),
                            // Text('ผ้าเช็ดตัว'),
                            // Text('ฝักบัว'),
                            // Text('สุขา'),
                            // Text('เครื่องใช้ในห้องน้ำฟรี'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('ทั่วไป'),
                            //   ],
                            // ),
                            // Text('ถังขยะ'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('อาหารและเครื่องดื่ม'),
                            //   ],
                            // ),
                            // Text('น้ำดื่มบรรจุขวด'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('ทิวทัศน์'),
                            //   ],
                            // ),
                            // Text('วิวเมือง'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('พื้นที่กลางแจ้ง'),
                            //   ],
                            // ),
                            // Text('ระเบียง'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('อุปกรณ์สื่อและเทคโนโลยี'),
                            //   ],
                            // ),
                            // Text('โทรทัศน์'),
                            // Row(
                            //   children: [
                            //     Icon(Icons.access_alarm),
                            //     Text('ที่จอดรถ'),
                            //   ],
                            // ),
                            // Text(
                            //   'มีที่จอดรถส่วนตัวที่โรงแรม (ไม่จำเป็นต้องสำรองที่จอดรถ) ไม่มีค่าบริการ',
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        indent: 25,
                        endIndent: 25,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 18),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text('เด็กและเตียงเสริม'),
                      //       Text('นโยบายเกี่ยวกับผู้เข้าพักเด็ก'),
                      //       Text('เด็กทุกวัยสามารถเข้าพักได้'),
                      //       Text(
                      //           'ที่พักกำหนดไว้ว่าเด็กอายุตั้งแต่   ปีขึ้นไปถือว่าเป้นผู้ใหญ่หากต้องการดูข้อมูลที่ถูดต้องของราคาและจำนวนผู้เข้าพักโปรดระบุจำนวนและอายุเด็กในกลุ่มเดินทางกับท่านลงในการค้นหา'),
                      //       Text('นโยบายเกี่ยวกับเปลเด็กและเตียงเสริม'),
                      //       Text('ไม่มีพื้นที่สำหรับเตียงเสริมหรือเปลเด็ก'),
                      //     ],
                      //   ),
                      // ),
                      // Divider(
                      //   thickness: 0.5,
                      //   color: Colors.grey,
                      //   indent: 25,
                      //   endIndent: 25,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 18),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Text('รายละเอียดห้องพัก'),
                      //       Text(
                      //           'ห้องเตียงแฝดประเภทนี้มีเครื่องปรับอากาศและโทรทัศน์ระบบช่องสัญญาณดาวเทียม'),
                      //     ],
                      //   ),
                      // ),
                      // Divider(
                      //   thickness: 0.5,
                      //   color: Colors.grey,
                      //   indent: 25,
                      //   endIndent: 25,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(
                                Images.bangkok,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ชื่อลูกค้า'),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: 50.sp,
                                  // color: Colors.black.withOpacity(0.2),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 7.sp,
                                        color: Colors.yellow[700],
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 7.sp,
                                        color: Colors.yellow[700],
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 7.sp,
                                        color: Colors.yellow[700],
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 7.sp,
                                        color: Colors.yellow[700],
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Icon(
                                        Icons.circle_rounded,
                                        size: 7.sp,
                                        color: Colors.black26,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Container(
                          width: double.infinity,
                          // color: Colors.redAccent.withOpacity(0.2),
                          child: Text(
                            'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Text('ราคาทั้งหมด '),
                                      Text(
                                        '฿ ' +
                                            NumberFormat('#,###.##')
                                                .format(room['purchase_price'] *
                                                    day)
                                                .toString(),
                                        style: TextStyle(
                                            color:
                                                ColorResources.KTextLightBlue),
                                      ),
                                    ],
                                  ),
                                  Text('ได้รับ 0 คะแนน'),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/check.svg',
                                        width: 10,
                                        height: 10,
                                        color: ColorResources.ICON_Green,
                                      ),
                                      Text(' รวมภาษีและค่าธรรมเนียมแล้ว'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 170,
                              child: GestureDetector(
                                onTap: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final String? userId =
                                      prefs.getString('username');
                                  var price = room['purchase_price'] * day;
                                  if (room['prepaid'] == '1') {
                                    var link =
                                        "https://mtwa.xyz/API/check-rooms";
                                    var data = {
                                      'hId': '${room['id']}',
                                    };
                                    await http
                                        .post(Uri.parse(link), body: data)
                                        .then((value) {
                                      var result = jsonDecode(value.body);
                                      if (result['status'] == '1') {
                                        var url =
                                            "https://mtwa.xyz/API/e-pay?id=" +
                                                userId! +
                                                "&total=" +
                                                '${price}' +
                                                "&type=H" +
                                                "&cartId=" +
                                                '${room['id']}' +
                                                '&start=${start}&endd=${end}';

                                        launch(url);
                                        _showMyDialog();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "ห้องพักถูกจองหมดไปแล้วค่ะ",
                                            gravity: ToastGravity.CENTER,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    });
                                  } else if (room['prepaid'] == '2') {
                                    var link =
                                        "https://mtwa.xyz/API/check-rooms";
                                    var ch = {
                                      'hId': '${room['id']}',
                                    };
                                    await http
                                        .post(Uri.parse(link), body: ch)
                                        .then((value) async {
                                      var result = jsonDecode(value.body);
                                      if (result['status'] == '1') {
                                        var url =
                                            "https://mtwa.xyz/API/hotel-order";
                                        var data = {
                                          'id': userId,
                                          'total': '${price}',
                                          'hId': '${room['id']}',
                                          'start': '${start}',
                                          'endd': '${end}'
                                        };
                                        await http
                                            .post(Uri.parse(url), body: data)
                                            .then((value) {
                                          setState(() {
                                            _showMyDialog();
                                          });
                                        });
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "ห้องพักถูกจองหมดไปแล้วค่ะ",
                                            gravity: ToastGravity.CENTER,
                                            toastLength: Toast.LENGTH_SHORT);
                                      }
                                    });
                                  }
                                },
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Colors.cyan),
                                  child: Center(
                                      child: Text(
                                    'เลือกห้องนี้',
                                    style: TextStyle(
                                      color: ColorResources.KTextWhite,
                                      fontSize: 18,
                                    ),
                                  )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget setupAlertDialoadContainer() {
    var textstyleHead = TextStyle(
      fontSize: 11.sp,
      fontWeight: FontWeight.bold,
    );
    var textstyle = TextStyle(
      fontSize: 9.5.sp,
    );
    return Container(
      height: 400,
      width: 300,
      child: ListView(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/double-bed.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('ห้องนอน', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('เตียงแฝด', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/couch.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('พื้นที่นั่งเล่น', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('โซฟา', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/kitchen.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('สิ่งอำนวยความสะดวกสำหรับครัว', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('กาต้มน้ำไฟฟ้า', style: textstyle),
          Text('ตู้เย็น', style: textstyle),
          Text('ไมโครเวฟ', style: textstyle),
          Text('โต๊ะทานอาหาร', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/bathtub.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('ห้องน้ำ', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('การดาษชำระ', style: textstyle),
          Text('ผ้าเช็ดตัว', style: textstyle),
          Text('ฝักบัว', style: textstyle),
          Text('สุขา', style: textstyle),
          Text('เครื่องใช้ในห้องน้ำฟรี', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/information (1).svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('ทั่วไป', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('ถังขยะ', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/restaurant.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('อาหารและเครื่องดื่ม', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('น้ำดื่มบรรจุขวด', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/mountains.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('ทิวทัศน์', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('วิวเมือง', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/sun.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('พื้นที่กลางแจ้ง', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('ระเบียง', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/television.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('อุปกรณ์สื่อและเทคโนโลยี', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text('โทรทัศน์', style: textstyle),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/parked-car.svg',
                width: 20,
                height: 20,
              ),
              SizedBox(
                width: 6,
              ),
              Text('ที่จอดรถ', style: textstyleHead),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            'มีที่จอดรถส่วนตัวที่โรงแรม \n(ไม่จำเป็นต้องสำรองที่จอดรถ) ไม่มีค่าบริการ',
            style: textstyle,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'เด็กและเตียงเสริม',
            style: TextStyle(
              fontSize: 14.5.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'เด็กและเตียงเสริม',
            style: textstyleHead,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'เด็กทุกวัยสามารถเข้าพักได\nที่พักกำหนดไว้ว่าเด็ดอายุตั้งแต่ _ ปีขึ้นไปถือว่าเป้นผู้ใหญ่หากต้องการดูข้อมูลที่ถูกต้องของราคาและจำนวนผู้เข้าพักโปรดระบุจำนวนและอายุในกลุ่มเดินทางกับกับท่านลงในการค้นหา',
            style: textstyle,
          ),
          SizedBox(
            height: 13,
          ),
          Text(
            'นโยบายเกี่ยวกับเปลเด็กและเตียงเสริม',
            style: textstyleHead,
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            'ไม่มีพื้นที่สำหรับเตียงเสริมหรือเปลเด็ก',
            style: textstyle,
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: ColorResources.BG_Blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                'ปิดหน้าต่างนี้',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorResources.KTextWhite,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
