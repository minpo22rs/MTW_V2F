import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/models/fav_hotel_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/hotels/hotel_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class FavHotelScreen extends StatefulWidget {
  const FavHotelScreen({Key? key}) : super(key: key);
  @override
  _FavHotelScreenState createState() => _FavHotelScreenState();
}

class _FavHotelScreenState extends State<FavHotelScreen> {
  List<HotelFav> hotelFav = <HotelFav>[];
  var resultDataH;
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

        resultDataH = result1['h'];
        hotelFav = <HotelFav>[];
        for (var i = 0; i < resultDataH.length; i++) {
          HotelFav t = HotelFav.fromJson(resultDataH[i]);
          hotelFav.add(t);
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

      resultDataH = result1['h'];
      hotelFav = <HotelFav>[];
      for (var i = 0; i < resultDataH.length; i++) {
        HotelFav t = HotelFav.fromJson(resultDataH[i]);
        hotelFav.add(t);
      }
    });

    return hotelFav;
  }

  DateTime start = DateTime.now();
  DateTime end = DateTime.now().add(Duration(days: 2));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'โรงแรม',
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
            margin: EdgeInsets.symmetric(horizontal: 14),
            // color: Colors.green,
            child: FutureBuilder(
                future: favoritepage(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white.withOpacity(0.2),
                      child: ListView.builder(
                        itemCount: hotelFav.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              var url = "https://mtwa.xyz/API/hotel-detail";
                              var data = {'hotel_id': '${hotelFav[index].id}'};
                              await http
                                  .post(Uri.parse(url), body: data)
                                  .then((response) {
                                var result = jsonDecode(response.body);

                                if (response.statusCode == 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HotelDetailScreen(
                                        pKey: 'popu',
                                        id: '${result['hotel']['id']}',
                                        name: '${result['hotel']['shopname']}',
                                        location:
                                            '${result['hotel']['position_url']}',
                                        image: '${result['hotel']['image']}',
                                        rating: '${result['hotel']['rating']}',
                                        start: ("${start.toLocal()}"
                                                    .split(' ')[0])
                                                .split('-')[2] +
                                            '/' +
                                            ("${start.toLocal()}".split(' ')[0])
                                                .split('-')[1] +
                                            '/' +
                                            ("${start.toLocal()}".split(' ')[0])
                                                .split('-')[0],
                                        end: ("${end.toLocal()}".split(' ')[0])
                                                .split('-')[2] +
                                            '/' +
                                            ("${end.toLocal()}".split(' ')[0])
                                                .split('-')[1] +
                                            '/' +
                                            ("${end.toLocal()}".split(' ')[0])
                                                .split('-')[0],
                                        person: '1',
                                      ),
                                    ),
                                  );
                                } else {
                                  return;
                                }
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6, bottom: 6),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 180.sp,
                                    decoration: BoxDecoration(
                                      // color: Colors.redAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(12),
                                      ),
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 140.sp,
                                          height: 180.sp,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://mtwa.xyz/storage/app/public/seller/' +
                                                      hotelFav[index].image),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 14,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 60.sp,
                                                        // color:
                                                        //     Colors.redAccent.withOpacity(0.2),
                                                        child: Text(
                                                          hotelFav[index].name,
                                                          style: TextStyle(
                                                              fontSize: 10.sp),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 20.sp,
                                                  ),
                                                  Icon(
                                                    Icons.ios_share_outlined,
                                                    color: ColorResources
                                                        .ICON_Gray,
                                                  ),
                                                  SizedBox(
                                                    width: 5.sp,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      add_wishlists(
                                                          hotelFav[index].id,
                                                          'H');
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: ColorResources
                                                          .ICON_Red,
                                                    ),
                                                  ),
                                                  // Positioned(
                                                  //   right: 2,
                                                  //   child: IconButton(
                                                  //     onPressed: () {
                                                  //       add_wishlists(
                                                  //           hotelFav[index]
                                                  //               .id,
                                                  //           'H');
                                                  //     },
                                                  //     icon: Icon(
                                                  //       Icons.favorite,
                                                  //       color: ColorResources
                                                  //           .ICON_Red,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                  width: 80.sp,
                                                  // color: Colors.black.withOpacity(0.2),
                                                  child: StarWidget(
                                                    sizestar: '7',
                                                    sId:
                                                        '${hotelFav[index].id}',
                                                    type: 'hotel',
                                                  )),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    hotelFav[index].rating,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/location.svg',
                                                    width: 14,
                                                    height: 14,
                                                    color:
                                                        ColorResources.ICON_Red,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    hotelFav[index].location,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
          ),
        ),
      ],
    );
    // ListView(
    //   children: [
    //     SizedBox(
    //       height: 20,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 24),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           Text(
    //             'โรงแรม',
    //             style: TextStyle(
    //               fontSize: 14.sp,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(
    //       height: 10,
    //     ),
    //     Container(
    // child: FutureBuilder(
    //     future: favoritepage(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (!snapshot.hasData) {
    //         return Center(child: CircularProgressIndicator());
    //       } else {
    //         return Container(
    //           width: double.infinity,
    //           height: MediaQuery.of(context).size.height,
    //           color: Colors.white.withOpacity(0.2),
    //           child: ListView.builder(
    //             itemCount: hotelFav.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return GestureDetector(
    //                 onTap: () {},
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(top: 6, bottom: 6),
    //                   child: Column(
    //                     children: [
    //                       Container(
    //                         width: double.infinity,
    //                         height: 180.sp,
    //                         decoration: BoxDecoration(
    //                           // color: Colors.redAccent.withOpacity(0.2),
    //                           borderRadius: BorderRadius.all(
    //                             Radius.circular(12),
    //                           ),
    //                           border: Border.all(
    //                               width: 2, color: Colors.grey),
    //                         ),
    //                         child: Row(
    //                           children: [
    //                             Container(
    //                               width: 140.sp,
    //                               height: 180.sp,
    //                               decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.only(
    //                                   topLeft: Radius.circular(10),
    //                                   bottomLeft: Radius.circular(10),
    //                                 ),
    //                                 image: DecorationImage(
    //                                   image: NetworkImage(
    //                                       'https://mtwa.xyz/storage/app/public/seller/' +
    //                                           hotelFav[index].image),
    //                                   fit: BoxFit.fill,
    //                                 ),
    //                               ),
    //                             ),
    //                             Padding(
    //                               padding: const EdgeInsets.only(left: 8),
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   SizedBox(
    //                                     height: 14,
    //                                   ),
    //                                   Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment
    //                                             .spaceBetween,
    //                                     children: [
    //                                       Row(
    //                                         children: [
    //                                           Container(
    //                                             width: 60.sp,
    //                                             // color:
    //                                             //     Colors.redAccent.withOpacity(0.2),
    //                                             child: Text(
    //                                               hotelFav[index].name,
    //                                               style: TextStyle(
    //                                                   fontSize: 10.sp),
    //                                               overflow: TextOverflow
    //                                                   .ellipsis,
    //                                             ),
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       SizedBox(
    //                                         width: 20.sp,
    //                                       ),
    //                                       Icon(
    //                                         Icons.ios_share_outlined,
    //                                         color:
    //                                             ColorResources.ICON_Gray,
    //                                       ),
    //                                       SizedBox(
    //                                         width: 5.sp,
    //                                       ),
    //                                       GestureDetector(
    //                                         onTap: () {
    //                                           add_wishlists(
    //                                               hotelFav[index].id,
    //                                               'H');
    //                                         },
    //                                         child: Icon(
    //                                           Icons.favorite,
    //                                           color:
    //                                               ColorResources.ICON_Red,
    //                                         ),
    //                                       ),
    //                                       // Positioned(
    //                                       //   right: 2,
    //                                       //   child: IconButton(
    //                                       //     onPressed: () {
    //                                       //       add_wishlists(
    //                                       //           hotelFav[index]
    //                                       //               .id,
    //                                       //           'H');
    //                                       //     },
    //                                       //     icon: Icon(
    //                                       //       Icons.favorite,
    //                                       //       color: ColorResources
    //                                       //           .ICON_Red,
    //                                       //     ),
    //                                       //   ),
    //                                       // ),
    //                                     ],
    //                                   ),
    //                                   SizedBox(
    //                                     height: 16,
    //                                   ),
    //                                   Container(
    //                                     width: 80.sp,
    //                                     // color: Colors.black.withOpacity(0.2),
    //                                     child: Row(
    //                                       children: [
    //                                         Icon(
    //                                           Icons.circle_rounded,
    //                                           size: 9.sp,
    //                                           color: ColorResources
    //                                               .ICON_Yellow,
    //                                         ),
    //                                         SizedBox(
    //                                           width: 4,
    //                                         ),
    //                                         Icon(
    //                                           Icons.circle_rounded,
    //                                           size: 9.sp,
    //                                           color: ColorResources
    //                                               .ICON_Yellow,
    //                                         ),
    //                                         SizedBox(
    //                                           width: 4,
    //                                         ),
    //                                         Icon(
    //                                           Icons.circle_rounded,
    //                                           size: 9.sp,
    //                                           color: ColorResources
    //                                               .ICON_Yellow,
    //                                         ),
    //                                         SizedBox(
    //                                           width: 4,
    //                                         ),
    //                                         Icon(
    //                                           Icons.circle_rounded,
    //                                           size: 9.sp,
    //                                           color: ColorResources
    //                                               .ICON_Yellow,
    //                                         ),
    //                                         SizedBox(
    //                                           width: 4,
    //                                         ),
    //                                         Icon(
    //                                           Icons.circle_rounded,
    //                                           size: 9.sp,
    //                                           color: ColorResources
    //                                               .ICON_Light_Gray,
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   SizedBox(
    //                                     height: 16,
    //                                   ),
    //                                   Row(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.end,
    //                                     children: [
    //                                       Text(
    //                                         hotelFav[index].rating,
    //                                         style: TextStyle(
    //                                           fontSize: 10.sp,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   SizedBox(
    //                                     height: 16,
    //                                   ),
    //                                   Row(
    //                                     children: [
    //                                       SvgPicture.asset(
    //                                         'assets/icons/location.svg',
    //                                         width: 14,
    //                                         height: 14,
    //                                         color:
    //                                             ColorResources.ICON_Red,
    //                                       ),
    //                                       SizedBox(
    //                                         width: 5,
    //                                       ),
    //                                       Text(
    //                                         hotelFav[index].location,
    //                                         style: TextStyle(
    //                                           fontSize: 10.sp,
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   SizedBox(
    //                                     height: 30,
    //                                   ),
    //                                 ],
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               );
    //             },
    //           ),
    //         );
    //       }
    //     }),
    // ),
    // SizedBox(
    //   height: 100,
    // )
    // ],
    // );
  }
}
