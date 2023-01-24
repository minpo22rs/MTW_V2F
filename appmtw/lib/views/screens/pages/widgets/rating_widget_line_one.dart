import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtw_project/models/rating_line_one.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RatingWidgetLineOne extends StatefulWidget {
  final List onelinecon;
  const RatingWidgetLineOne({
    Key? key,
    required this.onelinecon,
  }) : super(key: key);

  @override
  _RatingWidgetLineOneState createState() =>
      _RatingWidgetLineOneState(onelinecon);
}

class _RatingWidgetLineOneState extends State<RatingWidgetLineOne> {
  late List onelinecon;
  _RatingWidgetLineOneState(this.onelinecon);
  @override
  void initState() {
    super.initState();
    // top1contestant().whenComplete(() {
    //   setState(() {});
    // });
  }

  // List<RatingLineone> onelinecon = <RatingLineone>[];
  // var resultData4;
  // bool statusData = false;

  // Future<Null> top1contestant() async {
  //   var url = "https://mtwa.xyz/API/contestant-top9";
  //   await http.get(Uri.parse(url)).then((response) {
  //     print('this response = ${response.body}');
  //     var result1 = jsonDecode(response.body);
  //     resultData4 = result1;
  //     // print('Length = ${result.length} ');
  //     onelinecon = <RatingLineone>[];
  //     print('Length ====== ${resultData4.length}');
  //     for (var j = 0; j < resultData4.length; j++) {
  //       RatingLineone d = RatingLineone.fromJson(resultData4[j]);
  //       onelinecon.add(d);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: 105,
      child: ListView.builder(
        itemCount: onelinecon.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://mtwa.xyz/storage/app/public/user/' +
                          '${onelinecon[index].image}'),
                  radius: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'อันดับที่ ' + '${onelinecon[index].no_row}',
                          style: GoogleFonts.kanit(fontSize: 6.5.sp),
                        ),
                        Stack(
                          children: [
                            Text(
                              '${onelinecon[index].city}',
                              style: GoogleFonts.kanit(
                                fontSize: 5.5.sp,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1.5
                                  ..color = ColorResources.KTextWhite,
                              ),
                            ),
                            Text(
                              '${onelinecon[index].city}',
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
                      '${onelinecon[index].fname}' +
                          ' ' +
                          '${onelinecon[index].lname}',
                      style: TextStyle(
                        fontSize: 6.5.sp,
                        color: ColorResources.KTextBlue,
                      ),
                    ),
                  ],
                ),
                Text(
                  NumberFormat('#,###.##')
                          .format(onelinecon[index].rating)
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
