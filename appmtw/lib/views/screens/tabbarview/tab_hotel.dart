import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/tabbarview/hoteltabview/tab_readyuse.dart';
import 'package:mtw_project/views/screens/tabbarview/hoteltabview/tab_useless.dart';

class TabHotel extends StatelessWidget {
  const TabHotel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 55,
          backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                child: Text(
                  'พร้อมใช้งาน',
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
          children: [
            TabReadyUse(),
            TabUseLess(),
          ],
        ),
      ),
    );
  }
}
