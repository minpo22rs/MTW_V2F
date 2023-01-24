// import 'package:flutter/material.dart';
// import 'package:mtw_project/utill/images.dart';
// import 'package:sizer/sizer.dart';

// class PoppularRestaurantWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     width: 130.sp,
//                     height: 100.sp,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(12)),
//                       image: DecorationImage(
//                         image: AssetImage(Images.background),
//                         fit: BoxFit.fill,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     right: 2,
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.headset_rounded,
//                         size: 15.sp,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Container(
//                     width: 130.sp,
//                     height: 70.sp,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(
//                             width: 85.sp,
//                             height: 53.sp,
//                             // color: Colors.redAccent.withOpacity(0.2),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'ดอยอินทนนท์',
//                                   style: TextStyle(fontSize: 10.5.sp),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(
//                                   height: 2,
//                                 ),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Icon(
//                                       Icons.gps_fixed,
//                                       size: 11.sp,
//                                     ),
//                                     SizedBox(
//                                       width: 3,
//                                     ),
//                                     Text(
//                                       'สถานที่ตั้งร้าน',
//                                       style: TextStyle(fontSize: 7.5.sp),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 3,
//                                 ),
//                                 Text(
//                                   'คำอธิบายต่อ',
//                                   style: TextStyle(fontSize: 6.5.sp),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 '4.5',
//                                 style: TextStyle(
//                                   fontSize: 11.sp,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blue[900],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 2,
//                               ),
//                               Container(
//                                 width: 35.sp,
//                                 // color: Colors.black.withOpacity(0.2),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Icon(
//                                       Icons.circle_rounded,
//                                       size: 5.sp,
//                                       color: Colors.yellow[700],
//                                     ),
//                                     Icon(
//                                       Icons.circle_rounded,
//                                       size: 5.sp,
//                                       color: Colors.yellow[700],
//                                     ),
//                                     Icon(
//                                       Icons.circle_rounded,
//                                       size: 5.sp,
//                                       color: Colors.yellow[700],
//                                     ),
//                                     Icon(
//                                       Icons.circle_rounded,
//                                       size: 5.sp,
//                                       color: Colors.yellow[700],
//                                     ),
//                                     Icon(
//                                       Icons.circle_rounded,
//                                       size: 5.sp,
//                                       color: Colors.yellow[700],
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
