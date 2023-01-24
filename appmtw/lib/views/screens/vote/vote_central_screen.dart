import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtw_project/models/member_model.dart';
import 'package:mtw_project/models/rating_line_one.dart';
import 'package:mtw_project/models/rating_line_two.dart';
import 'package:mtw_project/models/rating_one_model.dart';
import 'package:mtw_project/models/rating_two_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_vote_screen.dart';
import 'package:mtw_project/views/screens/vote/select_vote_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VoteCentralScreen extends StatefulWidget {
  final String region, region2, wallet, pageKey;
  const VoteCentralScreen(
      {Key? key,
      required this.region,
      required this.region2,
      required this.wallet,
      required this.pageKey})
      : super(key: key);

  @override
  _VoteCentralScreenState createState() =>
      _VoteCentralScreenState(region, region2, wallet, pageKey);
}

class _VoteCentralScreenState extends State<VoteCentralScreen> {
  late String region, region2, wallet, pageKey;
  _VoteCentralScreenState(this.region, this.region2, this.wallet, this.pageKey);

  List<RatingOne> onecon = <RatingOne>[];
  var resultData2;

  List<RatingTwo> twocon = <RatingTwo>[];
  var resultData3;

  List<RatingLineone> onelinecon = <RatingLineone>[];
  var resultData4;

  List<RatingLineTwo> twolinecon = <RatingLineTwo>[];
  var resultData5;
  List<Member> mem = <Member>[];
  var resultMem;

  memberCentral() async {
    var link = "https://mtwa.xyz/API/contestant-regions-member";
    var data = {
      'keyword': '${region2}',
    };
    await http.post(Uri.parse(link), body: data).then((response) {
      var result1 = jsonDecode(response.body);
      resultMem = result1;
      mem = <Member>[];
      for (var j = 0; j < resultMem.length; j++) {
        Member d = Member.fromJson(resultMem[j]);
        mem.add(d);
      }
    });
    return mem;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildqueen() {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: FutureBuilder(
            future: memberCentral(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mem.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            width: double.maxFinite,
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 80,
                                    // color: Colors.amberAccent,
                                    child: Center(
                                      child: Text(
                                        '${mem[index].m_id}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff005476),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    // color: Colors.amberAccent,
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundImage: NetworkImage(
                                                  'https://mtwa.xyz/storage/app/public/user/' +
                                                      '${mem[index].image}'),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${mem[index].fname}' +
                                                  ' ' +
                                                  '${mem[index].lname}',
                                              style: TextStyle(fontSize: 9.sp),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              mem[index].city,
                                              style: TextStyle(fontSize: 9.sp),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              'คะแนนโหวต ' +
                                                  NumberFormat('#,###.##')
                                                      .format(mem[index].rating)
                                                      .toString() +
                                                  ' คะแนน',
                                              style: TextStyle(fontSize: 9.sp),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    // color: Colors.amberAccent,
                                    child: FlatButton(
                                      onPressed: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        final String? userId =
                                            prefs.getString('username');
                                        var url_2 =
                                            "https://mtwa.xyz/API/account-detail";
                                        var data_2 = {'userid': userId};
                                        await http
                                            .post(Uri.parse(url_2),
                                                body: data_2)
                                            .then((value) async {
                                          var result2 = jsonDecode(value.body);
                                          var check = result2['free_vote'];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectVoteScreen(
                                                mem_id: '${mem[index].id}',
                                                check: '${check}',
                                              ),
                                            ),
                                          );
                                        });
                                      },
                                      color: Colors.cyan[600],
                                      child: Text(
                                        'โหวต',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () async {
              // if (pageKey == 'Main') {
              //   final SharedPreferences prefs =
              //       await SharedPreferences.getInstance();
              //   final String? userId = prefs.getString('username');
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => LoadingScreen(
              //                 userid: '${userId}',
              //               )));
              // } else if (pageKey == 'Screen') {
              //   final SharedPreferences prefs =
              //       await SharedPreferences.getInstance();
              //   final String? userId = prefs.getString('username');
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => LoadingVoteScreen()));
              // }
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorResources.ICON_Gray,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Vote',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        // backgroundColor: Colors.white38,
      ),
      body: Column(
        children: [
          //SearchWidget(),
          SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                region,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildqueen(),
          // _buildqueen(),
          // _buildqueen(),
          // _buildqueen(),
        ],
      ),
    );
  }
}

// Container(
//                         color: Colors.amberAccent,
//                         width: 100.sp,
//                         height: 60.sp,
//                         child: ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: 1,
//                             itemBuilder: (BuildContext context, int index) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'ชื่อนางงาม',
//                                     style: TextStyle(fontSize: 9.sp),
//                                   ),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   Text(
//                                     'จังหวัด',
//                                     style: TextStyle(fontSize: 9.sp),
//                                   ),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   Text(
//                                     'คะแนนโหวต',
//                                     style: TextStyle(fontSize: 9.sp),
//                                   ),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   Text(
//                                     'ประวัติเพิ่มเติม',
//                                     style: TextStyle(fontSize: 9.sp),
//                                   ),
//                                 ],
//                               );
//                             }),
//                       )
