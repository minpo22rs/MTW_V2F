import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/rating_line_two.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RatingWidgetLineTwo extends StatefulWidget {
  final List twolinecon;
  const RatingWidgetLineTwo({
    Key? key,
    required this.twolinecon,
  }) : super(key: key);

  @override
  _RatingWidgetLineTwoState createState() =>
      _RatingWidgetLineTwoState(twolinecon);
}

class _RatingWidgetLineTwoState extends State<RatingWidgetLineTwo> {
  late List twolinecon;
  _RatingWidgetLineTwoState(this.twolinecon);
  @override
  void initState() {
    super.initState();
    // top1contestant().whenComplete(() {
    //   setState(() {});
    // });
  }

  // List<RatingLineTwo> twolinecon = <RatingLineTwo>[];
  // var resultData5;
  // bool statusData = false;

  // Future<Null> top1contestant() async {
  //   var url = "https://mtwa.xyz/API/contestant-top15";
  //   await http.get(Uri.parse(url)).then((response) {
  //     print('this response = ${response.body}');
  //     var result1 = jsonDecode(response.body);
  //     resultData5 = result1;
  //     // print('Length = ${result.length} ');
  //     twolinecon = <RatingLineTwo>[];
  //     print('Length ====== ${resultData5.length}');
  //     for (var j = 0; j < resultData5.length; j++) {
  //       RatingLineTwo d = RatingLineTwo.fromJson(resultData5[j]);
  //       twolinecon.add(d);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: twolinecon.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://mtwa.xyz/storage/app/public/user/' +
                          '${twolinecon[index].image}'),
                  radius: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'อันดับที่ ' + '${twolinecon[index].no_row}',
                          style: GoogleFonts.kanit(
                              fontSize: 6.5.sp,
                              color: ColorResources.KTextWhite),
                        ),
                        Stack(
                          children: [
                            Text(
                              '${twolinecon[index].city}',
                              style: GoogleFonts.kanit(
                                fontSize: 5.5.sp,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = ColorResources.KTextWhite,
                              ),
                            ),
                            Text(
                              '${twolinecon[index].city}',
                              style: GoogleFonts.kanit(
                                  fontSize: 5.5.sp,
                                  color: ColorResources.KTextBlack),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text(
                      '${twolinecon[index].fname}' +
                          ' ' +
                          '${twolinecon[index].lname}',
                      style: TextStyle(
                        fontSize: 6.5.sp,
                        color: ColorResources.KTextBlue,
                      ),
                    ),
                  ],
                ),
                Text(
                  NumberFormat('#,###.##')
                          .format(twolinecon[index].rating)
                          .toString() +
                      ' คะแนน',
                  style: TextStyle(
                    fontSize: 7.sp,
                    color: ColorResources.KTextBlue,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
