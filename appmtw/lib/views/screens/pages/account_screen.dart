import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/account/foseller/scanner_screen.dart';
import 'package:mtw_project/views/screens/account/setup_screen.dart';
import 'package:mtw_project/views/screens/favorite/favorite_screen.dart';
import 'package:mtw_project/views/screens/favorite/loading_favorite_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_account_screen.dart';
import 'package:mtw_project/views/screens/support/support_center_screen.dart';
import 'package:mtw_project/views/screens/wallet/wallet_main.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AcountScreen extends StatefulWidget {
  const AcountScreen({
    Key? key,
  }) : super(key: key);
  @override
  _AcountScreenState createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  void initState() {
    super.initState();
  }

  Future<Null> refreshscreen() async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingAccScreen(
          pageKey: 'account',
          pageKey2: '',
        ),
      ),
    );
    // await Future.delayed(Duration(seconds: 2));
  }

  var detail;
  var numformat;
  accountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    print(userId);

    var url = "http://10.0.2.2/flutter/account-detail.php";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        detail = jsonDecode(response.body);
        // numformat = NumberFormat('#,###.##').format(detail['wallet']);
        numformat = detail['wallet'];
        print(numformat);
      }
    });
    return detail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'บัญชีของฉัน',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: refreshscreen,
        child: ListView(
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
                                    'http://10.0.2.2/flutter/2021-09-06-61361d04555bf.jpg'),
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoadingAccScreen(
                                                pageKey: 'wallet',
                                                pageKey2: 'wallet',
                                              )));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/wallet-filled-money-tool.svg',
                                      width: 14.sp,
                                      height: 17.sp,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          numformat,
                                          style: TextStyle(fontSize: 9.sp),
                                        ),
                                        Text(
                                          '  ฿',
                                          style: TextStyle(
                                            fontSize: 5.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              flex: 2,
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/coin.svg',
                                      width: 14.sp,
                                      height: 17.sp,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '0.00',
                                          style: TextStyle(fontSize: 9.sp),
                                        ),
                                        Text(
                                          '  คะแนน',
                                          style: TextStyle(fontSize: 5.sp),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),

            SizedBox(
              height: 8,
            ),
            // RowList(
            //   nameText: 'รายการของฉัน',
            //   iconData: Icons.list_alt_rounded,
            //   onTap: () {},
            // ),
            // RowList(
            //   nameText: 'สิ่งที่ถูกใจ',
            //   iconData: Icons.favorite,
            //   onTap: () {},
            // ),
            RowList(
              nameText: 'การชำระเงิน',
              iconData: Icons.credit_card_rounded,
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingAccScreen(
                              pageKey: 'wallet',
                              pageKey2: 'wallet',
                            )));
              },
            ),
            // RowList(
            //   nameText: 'ข้อมูลส่วนตัว',
            //   iconData: Icons.account_circle_rounded,
            //   onTap: () {},
            // ),
            RowList(
                nameText: 'สิ่งที่ถูกใจ',
                iconData: Icons.favorite,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoadingFavScreen(
                                pageKey: '',
                                productKey: '',
                              )));
                }),
            RowList(
              nameText: 'การตั้งค่า',
              iconData: Icons.settings,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SetupScreen()));
              },
            ),
            RowList(
              nameText: 'ติดต่อเพื่อขอความช่วยเหลือ',
              iconData: Icons.help_center_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SupportCenterScreen(),
                  ),
                );
              },
            ),
            RowList(
              nameText: 'ออกจากระบบ',
              iconData: Icons.exit_to_app_rounded,
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.remove('username');
                prefs.remove('role');
                setState(() {
                  Phoenix.rebirth(context);
                });
              },
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class RowList extends StatelessWidget {
  final String nameText;
  final IconData iconData;
  final VoidCallback onTap;

  const RowList({
    Key? key,
    required this.nameText,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      iconData,
                      size: 32,
                      color: (nameText == 'ออกจากระบบ')
                          ? ColorResources.ICON_Red
                          : Colors.black,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      nameText,
                      style: (nameText == 'ออกจากระบบ')
                          ? TextStyle(
                              color: ColorResources.ICON_Red,
                            )
                          : TextStyle(),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: (nameText == 'ออกจากระบบ')
                      ? ColorResources.ICON_Red
                      : Colors.black,
                ),
              ],
            ),
          ),
        ),
        // Divider(
        //   thickness: 0.5,
        // ),
      ],
    );
  }
}
