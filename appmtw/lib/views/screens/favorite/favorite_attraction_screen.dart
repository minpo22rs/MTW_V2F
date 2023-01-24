import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/fav_attraction_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class FavAttracScreen extends StatefulWidget {
  const FavAttracScreen({
    Key? key,
  }) : super(key: key);
  @override
  _FavAttracScreenState createState() => _FavAttracScreenState();
}

class _FavAttracScreenState extends State<FavAttracScreen> {
  List<AttractionFav> attractionFav = <AttractionFav>[];
  var resultDataA;
  bool _isnewmodel = false;

  Future<Null> add_wishlists(var wishlist_id, var type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/add-wishlists";
    var data = {
      'userid': '${userId}',
      'wishlist_id': '${wishlist_id}',
      'type': '${type}'
    };
    await http.post(Uri.parse(url), body: data).then((value) async {
      var result = jsonDecode(value.body);
      if (result['status_wishlist'] == 'S') {
        Fluttertoast.showToast(
            msg: "เพิ่มในรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      } else if (result['status_wishlist'] == 'SD') {
        Fluttertoast.showToast(
            msg: "ลบออกจากรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      }
      var url = "https://mtwa.xyz/API/list-wishlists";
      var data = {'userid': '${userId}'};
      await http.post(Uri.parse(url), body: data).then((response) async {
        var result1 = jsonDecode(response.body);

        resultDataA = result1['a'];
        attractionFav = <AttractionFav>[];
        for (var i = 0; i < resultDataA.length; i++) {
          AttractionFav t = AttractionFav.fromJson(resultDataA[i]);
          attractionFav.add(t);
        }
        setState(() {
          _isnewmodel = true;
        });
      });
    });
  }

  favoritepage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/list-wishlists";
    var data = {'userid': '${userId}'};
    await http.post(Uri.parse(url), body: data).then((response) async {
      // rint('this response = ${response.body}');
      var result1 = jsonDecode(response.body);

      resultDataA = result1['a'];
      attractionFav = <AttractionFav>[];
      for (var i = 0; i < resultDataA.length; i++) {
        AttractionFav t = AttractionFav.fromJson(resultDataA[i]);
        attractionFav.add(t);
      }
    });

    return attractionFav;
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
                  'สถานที่ท่องเที่ยวยอดฮิต',
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
                      favoritepage(), // a previously-obtained Future<String> or null
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                          width: double.infinity,
                          height: 450,
                          color: Colors.white.withOpacity(0.2),
                          child: ListView.builder(
                              itemCount: attractionFav.length,
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
                                                      '${attractionFav[index].id}',
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
                                                              attractionFav[
                                                                      index]
                                                                  .image),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 2,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: ColorResources
                                                          .ICON_Red,
                                                      size: 15.sp,
                                                    ),
                                                    onPressed: () {
                                                      add_wishlists(
                                                          attractionFav[index]
                                                              .id,
                                                          'A');
                                                    },
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
                                                                attractionFav[
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
                                                                      attractionFav[
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
                                                                  attractionFav[
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
                                                              attractionFav[
                                                                      index]
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
                                                                      '${attractionFav[index].id}',
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
