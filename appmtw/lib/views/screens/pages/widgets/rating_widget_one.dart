import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RatingWidgetOne extends StatefulWidget {
  final List onecon;
  const RatingWidgetOne({
    Key? key,
    required this.onecon,
  }) : super(key: key);

  @override
  _RatingWidgetOneState createState() => _RatingWidgetOneState(onecon);
}

class _RatingWidgetOneState extends State<RatingWidgetOne> {
  late List onecon;
  _RatingWidgetOneState(this.onecon);
  @override
  void initState() {
    super.initState();
    // top1contestant().whenComplete(() {
    //   setState(() {});
    // });
  }

  List<RatingOne> onecono = <RatingOne>[];
  var resultData2;
  bool statusData = false;

  Future<Null> top1contestant() async {
    var url = "https://mtwa.xyz/API/contestant-top1";
    await http.get(Uri.parse(url)).then((response) {
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultData2 = result1;
      // print('Length = ${result.length} ');
      onecono = <RatingOne>[];
      print('Length ====== ${resultData2.length}');
      for (var j = 0; j < resultData2.length; j++) {
        RatingOne d = RatingOne.fromJson(resultData2[j]);
        onecono.add(d);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 155,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: onecon.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://mtwa.xyz/storage/app/public/user/' +
                              '${onecon[index].image}'),
                      radius: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'อันดับที่ ' + '${onecon[index].no_row}',
                              style: GoogleFonts.kanit(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: ColorResources.KTextWhite,
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  '${onecon[index].city}',
                                  style: GoogleFonts.kanit(
                                    fontSize: 9.sp,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = ColorResources.KTextWhite,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  '${onecon[index].city}',
                                  style: GoogleFonts.kanit(
                                    fontSize: 9.sp,
                                    color: ColorResources.KTextBlack,
                                  ),
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
                    Text(
                      '${onecon[index].fname}' + ' ' + '${onecon[index].lname}',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: ColorResources.KTextBlue,
                      ),
                    ),
                    Text(
                      NumberFormat('#,###.##')
                              .format(onecon[index].rating)
                              .toString() +
                          ' คะแนน',
                      style: TextStyle(
                        fontSize: 10.5.sp,
                        color: ColorResources.KTextBlue,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
