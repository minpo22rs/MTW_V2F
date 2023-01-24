import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:mtw_project/views/screens/products/product_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProductGridView extends StatefulWidget {
  final List products;
  const ProductGridView({Key? key, required this.products}) : super(key: key);

  @override
  _ProductGridViewState createState() => _ProductGridViewState(products);
}

class _ProductGridViewState extends State<ProductGridView> {
  late List products;
  _ProductGridViewState(this.products);
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

  List<Proimg> proimg = <Proimg>[];
  var resultImg;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 125.sp,
                  height: 215.sp,
                  decoration: BoxDecoration(
                    // color: Colors.redAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    border: Border.all(width: 2, color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 125.sp,
                        height: 85.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(9),
                            topRight: Radius.circular(9),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
                                  products[index].image,
                            ),
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
                                padding:
                                    const EdgeInsets.only(left: 10, top: 10),
                                child: Container(
                                  width: 70.sp,
                                  // color: Colors.amberAccent,
                                  child: Text(
                                    products[index].name,
                                    style: TextStyle(fontSize: 10.sp),
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
                                      color: ColorResources.KTextRed,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    'ขายได้' + ' 0 ' + 'ชิ้น',
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
                                          color: ColorResources.ICON_Yellow,
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: ColorResources.ICON_Yellow,
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: ColorResources.ICON_Yellow,
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: ColorResources.ICON_Yellow,
                                        ),
                                        Icon(
                                          Icons.circle_rounded,
                                          size: 5.sp,
                                          color: ColorResources.ICON_Light_Gray,
                                        ),
                                      ],
                                    ),
                                  ),
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
