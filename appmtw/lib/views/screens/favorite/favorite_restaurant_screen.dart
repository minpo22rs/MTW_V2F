import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/fav_restaurant_model.dart';
import 'package:mtw_project/models/vouchers_restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/select_restaurant_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class FavResScreen extends StatefulWidget {
  const FavResScreen({Key? key}) : super(key: key);
  @override
  _FavResScreenState createState() => _FavResScreenState();
}

class _FavResScreenState extends State<FavResScreen> {
  List<RestaurantFav> restaurantFav = <RestaurantFav>[];
  var resultDataR;
  bool _isnewmodel = false;

  @override
  void initState() {
    super.initState();
  }

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

        resultDataR = result1['r'];
        restaurantFav = <RestaurantFav>[];
        for (var i = 0; i < resultDataR.length; i++) {
          RestaurantFav t = RestaurantFav.fromJson(resultDataR[i]);
          restaurantFav.add(t);
        }
        setState(() {
          _isnewmodel = true;
          favoritepage();
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

      resultDataR = result1['r'];
      restaurantFav = <RestaurantFav>[];
      for (var i = 0; i < resultDataR.length; i++) {
        RestaurantFav t = RestaurantFav.fromJson(resultDataR[i]);
        restaurantFav.add(t);
      }
    });

    return restaurantFav;
  }

  List<VouchersRes> vouchers = <VouchersRes>[];
  var resultData;

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

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
                  'ร้านอาหาร',
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
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // mainAxisSpacing: 20,
                          // crossAxisSpacing: 10,
                        ),
                        itemCount: restaurantFav.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              var url =
                                  "https://mtwa.xyz/API/restaurant-detail";
                              var data = {
                                'res_id': '${restaurantFav[index].id}'
                              };
                              await http
                                  .post(Uri.parse(url), body: data)
                                  .then((response) {
                                var result = jsonDecode(response.body);
                                if (response.statusCode == 200) {
                                  resultData = result['vr'];
                                  vouchers = <VouchersRes>[];
                                  for (var i = 0; i < resultData.length; i++) {
                                    VouchersRes t =
                                        VouchersRes.fromJson(resultData[i]);
                                    vouchers.add(t);
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SelectRestaurantScreen(
                                                id: '${result['restaurant']['id']}',
                                                name:
                                                    '${result['restaurant']['shopname']}',
                                                image:
                                                    '${result['restaurant']['image']}',
                                                location:
                                                    '${result['restaurant']['position_url']}',
                                                open:
                                                    '${result['restaurant']['open_time']}',
                                                close:
                                                    '${result['restaurant']['close_time']}',
                                                vouchers: vouchers,
                                                rating:
                                                    '${result['restaurant']['rating']}',
                                              )));
                                } else {
                                  return;
                                }
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  children: [
                                    Container(
                                      width: 140.sp,
                                      height: 75.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                                  restaurantFav[index].image),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 10,
                                      top: 10,
                                      child: GestureDetector(
                                        onTap: () {
                                          add_wishlists(
                                              restaurantFav[index].id, 'R');
                                        },
                                        child: Icon(
                                          Icons.favorite_rounded,
                                          color: ColorResources.ICON_Red,
                                          size: 16.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Container(
                                        width: 140.sp,
                                        // color:
                                        //     Colors.redAccent.withOpacity(0.2),
                                        height: 65.sp,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                // width: 85.sp,
                                                // height: 53.sp,
                                                // color: Colors.redAccent.withOpacity(0.2),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      restaurantFav[index].name,
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
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        SvgPicture.asset(
                                                          'assets/icons/location.svg',
                                                          color: ColorResources
                                                              .ICON_Red,
                                                          width: 14,
                                                          height: 14,
                                                        ),
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            restaurantFav[index]
                                                                .location,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    7.5.sp),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      restaurantFav[index]
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 6.5.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    restaurantFav[index]
                                                        .rating
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 11.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            '${restaurantFav[index].id}',
                                                        type: 'restaurant',
                                                      ))
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ))
      ],
    );
  }
}
