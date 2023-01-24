import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/models/fav_attraction_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class MemAttracScreen extends StatefulWidget {
  const MemAttracScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MemAttracScreenState createState() => _MemAttracScreenState();
}

class _MemAttracScreenState extends State<MemAttracScreen> {
  List<Attraction> attraction = <Attraction>[];
  var resultDataA;
  bool _isnewmodel = false;

  attractionpage() async {
    var url = "https://mtwa.xyz/API/attraction-member";
    await http.get(Uri.parse(url)).then((response) async {
      var result1 = jsonDecode(response.body);
      resultDataA = result1;
      attraction = <Attraction>[];

      for (var j = 0; j < resultDataA.length; j++) {
        Attraction d = Attraction.fromJson(resultDataA[j]);
        attraction.add(d);
      }
    });
    return attraction;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'สถานที่ท่องเที่ยวโดยนางงาม',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )),
        Expanded(
            flex: 12,
            child: Container(
              child: FutureBuilder(
                  future:
                      attractionpage(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                          width: double.infinity,
                          height: 450,
                          color: Colors.white.withOpacity(0.2),
                          child: ListView.builder(
                              itemCount: attraction.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoadingAttractionScreen(
                                                  pageKey: 'detail',
                                                  productKey:
                                                      '${attraction[index].id}',
                                                )));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://mtwa.xyz/storage/app/public/location/thumbnail/' +
                                                              attraction[index]
                                                                  .image),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 2,
                                                  child: LikeWidget(
                                                    itemId:
                                                        '${attraction[index].id}',
                                                    type: 'A',
                                                    color: 'W',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 260.sp,
                                                  height: 70.sp,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                                attraction[
                                                                        index]
                                                                    .name,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10.5.sp),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
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
                                                                  SvgPicture
                                                                      .asset(
                                                                    'assets/icons/location.svg',
                                                                    width: 14,
                                                                    height: 14,
                                                                    color: ColorResources
                                                                        .ICON_Red,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Expanded(
                                                                    // width: 65.sp,
                                                                    // color: Colors.amberAccent,
                                                                    child: Text(
                                                                      attraction[
                                                                              index]
                                                                          .location,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              7.5.sp),
                                                                      maxLines:
                                                                          1,
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
                                                                  attraction[
                                                                          index]
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
                                                              attraction[index]
                                                                  .rating
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blue[900],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 2,
                                                            ),
                                                            Container(
                                                                width: 35.sp,
                                                                // color: Colors.black.withOpacity(0.2),
                                                                child:
                                                                    StarWidget(
                                                                  sizestar: '7',
                                                                  sId:
                                                                      '${attraction[index].id}',
                                                                  type:
                                                                      'attrac',
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
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                );
                              }));
                    }
                  }),
            ))
      ],
    );
  }
}
