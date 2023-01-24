import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/attraction_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RecommendedAttractionsScreen extends StatefulWidget {
  const RecommendedAttractionsScreen({Key? key}) : super(key: key);
  @override
  _RecommendedAttractionsScreenState createState() =>
      _RecommendedAttractionsScreenState();
}

class _RecommendedAttractionsScreenState
    extends State<RecommendedAttractionsScreen> {
  @override
  void initState() {
    super.initState();
    // recattraction().whenComplete(() {
    //   setState(() {});
    // });
  }

  List<Attraction> attractions = <Attraction>[];
  var resultAttraction;
  bool statusData = false;

  recattraction() async {
    var url = "https://mtwa.xyz/API/recommend-location";
    await http.get(Uri.parse(url)).then((response) {
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
    return Container(
        width: double.infinity,
        height: 245,
        child: FutureBuilder(
          future: recattraction(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: attractions.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingAttractionScreen(
                                    pageKey: 'detail',
                                    productKey: '${attractions[index].id}',
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 130.sp,
                                    height: 100.sp,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https://mtwa.xyz/storage/app/public/location/thumbnail/' +
                                                attractions[index].image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 2,
                                    child: LikeWidget(
                                      itemId: '${attractions[index].id}',
                                      type: 'A',
                                      color: 'W',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 130.sp,
                                    height: 70.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 85.sp,
                                            height: 53.sp,
                                            // color: Colors.redAccent.withOpacity(0.2),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  attractions[index].name,
                                                  style: TextStyle(
                                                      fontSize: 10.5.sp),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    SvgPicture.asset(
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          launch(
                                                              attractions[index]
                                                                  .location);
                                                        },
                                                        child: Text(
                                                          'สถานที่ตั้ง',
                                                          style: TextStyle(
                                                              color: ColorResources
                                                                  .KTextLightBlue,
                                                              fontSize: 7.5.sp),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
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
                                                        fontSize: 6.5.sp),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                attractions[index]
                                                    .rating
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue[900],
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
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
  }
}
