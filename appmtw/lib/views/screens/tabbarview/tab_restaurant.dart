import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/tabbarview/restauranttabview/food_tab_order.dart';
import 'package:mtw_project/views/screens/tabbarview/restauranttabview/food_tab_readyuse.dart';
import 'package:mtw_project/views/screens/tabbarview/restauranttabview/food_tab_useless.dart';

class TabRestaurant extends StatefulWidget {
  const TabRestaurant({Key? key}) : super(key: key);

  @override
  _TabRestaurantState createState() => _TabRestaurantState();
}

class _TabRestaurantState extends State<TabRestaurant>
    with SingleTickerProviderStateMixin {
  // TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'Vouchers',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'คำสั่งซื้อ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'ใช้งานแล้ว',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [FoodTabReadyUse(), FoodTabOrder(), FoodTabUseLess()],
        ),
      ),
    );
  }
}
