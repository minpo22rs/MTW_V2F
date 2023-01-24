import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ScoreOne extends StatefulWidget {
  final String sId, type;
  const ScoreOne({Key? key, required this.sId, required this.type})
      : super(key: key);

  @override
  _ScoreOneState createState() => _ScoreOneState(sId, type);
}

class _ScoreOneState extends State<ScoreOne> {
  late String sId, type;
  _ScoreOneState(this.sId, this.type);
  late double rate = 0.0;
  TextEditingController reviewctrl = TextEditingController();
  var ownner;
  ownreview() async {
    var link = "https://mtwa.xyz/API/own-review";
    var data = {'sId': sId, 'type': type};
    await http.post(Uri.parse(link), body: data).then((value) {
      ownner = jsonDecode(value.body);
    });
    return ownner;
  }

  var ownLink;

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
        title: Text(
          'ให้คะแนน',
          style: TextStyle(
            color: ColorResources.ICON_Black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 18, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: ownreview(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (type == 'R' || type == 'H') {
                        ownLink =
                            'https://mtwa.xyz/storage/app/public/seller/thumbnail/';
                      } else if (type == 'A') {
                        ownLink =
                            'https://mtwa.xyz/storage/app/public/location/thumbnail/';
                      }
                      return Row(
                        children: [
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(ownLink + ownner['image']),
                                  fit: BoxFit.fill,
                                ),
                                color: Colors.redAccent.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ownner['name'],
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            Container(
              width: 235,
              height: 55,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (double value) {
                      rate = value;
                      print('star: ${rate}');
                    },
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.grey,
            ),
            // SizedBox(height: 12),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         print('รูปภาพ');
            //       },
            //       child: Container(
            //         width: 85,
            //         height: 85,
            //         color: Colors.black12,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'รูปภาพ',
            //             ),
            //             SizedBox(
            //               height: 6,
            //             ),
            //             SvgPicture.asset(
            //               'assets/icons/plus.svg',
            //               width: 20,
            //               height: 20,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 6),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 245,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    maxLines: 6,
                    controller: reviewctrl,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(
                          left: 15, bottom: 11, top: 11, right: 15),
                      hintText: 'ใส่ข้อความของคุณ',
                    ),
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorResources.KTextLightBlue,
                          ),
                          onPressed: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final String? userId = prefs.getString('username');
                            var link = "https://mtwa.xyz/API/form-review";
                            var review = {
                              'sId': sId,
                              'uId': userId,
                              'type': type,
                              'review': reviewctrl.text,
                              'rating': '${rate}',
                            };
                            print(review);
                            await http
                                .post(Uri.parse(link), body: review)
                                .then((value) {
                              var result = jsonDecode(value.body);
                              if (result['statuspost'] == '1') {
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "ขอบคุณสำหรับการรีวิวค่ะ",
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT);
                              } else if (result['statuspost'] == '2') {
                                Fluttertoast.showToast(
                                    msg:
                                        "เกิดข้อผผิดำลาดกรุณาติดต่อผู้ดูแลระบบ",
                                    gravity: ToastGravity.CENTER,
                                    toastLength: Toast.LENGTH_SHORT);
                              }
                            });
                          },
                          child: Text('ริวิว'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
