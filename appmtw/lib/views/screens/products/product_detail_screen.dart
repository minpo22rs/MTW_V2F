import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/floatingbutton.dart';
import 'package:mtw_project/views/basewidget/image_slider_widget.dart';
import 'package:mtw_project/views/screens/products/similar_producr.dart';
import 'package:mtw_project/views/screens/review/product_review.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatefulWidget {
  final String id,
      p_name,
      sale_price,
      unit_price,
      image,
      p_detail,
      stock,
      seller,
      address,
      simage,
      rating,
      seller_id;
  final List images, similar;
  const ProductDetailScreen(
      {Key? key,
      required this.id,
      required this.p_name,
      required this.sale_price,
      required this.unit_price,
      required this.image,
      required this.p_detail,
      required this.stock,
      required this.seller,
      required this.address,
      required this.simage,
      required this.rating,
      required this.seller_id,
      required this.images,
      required this.similar})
      : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState(
      id,
      p_name,
      sale_price,
      unit_price,
      p_detail,
      image,
      stock,
      seller,
      address,
      simage,
      rating,
      seller_id,
      images,
      similar);
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String id,
      p_name,
      sale_price,
      unit_price,
      image,
      p_detail,
      stock,
      seller,
      address,
      simage,
      rating,
      seller_id;
  late List images, similar;
  _ProductDetailScreenState(
      this.id,
      this.p_name,
      this.sale_price,
      this.unit_price,
      this.image,
      this.p_detail,
      this.stock,
      this.seller,
      this.address,
      this.simage,
      this.rating,
      this.seller_id,
      this.images,
      this.similar);
  int qty = 1;
  bool _favorite = false;
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
        setState(() {
          _favorite = true;
        });
        Fluttertoast.showToast(
            msg: "เพิ่มในรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      } else if (result['status_wishlist'] == 'SD') {
        setState(() {
          _favorite = false;
        });
        Fluttertoast.showToast(
            msg: "ลบออกจากรายการที่ถูกใจเรียบร้อยแล้วค่ะ",
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_SHORT);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'สินค้า',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FancyFab(
        pro_id: '${id}',
        qty: '${qty}',
        seller: '${seller_id}',
      ),
      body: ListView(
        children: [
          ImageSlider(
            image: images,
            pageKey: 'product',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 20),
                child: Container(
                  width: 190.sp,
                  // color: Colors.redAccent.withOpacity(0.2),
                  child: Text(
                    widget.p_name,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('แชร์');
                      },
                      child: Icon(
                        Icons.ios_share_rounded,
                        color: ColorResources.ICON_Gray,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        add_wishlists(id, 'P');
                        // setState(() {
                        //   _favorite = !_favorite;
                        //   if (_favorite == true) {
                        //     Fluttertoast.showToast(
                        //       msg: 'เพิ่มลงในรายการถูกใจเรียบร้อย',
                        //       gravity: ToastGravity.TOP,
                        //     );
                        //   } else {
                        //     Fluttertoast.showToast(
                        //       msg: 'เอาออกจากรายการถูกใจเรียบร้อย',
                        //       gravity: ToastGravity.TOP,
                        //     );
                        //   }
                        // });
                        print('ถูกใจ');
                      },
                      child: Icon(
                        Icons.favorite,
                        color: _favorite
                            ? Colors.red
                            : ColorResources.ICON_Light_Gray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      '฿',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextRed,
                      ),
                    ),
                    Text(
                      widget.sale_price,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextRed,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Row(
                  children: [
                    Container(
                      width: 75.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            size: 10.sp,
                            color: ColorResources.ICON_Yellow,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 10.sp,
                            color: ColorResources.ICON_Yellow,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 10.sp,
                            color: ColorResources.ICON_Yellow,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 10.sp,
                            color: ColorResources.ICON_Yellow,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 10.sp,
                            color: ColorResources.ICON_Light_Gray,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '4.5/5',
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '฿',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextGray,
                      ),
                    ),
                    Text(
                      widget.unit_price,
                      style: TextStyle(
                        fontSize: 12.5.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.KTextGray,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                Text(
                  'ขายได้ ' + '100' + ' ชิ้น',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),

          // Container(
          //   width: double.infinity,
          //   height: 80,
          //   color: ColorResources.BG_Blue,
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(left: 14, right: 14),
          //         child: Row(
          //           children: [
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 SvgPicture.asset(
          //                   'assets/icons/chat.svg',
          //                   width: 25,
          //                   height: 25,
          //                   color: Colors.white,
          //                 ),
          //                 SizedBox(
          //                   height: 4,
          //                 ),
          //                 Text(
          //                   'แชทกับร้านค้า',
          //                   style: TextStyle(
          //                     fontSize: 9.sp,
          //                     color: ColorResources.KTextWhite,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             SizedBox(
          //               width: 22,
          //             ),
          //             Container(
          //               margin: EdgeInsets.symmetric(vertical: 7),
          //               width: 1,
          //               color: Colors.black,
          //             ),
          //             SizedBox(
          //               width: 22,
          //             ),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 SvgPicture.asset(
          //                   'assets/icons/add-to-basket.svg',
          //                   width: 25,
          //                   height: 25,
          //                   color: Colors.white,
          //                 ),
          //                 SizedBox(
          //                   height: 4,
          //                 ),
          //                 Text(
          //                   'เพิ่มในตะกร้า',
          //                   style: TextStyle(
          //                     fontSize: 9.sp,
          //                     color: ColorResources.KTextWhite,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Container(
          //           color: ColorResources.BG_Green,
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 'ซื้อสินค้า',
          //                 style: TextStyle(
          //                   fontSize: 18.sp,
          //                   color: ColorResources.KTextWhite,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://mtwa.xyz/storage/app/public/seller/' +
                            widget.simage,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          seller,
                          style: TextStyle(fontSize: 10.5.sp),
                        ),
                        Text(
                          address.length < 30
                              ? address
                              : address.substring(0, 30) + '...',
                          style: TextStyle(
                            fontSize: 8.5.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('ดูร้านค้า'),
                  style: ElevatedButton.styleFrom(
                      primary: ColorResources.KTextLightBlue),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            // color: Colors.amberAccent.withOpacity(0.2),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '500',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'รายการสินค้า',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '4.1',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'ให้คะแนน',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 1,
                  color: Colors.black,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '82%',
                        style: TextStyle(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        'การตอบกลับแชท',
                        style: TextStyle(
                          fontSize: 9.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text('รายละเอียด'),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.amberAccent,
                    child: Text(
                      'คลัง',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    // color: Colors.redAccent,
                    child: Text(
                      widget.stock,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    // color: Colors.amberAccent,
                    child: Text(
                      'ส่งจาก',
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            address,
                            maxLines: 3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              width: double.infinity,
              // color: Colors.amberAccent,
              child: Column(
                children: [
                  Text(
                    widget.p_detail,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'เพิ่มเติม',
                      style: TextStyle(
                        fontSize: 8.5.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            thickness: 0.5,
            color: Colors.black12,
          ),
          if (rating != '0.00') ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('คะแนนสินค้า'),
                  SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            // color: Colors.green,
                            width: 75.sp,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.circle_rounded,
                                  size: 8.sp,
                                  color: ColorResources.ICON_Yellow,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  size: 8.sp,
                                  color: ColorResources.ICON_Yellow,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  size: 8.sp,
                                  color: ColorResources.ICON_Yellow,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  size: 8.sp,
                                  color: ColorResources.ICON_Yellow,
                                ),
                                Icon(
                                  Icons.circle_rounded,
                                  size: 8.sp,
                                  color: ColorResources.ICON_Light_Gray,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('4.5/5')
                        ],
                      ),
                      TextButton(onPressed: () {}, child: Text('ดูทั้งหมด'))
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Colors.black12,
            ),
            ProductReview(
              sId: '',
              type: '',
            ),
          ] else ...[
            SizedBox(
              width: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                // color: Colors.amberAccent,
                child: Column(
                  children: [
                    Text('ยังไม่มีกาาร Review สินค้าชิ้นนี้'),
                  ],
                ),
              ),
            ),
          ],
          SimilarProduct(similar: similar),
          SizedBox(height: 20),

          // SimilarProduct(),
          // Padding(
          //   padding: const EdgeInsets.only(left: 22, top: 8, right: 22),
          //   child: Column(
          //     children: [
          //       Row(
          //         children: [
          //           CircleAvatar(
          //             radius: 30,
          //             backgroundImage: NetworkImage(
          //               'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
          //                   widget.image,
          //             ),
          //           ),
          //           SizedBox(
          //             width: 8,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 'ชื่อลูกค้า',
          //                 style: TextStyle(fontSize: 10.5.sp),
          //               ),
          //               SizedBox(height: 4),
          //               Container(
          //                 // color: Colors.green,
          //                 width: 45.sp,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   children: [
          //                     Icon(
          //                       Icons.circle_rounded,
          //                       size: 6.sp,
          //                       color: ColorResources.ICON_Yellow,
          //                     ),
          //                     Icon(
          //                       Icons.circle_rounded,
          //                       size: 6.sp,
          //                       color: ColorResources.ICON_Yellow,
          //                     ),
          //                     Icon(
          //                       Icons.circle_rounded,
          //                       size: 6.sp,
          //                       color: ColorResources.ICON_Yellow,
          //                     ),
          //                     Icon(
          //                       Icons.circle_rounded,
          //                       size: 6.sp,
          //                       color: ColorResources.ICON_Yellow,
          //                     ),
          //                     Icon(
          //                       Icons.circle_rounded,
          //                       size: 6.sp,
          //                       color: ColorResources.ICON_Light_Gray,
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //       Container(
          //         width: double.infinity,
          //         // color: Colors.amberAccent,
          //         child: Column(
          //           children: [
          //             Text(
          //                 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class Displaybottom extends StatefulWidget {
  const Displaybottom({Key? key}) : super(key: key);

  @override
  _DisplaybottomState createState() => _DisplaybottomState();
}

class _DisplaybottomState extends State<Displaybottom> {
  bool value1 = false;
  bool valueswitch = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Icon(Icons.chat),
                  Text(
                    'แชทคุยกับร้านค้า',
                    style: TextStyle(
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Icon(Icons.chat),
                  Text('เพิ่มในตะกร้า'),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(child: Text('ซื้อสินค้า')),
            ),
          ],
        )
      ],
    );
  }
}
