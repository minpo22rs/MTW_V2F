import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/foseller/scanner_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:sizer/sizer.dart';

class SellerScreen extends StatefulWidget {
  final String userId;
  SellerScreen({Key? key, required this.userId}) : super(key: key);
  @override
  _SellerScreenState createState() => _SellerScreenState(userId);
}

class _SellerScreenState extends State<SellerScreen> {
  late String userId;
  _SellerScreenState(this.userId);

  var detail;

  accountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    var url = "https://mtwa.xyz/API/account-detail";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        detail = jsonDecode(response.body);
        var numformat = NumberFormat('#,###.##').format(detail['wallet']);
      }
    });
    return detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'บัญชีของฉัน',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          FutureBuilder(
            future: accountDetail(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                  'https://mtwa.xyz/storage/app/public/user/' +
                                      detail['image']),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          detail['name'],
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScanScreen(
                                    seller: '${detail['seller_id']}')),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_scanner_outlined,
                              color: ColorResources.ICON_Black,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Scan QRcode & Barcode',
                              style: TextStyle(fontSize: 9.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: OutlinedButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('username');
                prefs.remove('role');

                setState(() {
                  Phoenix.rebirth(context);
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.exit_to_app_rounded,
                    color: ColorResources.ICON_Red,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    ' ออกจากระบบ ',
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: ColorResources.KTextRed,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // RowList(
          //   nameText: 'ออกจากระบบ',
          //   iconData: Icons.exit_to_app_rounded,
          //   onTap: () async {
          //     final SharedPreferences prefs =
          //         await SharedPreferences.getInstance();
          //     prefs.remove('username');
          //     setState(() {
          //       Phoenix.rebirth(context);
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
