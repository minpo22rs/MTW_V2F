import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/fav_product_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class FavProScreen extends StatefulWidget {
  const FavProScreen({
    Key? key,
  }) : super(key: key);
  @override
  _FavProScreenState createState() => _FavProScreenState();
}

class _FavProScreenState extends State<FavProScreen> {
  List<ProductFav> productFav = <ProductFav>[];
  var resultDataP;
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

        resultDataP = result1['p'];
        productFav = <ProductFav>[];
        for (var i = 0; i < resultDataP.length; i++) {
          ProductFav t = ProductFav.fromJson(resultDataP[i]);
          productFav.add(t);
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

      resultDataP = result1['p'];
      productFav = <ProductFav>[];
      for (var i = 0; i < resultDataP.length; i++) {
        ProductFav t = ProductFav.fromJson(resultDataP[i]);
        productFav.add(t);
      }
      print(productFav);
    });

    return productFav;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            // color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'สินค้า',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 12,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            // color: Colors.red,
            child: FutureBuilder(
              future: favoritepage(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Container(
                      width: double.infinity,
                      // height: 450,
                      color: Colors.white.withOpacity(0.2),
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisSpacing: 20),
                          itemCount: productFav.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 125.sp,
                                        height: 200.sp,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          border: Border.all(
                                              width: 2, color: Colors.grey),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 140.sp,
                                              height: 85.sp,
                                              decoration: BoxDecoration(
                                                color: Colors.amberAccent,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(9),
                                                  topRight: Radius.circular(9),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
                                                        productFav[index].image,
                                                  ),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 10),
                                                      child: Container(
                                                        width: 40.sp,
                                                        // color: Colors.amberAccent,
                                                        child: Text(
                                                          productFav[index]
                                                              .name,
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        add_wishlists(
                                                            productFav[index]
                                                                .id,
                                                            'P');
                                                      },
                                                      icon: Icon(
                                                        Icons.favorite,
                                                        color: ColorResources
                                                            .ICON_Red,
                                                        size: 16.sp,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '฿',
                                                          style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color:
                                                                ColorResources
                                                                    .KTextGray,
                                                          ),
                                                        ),
                                                        if (productFav[index]
                                                                .price !=
                                                            0) ...[
                                                          Text(
                                                            productFav[index]
                                                                .price
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize: 9.5.sp,
                                                              color:
                                                                  ColorResources
                                                                      .KTextGray,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                            ),
                                                          ),
                                                        ],
                                                        SizedBox(
                                                          width: 3,
                                                        ),
                                                        Text(
                                                          '฿',
                                                          style: TextStyle(
                                                            fontSize: 8.sp,
                                                            color:
                                                                ColorResources
                                                                    .KTextRed,
                                                          ),
                                                        ),
                                                        Text(
                                                          productFav[index]
                                                              .saleprice
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color:
                                                                ColorResources
                                                                    .KTextRed,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'ขายได้ ชิ้น',
                                                          style: TextStyle(
                                                            fontSize: 8.sp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: 35.sp,
                                                          // color: Colors.black.withOpacity(0.2),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .circle_rounded,
                                                                size: 5.sp,
                                                                color: ColorResources
                                                                    .ICON_Yellow,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .circle_rounded,
                                                                size: 5.sp,
                                                                color: ColorResources
                                                                    .ICON_Yellow,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .circle_rounded,
                                                                size: 5.sp,
                                                                color: ColorResources
                                                                    .ICON_Yellow,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .circle_rounded,
                                                                size: 5.sp,
                                                                color: ColorResources
                                                                    .ICON_Yellow,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .circle_rounded,
                                                                size: 5.sp,
                                                                color: ColorResources
                                                                    .ICON_Light_Gray,
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }));
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
