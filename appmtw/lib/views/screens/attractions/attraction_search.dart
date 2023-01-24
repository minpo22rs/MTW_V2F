import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AttracSearch extends StatefulWidget {
  final String searchKey;
  AttracSearch({Key? key, required this.searchKey}) : super(key: key);
  @override
  _AttracSearchState createState() => _AttracSearchState(searchKey);
}

class _AttracSearchState extends State<AttracSearch> {
  late String searchKey;
  _AttracSearchState(this.searchKey);
  List<Attraction> attractions = <Attraction>[];

  var resultAttraction;
  attracSearch() async {
    var link = "https://mtwa.xyz/API/search-everything";
    var data = {'keyword': '${searchKey}', 'type': 'A'};
    await http.post(Uri.parse(link), body: data).then((response) {
      var result1 = jsonDecode(response.body);
      resultAttraction = result1;
      attractions = <Attraction>[];
      for (var j = 0; j < resultAttraction.length; j++) {
        Attraction d = Attraction.fromJson(resultAttraction[j]);
        attractions.add(d);
      }
    });
    return attractions;
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
          'สถานที่ท่องเที่ยว',
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
            future: attracSearch(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Container(
                  width: double.infinity,
                  height: 450,
                  color: Colors.white.withOpacity(0.2),
                  child: ListView.builder(
                      itemCount: attractions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoadingAttractionScreen(
                                                pageKey: 'detail',
                                                productKey:
                                                    '${attractions[index].id}',
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 130.sp,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12)),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://mtwa.xyz/storage/app/public/location/thumbnail/' +
                                                        attractions[index]
                                                            .image),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 260.sp,
                                            height: 70.sp,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    width: 85.sp,
                                                    height: 53.sp,
                                                    // color: Colors.redAccent.withOpacity(0.2),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          attractions[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  10.5.sp),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 2,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            SvgPicture.asset(
                                                              'assets/icons/location.svg',
                                                              width: 14,
                                                              height: 14,
                                                              color:
                                                                  ColorResources
                                                                      .ICON_Red,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Expanded(
                                                              // width: 65.sp,
                                                              // color: Colors.amberAccent,
                                                              child: Text(
                                                                attractions[
                                                                        index]
                                                                    .location,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        7.5.sp),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Container(
                                                          width: 110,
                                                          height: 25,
                                                          // color:
                                                          //     Colors.redAccent.withOpacity(0.4),
                                                          child: Text(
                                                            attractions[index]
                                                                .description,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    6.5.sp),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        attractions[index]
                                                            .rating
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color:
                                                              Colors.blue[900],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Container(
                                                          width: 35.sp,
                                                          // color: Colors.black.withOpacity(0.2),
                                                          child: StarWidget(
                                                            sizestar: '7',
                                                            sId:
                                                                '${attractions[index].id}',
                                                            type: 'attrac',
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      }));
            },
          )
        ],
      ),
    );
  }
}
