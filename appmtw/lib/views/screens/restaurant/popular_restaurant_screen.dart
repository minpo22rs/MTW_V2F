import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/restaurant_model.dart';
import 'package:mtw_project/models/vouchers_restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/poppular_restaurant_widget.dart';
import 'package:mtw_project/views/screens/restaurant/select_restaurant_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularRestaurantScreen extends StatefulWidget {
  const PopularRestaurantScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PopularRestaurantScreenState createState() =>
      _PopularRestaurantScreenState();
}

class _PopularRestaurantScreenState extends State<PopularRestaurantScreen> {
  List<VouchersRes> vouchers = <VouchersRes>[];
  var resultData;
  @override
  void initState() {
    super.initState();
    // recRestaurant().whenComplete(() {
    //   setState(() {});
    // });
  }

  List<Restaurant> restaurants = <Restaurant>[];
  var resultRestaurant;
  bool statusData = false;

  recRestaurant() async {
    var url = "https://mtwa.xyz/API/recommend-restaurant";
    await http.get(Uri.parse(url)).then((response) {
      var result1 = jsonDecode(response.body);
      resultRestaurant = result1;
      restaurants = <Restaurant>[];
      for (var j = 0; j < resultRestaurant.length; j++) {
        Restaurant d = Restaurant.fromJson(resultRestaurant[j]);
        restaurants.add(d);
      }
    });
    return restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230,
      color: Colors.white,
      child: FutureBuilder(
        future: recRestaurant(),
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
            itemCount: restaurants.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        var url = "https://mtwa.xyz/API/restaurant-detail";
                        var data = {'res_id': '${restaurants[index].id}'};
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
                          Stack(
                            children: [
                              Container(
                                width: 130.sp,
                                height: 95.sp,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                            restaurants[index].image),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: LikeWidget(
                                  itemId: '${restaurants[index].id}',
                                  type: 'R',
                                  color: 'W',
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 130.sp,
                                // color: Colors.redAccent.withOpacity(0.2),
                                height: 65.sp,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
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
                                              restaurants[index].name,
                                              style:
                                                  TextStyle(fontSize: 10.5.sp),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
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
                                                  color:
                                                      ColorResources.ICON_Red,
                                                  width: 14,
                                                  height: 14,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      launch(restaurants[index]
                                                          .location);
                                                    },
                                                    child: Text(
                                                      'สถานที่ตั้ง',
                                                      style: TextStyle(
                                                          color: ColorResources
                                                              .KTextLightBlue,
                                                          fontSize: 7.5.sp),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              restaurants[index].description,
                                              style:
                                                  TextStyle(fontSize: 6.5.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            restaurants[index]
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
                                                      '${restaurants[index].id}',
                                                  type: 'restaurant'))
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
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
