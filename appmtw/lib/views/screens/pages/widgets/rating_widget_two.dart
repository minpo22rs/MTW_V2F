import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/rating_two_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class RatingWidgetTwo extends StatefulWidget {
  final List twocon;
  const RatingWidgetTwo({
    Key? key,
    required this.twocon,
  }) : super(key: key);

  @override
  _RatingWidgetTwoState createState() => _RatingWidgetTwoState(twocon);
}

class _RatingWidgetTwoState extends State<RatingWidgetTwo> {
  late List twocon;
  late String twoconlength;
  _RatingWidgetTwoState(this.twocon);
  @override
  void initState() {
    super.initState();
    // top1contestant().whenComplete(() {
    //   setState(() {});
    // });
    test();
  }

  Future<Null> test() async {
    print('..............');
    print(twocon);
    print('..............');
  }

  List<RatingTwo> twocono = <RatingTwo>[];
  var resultData3;
  bool statusData = false;

  Future<Null> top1contestant() async {
    var url = "https://mtwa.xyz/API/contestant-top3";
    await http.get(Uri.parse(url)).then((response) {
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultData3 = result1;
      // print('Length = ${result.length} ');
      twocono = <RatingTwo>[];
      print('Length ====== ${resultData3.length}');
      for (var j = 0; j < resultData3.length; j++) {
        RatingTwo d = RatingTwo.fromJson(resultData3[j]);
        twocono.add(d);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 160),
        physics: NeverScrollableScrollPhysics(),
        itemCount: twocon.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://mtwa.xyz/storage/app/public/user/' +
                          '${twocon[index].image}'),
                  radius: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 11),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'อันดับที่ ' + '${twocon[index].no_row}',
                          style: GoogleFonts.kanit(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w700,
                              color: ColorResources.KTextWhite),
                        ),
                        Stack(
                          children: [
                            Text(
                              '${twocon[index].city}',
                              style: GoogleFonts.kanit(
                                fontSize: 2.5.w,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 2
                                  ..color = ColorResources.KTextWhite,
                              ),
                            ),
                            Text(
                              '${twocon[index].city}',
                              style: GoogleFonts.kanit(
                                  fontSize: 2.5.w,
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
                Text(
                  '${twocon[index].fname}' + ' ' + '${twocon[index].lname}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: ColorResources.KTextBlue,
                  ),
                ),
                Text(
                  NumberFormat('#,###.##')
                          .format(twocon[index].rating)
                          .toString() +
                      ' คะแนน',
                  style: TextStyle(
                    fontSize: 10.5.sp,
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
