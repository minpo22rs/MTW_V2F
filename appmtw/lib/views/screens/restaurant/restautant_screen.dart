import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/category_restaurant.dart';
import 'package:mtw_project/models/vouchers_restaurant_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/basewidget/like_widget.dart';
import 'package:mtw_project/views/basewidget/search_widget.dart';
import 'package:mtw_project/views/basewidget/star_widget.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_cate_screen.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_other.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_other_more.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_search.dart';
import 'package:mtw_project/views/screens/restaurant/select_restaurant_screen.dart';
import 'package:sizer/sizer.dart';

class RestaurantScreen extends StatefulWidget {
  final List restaurants, categoryrestaurants;
  final String bannersub;
  const RestaurantScreen(
      {Key? key,
      required this.restaurants,
      required this.categoryrestaurants,
      required this.bannersub})
      : super(key: key);

  @override
  _RestaurantScreenState createState() =>
      _RestaurantScreenState(restaurants, categoryrestaurants, bannersub);
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  late List restaurants, categoryrestaurants;
  late String bannersub;
  _RestaurantScreenState(
      this.restaurants, this.categoryrestaurants, this.bannersub);
  List<VouchersRes> vouchers = <VouchersRes>[];
  var resultData;
  TextEditingController searchctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ร้านอาหาร',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8.0, bottom: 8, left: 15, right: 15),
            child: Container(
              height: 40.sp,
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 13.0,
                        height: 0.9,
                        color: ColorResources.ICON_Light_Gray,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      controller: searchctrl,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchctrl.clear();
                          },
                          icon: Icon(Icons.clear),
                        ),
                        hintText: 'ใส่ชื่อร้านอาหารหรือจังหวัดเพื่อทำการค้นหา',
                        hintStyle: TextStyle(color: ColorResources.KTextGray),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: ColorResources.KTextGray,
                            width: 1.0,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (searchctrl.text != '') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ResSearch(
                              searchKey: searchctrl.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: Icon(Icons.search),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: double.infinity,
            height: 140,
            child: Image.network(
              'https://mtwa.xyz/storage/app/public/banner/' + bannersub,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: double.infinity,
            height: 115,
            // color: Colors.redAccent.withOpacity(0.2),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryrestaurants.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 11, right: 11, top: 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RestaurantCScreen(
                                shopname:
                                    categoryrestaurants[index].namecatrory,
                                image: categoryrestaurants[index].image,
                                cId: '${categoryrestaurants[index].id}',
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                'https://mtwa.xyz/storage/app/public/category/' +
                                    categoryrestaurants[index].image,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              categoryrestaurants[index].namecatrory,
                              style: TextStyle(fontSize: 9.5.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ร้านอาหารยอดฮิต',
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 245,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (restaurants.length < 11) ? restaurants.length : 10,
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
                                  height: 100.sp,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://mtwa.xyz/storage/app/public/seller/thumbnail/' +
                                            restaurants[index].image,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 2,
                                  child: LikeWidget(
                                    itemId: '${restaurants[index].id}',
                                    type: 'H',
                                    color: 'LG',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 130.sp,
                                  height: 70.sp,
                                  // color: Colors.red.withOpacity(0.2),
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
                                          height: 55.sp,
                                          // color:
                                          //     Colors.redAccent.withOpacity(0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                restaurants[index].name,
                                                // restaurants[index].name,
                                                style: TextStyle(
                                                    fontSize: 10.5.sp),
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
                                                    child: Text(
                                                      'สถานที่ตั้งร้าน ' +
                                                          restaurants[index]
                                                              .location,
                                                      style: TextStyle(
                                                        fontSize: 6.5.sp,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  )
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
                                                color: ColorResources.KTextBlue,
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
                                                    type: 'restaurant')),
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ร้านอื่นๆสำหรับคุณ',
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResOtherMore(
                          restaurants: restaurants,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'ดูทั้งหมด',
                    style: TextStyle(
                        fontSize: 9.sp, color: ColorResources.KTextLightBlue),
                  ),
                ),
              ],
            ),
          ),
          RestaurantOther(restaurants: restaurants)
        ],
      ),
    );
  }
}
