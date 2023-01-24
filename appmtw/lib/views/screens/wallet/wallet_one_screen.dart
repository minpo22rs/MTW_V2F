import 'package:flutter/material.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/screens/pages/loading_account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletOneScreen extends StatefulWidget {
  final String wallet, pageKey2;
  const WalletOneScreen(
      {Key? key, required this.wallet, required this.pageKey2})
      : super(key: key);

  @override
  _WalletOneScreenState createState() =>
      _WalletOneScreenState(wallet, pageKey2);
}

class _WalletOneScreenState extends State<WalletOneScreen> {
  late String wallet, pageKey2;
  _WalletOneScreenState(this.wallet, this.pageKey2);
  TextEditingController walletctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () async {
            if (pageKey2 == 'wallet') {
              await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoadingAccScreen(
                        pageKey: 'wallet',
                        pageKey2: pageKey2,
                      )));
            } else if (pageKey2 == 'walletx') {
              await Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => LoadingAccScreen(
                        pageKey: 'walletx',
                        pageKey2: pageKey2,
                      )));
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'ระบุจำนวน',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        // elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.money_rounded,
                                size: 34,
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text('Pay Solution'),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '฿',
                      style: TextStyle(fontSize: 18.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Flexible(
                      child: Container(
                        width: 85,
                        // color: Colors.redAccent,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                          controller: walletctrl,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            // errorBorder: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            // contentPadding: EdgeInsets.only(
                            //     left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "0",
                            hintStyle: TextStyle(
                                fontSize: 28.sp,
                                color: ColorResources.KTextGray),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ยอดปัจจุบัน: ฿ ' + wallet,
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      child: Text('ถัดไป'),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.cyanAccent[700],
                      ),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 360,
                              // color: Colors.amber,
                              child: Center(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50,
                                          // color: Colors.amber,
                                          child: Center(
                                            child: Text(
                                              'ตรวจสอบและยืนยัน',
                                              style: TextStyle(fontSize: 14.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'วิธีการชำระเงิน',
                                            style: TextStyle(
                                              color: ColorResources.KTextGray,
                                            ),
                                          ),
                                          Text(
                                            'PAY SOLUTION',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'จำนวนที่เติม',
                                            style: TextStyle(
                                              color: ColorResources.KTextGray,
                                            ),
                                          ),
                                          Text(
                                            '฿' + walletctrl.text,
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 28, vertical: 14),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ทั้งหมด',
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.black54),
                                          ),
                                          Text(
                                            '฿' + walletctrl.text,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 22, vertical: 12),
                                      child: Container(
                                        width: double.infinity,
                                        height: 46,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            final String? userId =
                                                prefs.getString('username');
                                            var url =
                                                "https://mtwa.xyz/API/e-pay?id=" +
                                                    userId! +
                                                    "&total=" +
                                                    walletctrl.text +
                                                    "&type=IW";
                                            launch(url);
                                            setState(() async {
                                              await Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              LoadingAccScreen(
                                                                pageKey:
                                                                    'wallet',
                                                                pageKey2:
                                                                    pageKey2,
                                                              )));
                                            });
                                          },
                                          child: Text('เติมเงิน'),
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                Colors.cyanAccent[700],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
