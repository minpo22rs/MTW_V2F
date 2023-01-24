import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/models/product_reccomment_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:mtw_project/views/screens/products/product_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RecommendedProductScreen extends StatefulWidget {
  final List products;
  const RecommendedProductScreen({Key? key, required this.products})
      : super(key: key);

  @override
  _RecommendedProductScreenState createState() =>
      _RecommendedProductScreenState(products);
}

class _RecommendedProductScreenState extends State<RecommendedProductScreen> {
  late List products;
  _RecommendedProductScreenState(this.products);
  @override
  void initState() {
    super.initState();
    // recproduct().whenComplete(() {
    //   setState(() {});
    // });
  }

  // List<Product> products = <Product>[];
  // var resultProduct;
  // bool statusData = false;

  // Future<Null> recproduct() async {
  //   var url = "https://mtwa.xyz/API/recommend-product";
  //   await http.get(Uri.parse(url)).then((response) {
  //     print('this response = ${response.body}');
  //     var result1 = jsonDecode(response.body);
  //     resultProduct = result1;
  //     // print('Length = ${result.length} ');
  //     products = <Product>[];
  //     print('Length ====== ${resultProduct.length}');
  //     for (var j = 0; j < resultProduct.length; j++) {
  //       Product d = Product.fromJson(resultProduct[j]);
  //       products.add(d);
  //     }
  //   });
  // }
  List<Proimg> proimg = <Proimg>[];
  var resultImg;

  Future<Null> add_wishlists(var wishlist_id, var type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/add-wishlists";
    var data = {
      'userid': '${userId}',
      'wishlist_id': '${wishlist_id}',
      'type': '${type}'
    };
    await http.post(Uri.parse(url), body: data).then((value) {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return FlatButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoadingProScreen(
                    productKey: '${products[index].id}',
                    pageKey: 'detail',
                  ),
                ),
              );
            },
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Container(
                  width: 140.sp,
                  height: 180.sp,
                  decoration: BoxDecoration(
                    // color: Colors.redAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(
                        width: 2, color: ColorResources.ICON_Light_Gray),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 140.sp,
                        height: 100.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
                                    products[index].image),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  width: 80.sp,
                                  // color: Colors.amberAccent,
                                  child: Text(
                                    products[index].name,
                                    style: TextStyle(fontSize: 11.sp),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  add_wishlists(products[index].id, 'P');
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: ColorResources.ICON_Light_Gray,
                                  size: 16.sp,
                                ),
                              )
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '฿',
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      color: ColorResources.KTextGray,
                                    ),
                                  ),
                                  if (products[index].price != 0) ...[
                                    Text(
                                      products[index].price.toString(),
                                      style: TextStyle(
                                        fontSize: 9.5.sp,
                                        color: ColorResources.KTextGray,
                                        decoration: TextDecoration.lineThrough,
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
                                      color: ColorResources.KTextRed,
                                    ),
                                  ),
                                  Text(
                                    products[index].saleprice.toString(),
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'ขายได้ ' + '10' + ' ชิ้น',
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
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: Colors.yellow[700],
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: Colors.yellow[700],
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: Colors.yellow[700],
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: Colors.yellow[700],
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: Colors.yellow[700],
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
          );
        },
      ),
    );
  }
}
