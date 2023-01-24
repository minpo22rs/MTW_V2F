// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:mtw_project/views/screens/pages/account_screen.dart';
// import 'package:mtw_project/views/screens/pages/home_scrren.dart';
// import 'package:mtw_project/views/screens/pages/list_screen.dart';
// import 'package:mtw_project/views/screens/pages/notifacation_screen.dart';
// import 'package:sizer/sizer.dart';

// class DashBoardScreen extends StatefulWidget {
//   @override
//   _DashBoardScreenState createState() => _DashBoardScreenState();
// }

// class _DashBoardScreenState extends State<DashBoardScreen> {
//   int index = 0;
//   final screens = [
//     HomeScreen(
//       mainbanner: [],
//       mainlength: '',
//       onecon: [],
//       oneconlength: '',
//       twocon: [],
//       twoconlength: '',
//       bannersub: '',
//       bannerfooter: '',
//     ),
//     ListScreen(),
//     NotificationScreen(),
//     AcountScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: screens[index],
//       bottomNavigationBar: BottomNavigationBar(
//         iconSize: 22.sp,
//         currentIndex: index,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               size: 22.sp,
//             ),
//             // ignore: deprecated_member_use
//             title: Text("หน้าแรก", style: TextStyle(fontSize: 8.sp)),
//             backgroundColor: Colors.blue[900],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             // ignore: deprecated_member_use
//             title: Text("รายการ", style: TextStyle(fontSize: 8.sp)),
//             backgroundColor: Colors.blue[900],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             // ignore: deprecated_member_use
//             title: Text("แจ้งเตือน", style: TextStyle(fontSize: 8.sp)),
//             backgroundColor: Colors.blue[900],
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.circle_outlined),
//             // ignore: deprecated_member_use
//             title: Text("บัญชี", style: TextStyle(fontSize: 8.sp)),
//             backgroundColor: Colors.blue[900],
//           ),
//         ],
//         onTap: (int selectedIndex) {
//           setState(() {
//             index = selectedIndex;
//           });
//         },
//       ),
//     );
//   }
// }
