import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/tabbarview/tab_carrent.dart';
import 'package:mtw_project/views/screens/tabbarview/tab_hotel.dart';
import 'package:mtw_project/views/screens/tabbarview/tab_product.dart';
import 'package:mtw_project/views/screens/tabbarview/tab_restaurant.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _showContent = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showContent
          ? DefaultTabController(
              initialIndex: 0,
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'รายการของฉัน',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(
                        child: Text(
                          'ร้านอาหาร',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'โรงแรม',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'สินค้า',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Tab(
                      //   child: Text(
                      //     'เช่ารถ',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                      // Tab(
                      //   child: Text(
                      //     'สถานที่ท่องเที่ยว',
                      //     style: TextStyle(
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                ),
                body: TabBarView(
                  children: [
                    TabRestaurant(),
                    TabHotel(),
                    TabProduct(),
                    // TabCarrent(),
                    // TabCarrent(),
                  ],
                ),
              ),
            )
          : Center(
              child: Text('Comming Soon !!'),
            ),
    );
  }
}
