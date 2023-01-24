import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtw_project/views/screens/review/product_review.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/screens/hotels/hotel_screen.dart';
import 'package:mtw_project/views/screens/hotels/room_detail_screen.dart';
import 'package:mtw_project/views/screens/score/score_one.dart';
import 'package:mtw_project/views/screens/sos/sos_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelReadyUse extends StatefulWidget {
  final String title, vId, pageKey;
  const HotelReadyUse(
      {Key? key, required this.title, required this.vId, required this.pageKey})
      : super(key: key);

  @override
  _HotelReadyUseState createState() => _HotelReadyUseState(title, vId, pageKey);
}

class _HotelReadyUseState extends State<HotelReadyUse> {
  late String title, vId, pageKey;
  _HotelReadyUseState(this.title, this.vId, this.pageKey);
  bool barAQr = false;
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

  var result;
  hotelDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var link = "https://mtwa.xyz/API/order-hotel-detail";
    var data = {
      'userId': '${userId}',
      'vId': vId,
    };
    await http.post(Uri.parse(link), body: data).then((value) {
      result = jsonDecode(value.body);
    });
    return result;
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

  bool openCode = false;

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
            title,
            style: TextStyle(
              color: ColorResources.KTextBlack,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: hotelDetail(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            var day = countDay('${result['start']}', '${result['end']}');
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 18, bottom: 10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (pageKey == "readyuse") ...[
                              Text('พร้อมใช้บริการ'),
                            ] else if (pageKey == "useless") ...[
                              Text(
                                'ใช้งานแล้ว',
                                style: TextStyle(
                                  color: ColorResources.KTextLightBlue,
                                ),
                              ),
                            ],
                            SizedBox(height: 6),
                            Text(
                              'การจองที่พักของท่าน',
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1),
                  if (pageKey == "readyuse") ...[
                    if (result['status_pay'] == 'S') ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'หมายเลขยืนยันการจอง : ${result['refno']}'),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  openCode = !openCode;
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
                                  SizedBox(width: 5),
                                  Icon(Icons.qr_code_2),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                    ],
                  ],
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
                                                'MTW,${result['refno']},${result['seller']},${result['customer']},H,${vId}',
                                            symbology: Code128A(),
                                            barColor: ColorResources.KTextBlack,
                                          )
                                        : SfBarcodeGenerator(
                                            value:
                                                'MTW,${result['refno']},${result['seller']},${result['customer']},H,${vId}',
                                            symbology: QRCode(),
                                            barColor: ColorResources.KTextBlack,
                                          ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  // color: Colors.green,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              color: ColorResources.ICON_Black,
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
                                              child: Icon(Icons.qr_code_2_sharp,
                                                  size: 55)),
                                        ],
                                      ),
                                      Text(
                                        'กรุณาแสดงรหัสที่ที่พักเพื่อรับสิทธิ์',
                                        style: TextStyle(
                                            color: ColorResources.KTextGray),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              result['shopname'],
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        HotelScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'จองอีกครั้ง',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: ColorResources.KTextLightBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${result['start']} - ${result['end']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 16),
                                Text('เช็คอิน : ตั้งแต่ 13:00 น.'),
                                SizedBox(height: 4),
                                Text('เช็คเอาท์ : ตั้งแต่ 12:00 น.'),
                                SizedBox(height: 26),
                                Text(
                                  'ที่อยู่ของที่พัก',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(result['address'].toString()),
                                SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () {
                                    launch(result['position_url']);
                                  },
                                  child: Text(
                                    'ดูเส้นทาง',
                                    style: TextStyle(
                                        color: ColorResources.KTextLightBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 26),
                                Text(
                                  'นโยบายที่พัก',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  width: 300,
                                  child: Text(
                                    result['details'],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Divider(thickness: 1),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ท่านจองห้องพัก ไป 1 ห้อง',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ห้องมาตรฐานสำหรับ ${result['person']} ท่าน',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 75),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18),
                                Text(
                                  'ผู้เข้าพัก',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  result['username'],
                                  style: TextStyle(
                                      color: ColorResources.KTextLightBlue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RoomDetailScreen(
                                            title: result['name'],
                                            hotelId: '${result['product']}',
                                            start: result['start'],
                                            end: result['end']),
                                  ),
                                );
                              },
                              child: Text(
                                'ดูข้อมูลห้องพัก',
                                style: TextStyle(
                                    color: ColorResources.KTextBlue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.only(top: 22, left: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text('ราคารวมสำหรับ '),
                                  Text(
                                    '1 ห้อง พัก ${day} คืน',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  Text('฿ ', style: TextStyle(fontSize: 26)),
                                  Text(
                                    NumberFormat('#,###.##')
                                        .format(result['purchase_price'] * day)
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/check.svg',
                                    width: 16,
                                    height: 16,
                                    color: ColorResources.ICON_Green,
                                  ),
                                  SizedBox(width: 4),
                                  Text('รวมภาษีและค่าธรรมเนียมแล้ว'),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 18),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 36,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (result['status_pay'] == 'S') ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 10),
                      child: Icon(Icons.card_giftcard, size: 34),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'ชำระยอดการจองแล้ว (',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('THB ' +
                                  NumberFormat('#,###.##')
                                      .format(result['purchase_price'] * day)
                                      .toString()),
                              Text(
                                ')',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            'ผ่าน Pay Solutions เมื่อ ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                'วันที่ ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text((result['cdate'].split(' ')[0])
                                      .split('-')[2] +
                                  '/' +
                                  result['cdate'].split('-')[1] +
                                  '/' +
                                  result['cdate'].split('-')[0]),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'เวลา ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                result['cdate'].split(' ')[1],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Divider(thickness: 1),
                    ),
                  ] else ...[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: GestureDetector(
                        onTap: () {
                          launch(
                              'https://mtwa.xyz/API/e-pay-again?id=${result['customer']}&email=${result['email']}&total=${result['purchase_price'] * day}&refno=${result['refno']}&type=H');
                          setState(() {
                            Navigator.pop(context);
                            _showMyDialog();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
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
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Divider(thickness: 1),
                    ),
                  ],
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ต้องการความช่วยเหลือไหม',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 18),
                                Text(
                                  'เราพร้อมช่วยตอบคำถามและจัดการการจองของท่าน',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (ctx) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              // color: Colors.redAccent,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 40),
                                                          child: TextButton(
                                                            onPressed:
                                                                () async {
                                                              var number =
                                                                  '0658022055';
                                                              bool? res =
                                                                  await FlutterPhoneDirectCaller
                                                                      .callNumber(
                                                                          number);
                                                            },
                                                            child: Text(
                                                              'โทรหา ' +
                                                                  '0658022055',
                                                              style: TextStyle(
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                print('object');
                                              },
                                              child: Text(
                                                'ยกเลิก',
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'ติดต่อบริการลูกค้าสัมพันธ์',
                                    style: TextStyle(
                                        color: ColorResources.KTextLightBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 20, bottom: 16),
                    child: Divider(thickness: 1),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 13),
                    child: Text(
                      'การดำเนินการ',
                      style: TextStyle(
                          color: ColorResources.KTextGray, fontSize: 16),
                    ),
                  ),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, bottom: 8, top: 8, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('แชร์ข้อมูลยืนยันการจอง'),
                        Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                  if (result['status'] == 'off') ...[
                    Divider(thickness: 1),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, bottom: 8, top: 8, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ScoreOne(
                                sId: '${result['seller']}',
                                type: 'H',
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'รีวิวห้องพัก',
                            ),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      ),
                    ),
                  ],
                  Divider(thickness: 1),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 24, bottom: 8, top: 8, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('แชร์ลิงค์หน้าที่พัก'),
                  //       Icon(Icons.arrow_forward_ios_rounded)
                  //     ],
                  //   ),
                  // ),
                  // Divider(thickness: 1),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24, bottom: 9, top: 24),
                    child: Text('เดินทางอย่างปลอดภัย',
                        style: TextStyle(
                            color: ColorResources.KTextGray, fontSize: 16)),
                  ),
                  Divider(thickness: 1),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 24, bottom: 8, top: 8, right: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text('ศูนย์รวมข้อมูลด้านความปลอดภัย'),
                  //       Icon(Icons.arrow_forward_ios_rounded)
                  //     ],
                  //   ),
                  // ),
                  // Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 24, bottom: 8, top: 8, right: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SosScreen(),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('บริการฉุกเฉิน'),
                          Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 1),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Text(
                          'ติดต่อห้องพัก',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'พูดคุยเรื่องการเปลี่ยนแปลงการจองของท่านหรือสอบ'),
                            Text('ถามเพิ่มเติมเกี่ยวกับการเข้าพัก'),
                            SizedBox(height: 16),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35, right: 35),
                        child: CustomButton(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (ctx) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 50,
                                        // color: Colors.redAccent,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: TextButton(
                                                      onPressed: () async {
                                                        var number =
                                                            result['phone']
                                                                .toString();
                                                        bool? res =
                                                            await FlutterPhoneDirectCaller
                                                                .callNumber(
                                                                    number);
                                                      },
                                                      child: Text(
                                                        'โทรหา ' +
                                                            result['phone']
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          print('object');
                                        },
                                        child: Text(
                                          'ยกเลิก',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            buttonText: 'ติดต่อที่พัก',
                            size: 45),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Divider(thickness: 1),
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
                  //                       padding:
                  //                           const EdgeInsets.symmetric(vertical: 16),
                  //                       child: Row(
                  //                         mainAxisAlignment: MainAxisAlignment.center,
                  //                         children: [
                  //                           Text(
                  //                             'ใช้เมื่อ : ',
                  //                             style: TextStyle(
                  //                                 fontWeight: FontWeight.bold,
                  //                                 fontSize: 12.sp),
                  //                           ),
                  //                           Text(
                  //                             '30 ส.ค. 2021 14:45',
                  //                             style: TextStyle(fontSize: 12.sp),
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
                  //                       mainAxisAlignment: MainAxisAlignment.center,
                  //                       children: [
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.center,
                  //                           children: [
                  //                             GestureDetector(
                  //                                 onTap: () {
                  //                                   print('Barcode');
                  //                                 },
                  //                                 child: Icon(Icons.qr_code_2_rounded,
                  //                                     size: 55)),
                  //                             SizedBox(width: 50),
                  //                             GestureDetector(
                  //                                 onTap: () {
                  //                                   print('Qrcode');
                  //                                 },
                  //                                 child: Icon(Icons.qr_code_2_rounded,
                  //                                     size: 55)),
                  //                           ],
                  //                         ),
                  //                         SizedBox(height: 22),
                  //                         Text(
                  //                           'Time Left : ' + '09:30',
                  //                           style: TextStyle(
                  //                               fontSize: 14.5.sp,
                  //                               fontWeight: FontWeight.bold,
                  //                               color: ColorResources.KTextBlue),
                  //                         ),
                  //                         SizedBox(height: 22),
                  //                         Text(
                  //                           'กรุณาแสดงรหัสที่ร้านค้าเพื่อรับสิทธิ์',
                  //                           style: TextStyle(
                  //                               color: ColorResources.KTextGray),
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
                  //       buttonText: 'ติดต่อที่พัก',
                  //       size: 45),
                  // ),
                  SizedBox(height: 30),
                ],
              ),
            );
          },
        ));
  }
}
