import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/fav_restaurant_model.dart';
import 'package:mtw_project/models/restaurant_model.dart';
import 'package:mtw_project/models/vouchers_restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:http/http.dart' as http;
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/select_restaurant_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantCScreen extends StatefulWidget {
  final String shopname, image, cId;
  RestaurantCScreen(
      {Key? key,
      required this.shopname,
      required this.image,
      required this.cId})
      : super(key: key);
  @override
  _RestaurantCScreenState createState() =>
      _RestaurantCScreenState(shopname, image, cId);
}

class _RestaurantCScreenState extends State<RestaurantCScreen> {
  late String shopname, image, cId;
  _RestaurantCScreenState(this.shopname, this.image, this.cId);
  List<Restaurant> products = <Restaurant>[];
  List<VouchersRes> vouchers = <VouchersRes>[];
  var resultData;
  var resultProduct;
  listResByCate() async {
    var link = "https://mtwa.xyz/API/product-by-cate";
    var data = {'cId': '${cId}'};
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultProduct = result;
      products = <Restaurant>[];
      for (var j = 0; j < resultProduct.length; j++) {
        Restaurant d = Restaurant.fromJson(resultProduct[j]);
        products.add(d);
      }
    });
    return products;
  }

  List<RestaurantFav> restaurantFav = <RestaurantFav>[];
  var resultDataR;
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
      print(result);
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
        print('this response = ${response.body}');
        var result1 = jsonDecode(response.body);

        resultDataR = result1['r'];
        restaurantFav = <RestaurantFav>[];
        for (var i = 0; i < resultDataR.length; i++) {
          RestaurantFav t = RestaurantFav.fromJson(resultDataR[i]);
          restaurantFav.add(t);
        }
      });
    });
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
          'ร้านอาหาร',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10, bottom: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://mtwa.xyz/storage/app/public/category/' + image,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  shopname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: listResByCate(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          var url = "https://mtwa.xyz/API/restaurant-detail";
                          var data = {'res_id': '${products[index].id}'};
                          await http
                              .post(Uri.parse(url), body: data)
                              .then((response) {
                            print('this response = ${response.body}');
                            var result = jsonDecode(response.body);
                            resultData = result['vr'];
                            vouchers = <VouchersRes>[];
                            for (var i = 0; i < resultData.length; i++) {
                              VouchersRes t =
                                  VouchersRes.fromJson(resultData[i]);
                              vouchers.add(t);
                            }
                            if (response.statusCode == 200) {
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
                                            rating: result['restaurant']
                                                ['rating'],
                                          )));
                              print('object');
                            } else {
                              return;
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 90.sp,
                                    height: 80.sp,
                                    // color: Colors.redAccent.withOpacity(0.2),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                                products[index].image,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 125.sp,
                                        // color: Colors.redAccent.withOpacity(0.2),
                                        child: Text(
                                          products[index].name,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/location.svg',
                                            color: ColorResources.ICON_Red,
                                            width: 14,
                                            height: 14,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              launch(products[index].location);
                                            },
                                            child: Text(
                                              'สถานที่ตั้งร้าน',
                                              style: TextStyle(
                                                fontSize: 7.5.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        shopname,
                                        style: TextStyle(
                                          fontSize: 8.sp,
                                        ),
                                      ),
                                      // Text(
                                      //   'เวลาเปิด-ปิด',
                                      //   style: TextStyle(
                                      //     fontSize: 8.sp,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'คะแนน',
                                    style: TextStyle(
                                        fontSize: 8.sp,
                                        color: ColorResources.KTextBlack),
                                  ),
                                  Text(
                                    products[index].rating.toString(),
                                    style: TextStyle(
                                        fontSize: 10.5.sp,
                                        color: ColorResources.KTextBlue),
                                  ),
                                  Container(
                                      width: 35.sp,
                                      // color: Colors.black.withOpacity(0.2),
                                      child: StarWidget(
                                          sizestar: '7',
                                          sId: '${products[index].id}',
                                          type: 'restaurant'))
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
