import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_buy.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_delivery.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_receive.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_store.dart';

class TabProduct extends StatelessWidget {
  const TabProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              // Tab(
              //   child: Text(
              //     'การซื้อสินค้า',
              //     style: TextStyle(
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              Tab(
                child: Text(
                  'ตะกร้าสินค้า',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // Tab(
              //   child: Text(
              //     'ที่ต้องจัดส่ง',
              //     style: TextStyle(
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              // Tab(
              //   child: Text(
              //     'ที่ต้องได้รับ',
              //     style: TextStyle(
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
              // Tab(
              //   child: Text(
              //     'ให้คะแนน',
              //     style: TextStyle(
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // TabBuy(),
            TabStore(),
            // TabReceive(),
            // TabDelivery(),
            // TabStore(),
          ],
        ),
      ),
    );
  }
}
