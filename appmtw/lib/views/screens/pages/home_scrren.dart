import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/attractions/recommended_attractions_screen.dart';
import 'package:mtw_project/views/screens/categoeymenu/category_menu_screen.dart';
import 'package:mtw_project/views/screens/categoeymenu/category_menu_screen_2.dart';
import 'package:mtw_project/views/screens/categoryzone/category_zone_screen.dart';
import 'package:mtw_project/views/screens/hotels/hotel_screen.dart';
import 'package:mtw_project/views/screens/hotels/popular_hotel_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_account_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_attarction_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_product_screen.dart';
import 'package:mtw_project/views/screens/pages/widgets/image_slider_carousel_widget.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_line_one.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_line_two.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_one.dart';
import 'package:mtw_project/views/screens/pages/widgets/rating_widget_two.dart';
import 'package:mtw_project/views/screens/products/recommended_product_screen.dart';
import 'package:mtw_project/views/screens/restaurant/popular_restaurant_screen.dart';
import 'package:mtw_project/views/screens/restaurant/restautant_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  final List mainbanner,
      onecon,
      twocon,
      onelinecon,
      twolinecon,
      restaurants,
      products,
      categoryProduct,
      categoryrestaurants,
      hotels,
      attractions;
  final String bannersub, bannerfooter, wallet;
  const HomeScreen(
      {Key? key,
      required this.mainbanner,
      required this.onecon,
      required this.twocon,
      required this.onelinecon,
      required this.twolinecon,
      required this.bannersub,
      required this.bannerfooter,
      required this.restaurants,
      required this.products,
      required this.categoryProduct,
      required this.categoryrestaurants,
      required this.hotels,
      required this.attractions,
      required this.wallet})
      : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(
      mainbanner,
      onecon,
      twocon,
      onelinecon,
      twolinecon,
      bannersub,
      bannerfooter,
      restaurants,
      products,
      categoryProduct,
      categoryrestaurants,
      hotels,
      attractions,
      wallet);
}

class _HomeScreenState extends State<HomeScreen> {
  late List mainbanner,
      onecon,
      twocon,
      onelinecon,
      twolinecon,
      restaurants,
      products,
      categoryProduct,
      categoryrestaurants,
      hotels,
      attractions;
  late String bannersub, bannerfooter, wallet;
  _HomeScreenState(
      this.mainbanner,
      this.onecon,
      this.twocon,
      this.onelinecon,
      this.twolinecon,
      this.bannersub,
      this.bannerfooter,
      this.restaurants,
      this.products,
      this.categoryProduct,
      this.categoryrestaurants,
      this.hotels,
      this.attractions,
      this.wallet);

  @override
  void initState() {
    super.initState();
  }

  void _toast(var module) {
    Fluttertoast.showToast(
        msg: "พบกับบริการ " + module + " เร็วๆนี้",
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }

  bool _showContent = true;
  var account_wallet;
  accountDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    var url = "http://10.0.2.2/flutter/account-detail.php";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((response) {
      if (response.statusCode == 200) {
        var detail = jsonDecode(response.body);
        var numformat = NumberFormat('#,###.##').format(detail['wallet']);
        // var numformat = detail['wallet'];
        print(numformat);
        print("tes222222222");
        account_wallet = '${numformat}';
      }
    });
    return account_wallet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            // SearchWidget(
            //   hintText: '',
            // ),
            SizedBox(
              height: 22,
            ),
            ImageSliderWidget(mainbanner: mainbanner),
            SizedBox(
              height: 16,
            ),
            // Center(
            //   child: Text(
            //     "VOTE",
            //     style: TextStyle(
            //       color: Colors.blue[900],
            //       fontSize: 22,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 22,
            // ),
            // RatingWidgetOne(onecon: onecon),
            // SizedBox(
            //   height: 10,
            // ),
            // if (twocon.length > 0) ...[
            //   RatingWidgetTwo(twocon: twocon),
            //   SizedBox(
            //     height: 10,
            //   ),
            // ],
            // if (onelinecon.length > 0) ...[
            //   RatingWidgetLineOne(onelinecon: onelinecon),
            //   SizedBox(
            //     height: 5,
            //   ),
            // ],
            // if (twolinecon.length > 0) ...[
            //   RatingWidgetLineTwo(twolinecon: twolinecon),
            // ],
            // SizedBox(
            //   height: 10,
            // ),
            // CategoryZoneScreen(
            //   wallet: wallet,
            //   pageKey: 'Main',
            // ),
            // SizedBox(height: 8),
            // Container(
            //   width: double.infinity,
            //   height: 120.sp,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: NetworkImage(
            //         'https://mtwa.xyz/storage/app/public/banner/' + bannersub,
            //       ),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoadingAccScreen(
                                      pageKey: 'walletx',
                                      pageKey2: 'walletx',
                                    )));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/wallet-filled-money-tool.svg',
                            width: 14.sp,
                            height: 17.sp,
                            color: ColorResources.KTextPink,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: accountDetail(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  return Text(
                                    (account_wallet),
                                    style: TextStyle(
                                      fontSize: 9.sp,
                                      color: ColorResources.KTextPink,
                                    ),
                                  );
                                },
                              ),
                              Text(
                                '  ฿',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: ColorResources.KTextPink,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15.sp,
                            color: ColorResources.KTextPink,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () {
                        _toast('แลก point');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/coin.svg',
                            width: 14.sp,
                            height: 17.sp,
                            color: ColorResources.KTextPink,
                          ),
                          Row(
                            children: [
                              Text(
                                '0.00',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: ColorResources.KTextPink,
                                ),
                              ),
                              Text(
                                '  คะแนน',
                                style: TextStyle(
                                  fontSize: 5.sp,
                                  color: ColorResources.KTextPink,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15.sp,
                            color: ColorResources.KTextPink,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            CategoryMenuScreen(),
            CategoryMenuScreen2(
                restaurants: restaurants,
                categoryrestaurants: categoryrestaurants,
                bannersub: bannersub),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 120.sp,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'http://10.0.2.2/flutter/2021-09-06-61361d04555bf.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'ร้านอาหารยอดฮิต',
                      style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.KTextBlack),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantScreen(
                                restaurants: restaurants,
                                categoryrestaurants: categoryrestaurants,
                                bannersub: bannersub),
                          ),
                        );
                      },
                      child: Text(
                        'ดูทั้งหมด',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorResources.KTextPink,
                        ),
                      ),
                    ),
                  ],
                ),
                PopularRestaurantScreen(),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            if (products.length > 0) ...[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'สินค้าแนะนำ',
                        style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.KTextBlack),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadingProScreen(
                                        pageKey: 'screen',
                                        productKey: '',
                                      )));
                        },
                        child: Text(
                          'ดูทั้งหมด',
                          style: TextStyle(
                            fontSize: 9.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorResources.KTextPink,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RecommendedProductScreen(products: products),
                  Divider(
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],

            _showContent
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'โรงแรมยอดฮิต',
                            style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.KTextBlack),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'ดูทั้งหมด',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.KTextPink,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 240,
                        child: PopularHotelScreen(),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    height: 160,
                    child: Center(child: Text('Comming Soon !!')),
                  ),
            _showContent
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'สถานที่ท่องเที่ยวแนะนำ',
                            style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.KTextBlack),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoadingAttractionScreen(
                                    pageKey: 'screen',
                                    productKey: '',
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'ดูทั้งหมด',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorResources.KTextPink,
                              ),
                            ),
                          ),
                        ],
                      ),
                      RecommendedAttractionsScreen(),
                    ],
                  )
                : Container(
                    width: double.infinity,
                    height: 160,
                    child: Center(child: Text('Comming Soon !!')),
                  ),
            // Container(
            //   width: double.infinity,
            //   height: 30,
            //   child: Center(
            //       child: Text(
            //     'พบกับบริการอื่นๆเร็วๆนี้',
            //     style: TextStyle(
            //         color: ColorResources.KTextBlue,
            //         fontWeight: FontWeight.bold),
            //   )),
            // ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
