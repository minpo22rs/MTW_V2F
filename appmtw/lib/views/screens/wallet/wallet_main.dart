import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/loading_account_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:mtw_project/views/screens/wallet/topup_listview.dart';
import 'package:mtw_project/views/screens/wallet/topup_more_list.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class WalletMain extends StatefulWidget {
  final String wallet, pageMain, pageKey2;
  final List topups;
  const WalletMain(
      {Key? key,
      required this.wallet,
      required this.topups,
      required this.pageMain,
      required this.pageKey2})
      : super(key: key);

  @override
  _WalletMainState createState() =>
      _WalletMainState(wallet, topups, pageMain, pageKey2);
}

class _WalletMainState extends State<WalletMain> {
  Future<Null> refreshscreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingAccScreen(
          pageKey: pageMain,
          pageKey2: pageKey2,
        ),
      ),
    );
    // await Future.delayed(Duration(seconds: 2));
  }

  late String pageMain, pageKey2;
  late List topups;
  late String wallet;

  var detail;

  accountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    print(userId);

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

  _WalletMainState(this.wallet, this.topups, this.pageMain, this.pageKey2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            if (pageMain == 'wallet') {
              await Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return LoadingAccScreen(pageKey: 'account', pageKey2: '');
              }), (route) => false);
            } else if (pageMain == 'walletx') {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final String? userId = prefs.getString('username');
              await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoadingScreen(
                        userid: userId!,
                      )));
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'Wallet',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        // elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: refreshscreen,
        child: Column(
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
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 26, vertical: 34),
                    width: double.infinity,
                    height: 170,
                    decoration: BoxDecoration(
                      color: ColorResources.BG_Blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/wallet-filled-money-tool.svg',
                                    width: 20.sp,
                                    height: 30.sp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'จำนวนเงินทั้งหมด',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.5.sp,
                                        ),
                                      ),
                                      Text(
                                        'THB' +
                                            ' ' +
                                            NumberFormat('#,###.##')
                                                .format(detail['wallet']),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.5.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'เติมเงินเพื่อใช้ในการชำระเงิน',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoadingAccScreen(
                                        pageKey: 'in_wallet',
                                        pageKey2: pageKey2,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รายการล่าสุด',
                    style: TextStyle(
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => TopUpMore(),
                        ),
                      );
                    },
                    child: Text(
                      'ดูทั้งหมด',
                      style: TextStyle(
                        fontSize: 8.5.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextLightBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TopupListview(),
          ],
        ),
      ),
    );
  }
}
