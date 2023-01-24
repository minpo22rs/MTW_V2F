import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final screen = [
    HomeScreen(
        mainbanner: [],
        onecon: [],
        twocon: [],
        onelinecon: [],
        twolinecon: [],
        bannersub: 'bannersub',
        bannerfooter: 'bannerfooter',
        restaurants: [],
        products: [],
        categoryProduct: [],
        categoryrestaurants: [],
        hotels: [],
        attractions: [],
        wallet: '100'),
    // LoadingScreen(userid: '30'),
    Center(
      child: Text('1'),
    ),
    Center(
      child: Text('2'),
    ),
    Center(
      child: Text('3'),
    ),
  ];
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[_selected],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          currentIndex: _selected,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.orange,
            ),
          ],
          onTap: (index) {
            setState(() {
              _selected = index;
            });
          }
          // Container(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width / 4,
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          //   child: Icon(Icons.home),
          // ),
          // Container(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width / 4,
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          //   child: Icon(Icons.home),
          // ),
          // Container(
          //   height: 60,
          //   width: MediaQuery.of(context).size.width / 4,
          //   decoration: BoxDecoration(
          //     color: Colors.green,
          //   ),
          //   child: Icon(Icons.home),
          // ),
          ),
    );
  }
}
