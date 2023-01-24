import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mtw_project/models/slidable_action.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class VouchersRestautantScreen extends StatefulWidget {
  final String sellerId, title;
  const VouchersRestautantScreen(
      {Key? key, required this.sellerId, required this.title})
      : super(key: key);

  @override
  _VouchersRestautantScreenState createState() =>
      _VouchersRestautantScreenState(sellerId, title);
}

class _VouchersRestautantScreenState extends State<VouchersRestautantScreen> {
  late String sellerId, title;
  _VouchersRestautantScreenState(this.sellerId, this.title);
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('สร้าง order สั่งซื้อ Vouchers สำเร็จ'),
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

  var detail;
  listcartrestaurant() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/carts-restaurant-list";
    var data = {'seller': '${userId}'};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        detail = jsonDecode(response.body);
      }
      print(sellerId);
    });
    return detail;
  }

  @override
  Widget build(BuildContext context) {
    bool valueswitch = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () async {
            var url = 'https://mtwa.xyz/API/carts-restaurant-delete';
            var data = {'cartId': '${detail['c_id']}'};
            await http.post(Uri.parse(url), body: data).then(
              (value) {
                var result = jsonDecode(value.body);
                if (result['status_del'] == '1') {
                  Navigator.pop(context);
                }
              },
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: ColorResources.KTextBlack, fontSize: 16.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รายการVouchers',
                    style: TextStyle(
                      color: ColorResources.KTextBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: listcartrestaurant(),
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
                      Divider(height: 1, thickness: 1),
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.15,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    detail['qty'].toString() + 'x',
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 14),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detail['name'],
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          detail['details'],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  if (detail['unit_price'] != null) ...[
                                    Text('฿',
                                        style: TextStyle(
                                            color: ColorResources.KTextGray,
                                            fontSize: 8.sp)),
                                    Text(
                                      NumberFormat('#,###.##')
                                          .format(detail['unit_price']),
                                      style: TextStyle(
                                          color: ColorResources.KTextGray,
                                          fontSize: 11.sp),
                                    ),
                                    Text(' '),
                                  ],
                                  Text('฿',
                                      style: TextStyle(
                                          color: ColorResources.KTextRed,
                                          fontSize: 8.sp)),
                                  Text(
                                    NumberFormat('#,###.##')
                                        .format(detail['purchase_price']),
                                    style: TextStyle(
                                        color: ColorResources.KTextRed,
                                        fontSize: 11.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      SizedBox(height: 25),
                      Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.ac_unit),
                                SizedBox(width: 4),
                                Text('โค้ดส่วนลด'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('เลือกโค้ดส่วนลด'),
                                Icon(Icons.arrow_forward_ios_rounded)
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.monetization_on_outlined),
                                Text('คุณมีคะแนนไม่พอ'),
                              ],
                            ),
                            Row(
                              children: [
                                CupertinoSwitch(
                                    value: valueswitch,
                                    onChanged: (value) {
                                      setState(() {
                                        valueswitch = !valueswitch;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 11),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('รวมค่าVouchers'),
                                        // Row(
                                        //   children: [
                                        //     Text('ส่วนลด '),
                                        //     Text(
                                        //       'ชื่อส่วนลด',
                                        //       style: TextStyle(
                                        //         color: Colors.cyan[400],
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '฿ ',
                                              style: TextStyle(fontSize: 7.sp),
                                            ),
                                            Text(
                                              NumberFormat('#,###.##')
                                                  .format(detail['total']),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       '฿ ',
                                        //       style: TextStyle(fontSize: 7.sp),
                                        //     ),
                                        //     Text('10'),
                                        //   ],
                                        // ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(thickness: 1),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('รวมทั้งหมด'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('฿ '),
                                    Text(NumberFormat('#,###.##')
                                        .format(detail['total'])),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 14),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ชำระเงินโดย'),
                                SizedBox(height: 12),
                              ],
                            ),
                            Text('Pay Solutions'),
                          ],
                        ),
                      ),
                      Divider(thickness: 1),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 6, horizontal: 16),
                      //   child: Row(
                      //     children: [
                      //       Text('คุณจะได้รับคะแนน '),
                      //       Text('xxx'),
                      //       Text(' คะแนน'),
                      //     ],
                      //   ),
                      // ),
                      // Divider(thickness: 1),
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorResources.BG_Blue,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                final String? userId =
                                    prefs.getString('username');
                                var url = "https://mtwa.xyz/API/e-pay?id=" +
                                    userId! +
                                    "&total=" +
                                    '${detail['total']}' +
                                    "&type=R" +
                                    "&cartId=" +
                                    '${detail['c_id']}';
                                // print(url);
                                launch(url);
                                setState(() {
                                  Navigator.pop(context);
                                  _showMyDialog();
                                });
                              },
                              child: Text(
                                'ชำระเงิน',
                                style: TextStyle(
                                  fontSize: 11.5.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      // Container(
                      //   margin: EdgeInsets.symmetric(horizontal: 14),
                      //   width: double.infinity,
                      //   height: 50,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: ColorResources.ICON_Red,
                      //   ),
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () async {
                      //           var url =
                      //               'https://mtwa.xyz/API/carts-restaurant-delete';
                      //           var data = {'cartId': '${detail['c_id']}'};
                      //           await http
                      //               .post(Uri.parse(url), body: data)
                      //               .then(
                      //             (value) {
                      //               var result = jsonDecode(value.body);
                      //               if (result['status_del'] == '1') {
                      //                 Navigator.pop(context);
                      //               }
                      //             },
                      //           );
                      //         },
                      //         child: Text(
                      //           'ยกเลิก',
                      //           style: TextStyle(
                      //             fontSize: 11.5.sp,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 55),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void onDismissed(int index, SlidableAction action) {
    setState(() {});
  }
}
