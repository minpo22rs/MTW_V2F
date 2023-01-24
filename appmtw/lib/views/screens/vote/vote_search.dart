import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/member_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/vote/select_vote_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class VoteSearch extends StatefulWidget {
  final String searchKey;
  VoteSearch({Key? key, required this.searchKey}) : super(key: key);
  @override
  _VoteSearchState createState() => _VoteSearchState(searchKey);
}

class _VoteSearchState extends State<VoteSearch> {
  late String searchKey;
  _VoteSearchState(this.searchKey);
  List<Member> mem = <Member>[];
  var resultMem;
  memSearch() async {
    var link = "https://mtwa.xyz/API/search-everything";
    var data = {'keyword': '${searchKey}', 'type': 'V'};
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
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'Vote',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 20, top: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.search,
                  size: 15.sp,
                  color: ColorResources.KTextBlue,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'ค้นหา: " ${searchKey} "',
                  style: TextStyle(
                    color: ColorResources.KTextBlue,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          FutureBuilder(
            future: memSearch(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
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
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  // color: Colors.amberAccent,
                                  child: FlatButton(
                                    onPressed: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      final String? userId =
                                          prefs.getString('username');
                                      var url_2 =
                                          "https://mtwa.xyz/API/account-detail";
                                      var data_2 = {'userid': userId};
                                      await http
                                          .post(Uri.parse(url_2), body: data_2)
                                          .then((value) async {
                                        var result2 = jsonDecode(value.body);
                                        var check = result2['free_vote'];
                                        print('${check} & ${mem[index].id}');
                                        await Navigator.push(
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
            },
          ),
        ],
      ),
    );
  }
}
