import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:mtw_project/views/screens/pages/list_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_account_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_cart_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:mtw_project/views/screens/pages/notifacation_screen.dart';

class CustomBottomNavigator extends StatefulWidget {
  final String userid;
  const CustomBottomNavigator({Key? key, required this.userid})
      : super(key: key);
  @override
  _CustomBottomNavigatorState createState() =>
      _CustomBottomNavigatorState(userid);
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  late String userid;
  _CustomBottomNavigatorState(this.userid);
  PageController page = PageController();
  @override
  Widget build(BuildContext context) {
    // int _selected = 2;
    // final screen = [
    //   // LoadingScreen(userid: userid),
    //   Center(
    //     child: Text('0'),
    //   ),
    //   Center(
    //     child: Text('1'),
    //   ),
    //   Center(
    //     child: Text('2'),
    //   ),
    //   Center(
    //     child: Text('3'),
    //   ),
    // ];

    // void _onItemTap(int index) {
    //   setState(() {
    //     _selected = index;
    //   });
    //   page.jumpToPage(index);
    // }

    // return Scaffold(
    // body: screen[_selected],
    // bottomNavigationBar: BottomNavigationBar(
    //     type: BottomNavigationBarType.fixed,
    //     backgroundColor: Colors.green,
    //     currentIndex: _selected,
    //     items: [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //         backgroundColor: Colors.green,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //         backgroundColor: Colors.red,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //         backgroundColor: Colors.blue,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home),
    //         label: 'Home',
    //         backgroundColor: Colors.orange,
    //       ),
    //     ],
    //     onTap: (index) {
    //       setState(() {
    //         _selected = index;
    //       });
    //     }
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
    //       ),
    // );

    // return Scaffold(
    //   body: PageView(
    //     controller: page,
    //     children: [
    //       Container(child: LoadingScreen(userid: userid)),
    //       Container(
    //         color: Colors.green,
    //       ),
    //       Container(
    //         color: Colors.amber,
    //       ),
    //       Container(
    //         color: Colors.black,
    //       ),
    //     ],
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     backgroundColor: Colors.blueAccent,
    //     items: <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.red,
    //         ),
    //         label: 'Home 1',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.red,
    //         ),
    //         label: 'Home 2',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.red,
    //         ),
    //         label: 'Home 3',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //           color: Colors.red,
    //         ),
    //         label: 'Home 4',
    //       ),
    //     ],
    //     currentIndex: _selected,
    //     onTap: _onItemTap,
    //   ),
    // );

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: ColorResources.BOTTOM_BG,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: ColorResources.BOTTOM_ICON,
              width: 20,
              height: 18,
            ),
            title: Text(
              "หน้าแรก",
              style: GoogleFonts.kanit(
                color: ColorResources.BOTTOM_ICON,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/list.svg",
              color: ColorResources.BOTTOM_ICON,
              width: 20,
              height: 18,
            ),
            title: Text(
              "รายการ",
              style: GoogleFonts.kanit(
                color: ColorResources.BOTTOM_ICON,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/bell.svg",
              color: ColorResources.BOTTOM_ICON,
              width: 20,
              height: 18,
            ),
            title: Text(
              "แจ้งเตือน",
              style: GoogleFonts.kanit(
                color: ColorResources.BOTTOM_ICON,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/user.svg",
              color: ColorResources.BOTTOM_ICON,
              width: 20,
              height: 18,
            ),
            title: Text(
              "บัญชี",
              style: GoogleFonts.kanit(
                color: ColorResources.BOTTOM_ICON,
              ),
            ),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: LoadingScreen(userid: userid),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: ListScreen(),

                  // child: LoadingCartScreen(
                  //   pageKey: 'main',
                  //   productKey: '',
                  // ),
                );
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: NotificationScreen(),
                );
              },
            );
          default:
            return CupertinoTabView(
              builder: (context) {
                return CupertinoPageScaffold(
                  child: LoadingAccScreen(
                    pageKey: 'account',
                    pageKey2: '',
                  ),
                );
              },
            );
        }
      },
    );
  }
}
// }
