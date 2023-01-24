import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/foseller/success_scan_screen.dart';
import 'package:mtw_project/views/screens/account/foseller/test.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ScanScreen extends StatefulWidget {
  final String seller;
  ScanScreen({Key? key, required this.seller}) : super(key: key);
  @override
  _ScanScreenState createState() => _ScanScreenState(seller);
}

class _ScanScreenState extends State<ScanScreen> {
  late String seller;
  _ScanScreenState(this.seller);
  String _scanBarcode = '';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
      if (barcodeScanRes.contains('MTW') == true) {
        setState(() {
          _scanBarcode = barcodeScanRes;
          _showMyDialog(barcodeScanRes);
        });
      } else if (barcodeScanRes == '-1') {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showToast('Barcode/QRcode นี้ไม่ได้เป็นของทางระบบค่ะ');
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      if (barcodeScanRes.contains('MTW') == true) {
        setState(() {
          _scanBarcode = barcodeScanRes;
          _showMyDialog(barcodeScanRes);
        });
      } else if (barcodeScanRes == '-1') {
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        showToast('Barcode/QRcode นี้ไม่ได้เป็นของทางระบบค่ะ');
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  void showToast(var toast) {
    Fluttertoast.showToast(
        msg: toast,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<void> _showMyDialog(var scanRes) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text((scanRes == 'Failed to get platform version.')
              ? 'Failed to get platform version.'
              : 'ยืนยันการใช้สิทธิ์'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () async {
                if (scanRes == 'Failed to get platform version.') {
                  Navigator.pop(context);
                } else {
                  var link = "https://mtwa.xyz/API/use-vouchers";
                  var data = {'scanRes': scanRes, 'seller': '${seller}'};
                  await http.post(Uri.parse(link), body: data).then((value) {
                    var result = jsonDecode(value.body);
                    if (result['status'] == 'S') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SucScanScreen(),
                          ),
                          (route) => false);
                    } else if (result['status'] == 'NI') {
                      Navigator.pop(context);
                      showToast('ไม่พบข้อมูล Vouchers นี้ค่ะ');
                    } else if (result['status'] == 'NOS') {
                      Navigator.pop(context);
                      showToast('Vouchers นี้ไม่ร่วมรายการของร้านค้านี้ค่ะ');
                    } else if (result['status'] == 'NO') {
                      Navigator.pop(context);
                      showToast('Barcode/QRcode นี้ไม่ได้เป็นของทางระบบค่ะ');
                    } else if (result['status'] == 'F') {
                      Navigator.pop(context);
                      showToast('ขออภัยค่ะ พบปัญหากรุณาติดต่อผู้ดูแลระบบค่ะ');
                    } else if (result['status'] == 'EXP') {
                      Navigator.pop(context);
                      showToast('ขออภัยค่ะ Vouchers นี้หมดอายุแล้วค่ะ');
                    }
                  });
                }
              },
              child: Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.ICON_Black,
            ),
          ),
          title: const Text(
            'Scanner',
            style: TextStyle(
              color: ColorResources.KTextBlack,
            ),
          ),
          backgroundColor: ColorResources.KTextWhite,
        ),
        body: Builder(builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 10, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            scanBarcodeNormal();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/barcode-svgrepo-com_1.svg',
                                width: 14.sp,
                                height: 17.sp,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'สแกน Barcode & QRcode',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 6,
                      // ),
                      // Expanded(
                      //   flex: 2,
                      //   child: OutlinedButton(
                      //     onPressed: () {
                      //       scanQR();
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: [
                      //         Icon(
                      //           Icons.qr_code_2,
                      //           color: ColorResources.ICON_Black,
                      //         ),
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Text(
                      //               'สแกน QR code',
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (BuildContext context) =>
                      //                 TextTest()));
                      //   },
                      //   child: Text('data'),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
