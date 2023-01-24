// import 'package:flutter/material.dart';
// import 'package:mtw_project/utill/color.resouces.dart';
// import 'package:mtw_project/views/screens/hotels/hotel_listview.dart';
// import 'package:sizer/sizer.dart';

// class HotelListViewScreen extends StatefulWidget {
//   final List hotels;
//   const HotelListViewScreen({Key? key, required this.hotels}) : super(key: key);

//   @override
//   _HotelListViewScreenState createState() => _HotelListViewScreenState(hotels);
// }

// class _HotelListViewScreenState extends State<HotelListViewScreen> {
//   late List hotels;
//   _HotelListViewScreenState(this.hotels);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.of(context).pop();
//           },
//           child: Icon(
//             Icons.arrow_back_outlined,
//             color: ColorResources.ICON_Gray,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         title: Text(
//           'โรงแรม',
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 45,
//             // color: Colors.amberAccent.withOpacity(0.2),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'จัดเรียงราคา',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.black45,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 10),
//                   width: 2,
//                   color: Colors.black45,
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'จำกัดการค้นหา',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.black45,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(vertical: 10),
//                   width: 2,
//                   color: Colors.black45,
//                 ),
//                 Expanded(
//                   child: Center(
//                     child: Text(
//                       'แผนที่',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.black45,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           HotelListView(hotels: hotels)
//         ],
//       ),
//     );
//   }
// }
