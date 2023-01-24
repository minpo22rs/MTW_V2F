// import 'package:flutter/material.dart';
// import 'package:mtw_project/utill/images.dart';
// import 'package:sizer/sizer.dart';

// class RecommendedProductWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 140.sp,
//             height: 180.sp,
//             decoration: BoxDecoration(
//               // color: Colors.redAccent.withOpacity(0.2),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(12),
//               ),
//               border: Border.all(width: 2, color: Colors.grey),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 140.sp,
//                   height: 100.sp,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(9),
//                       topRight: Radius.circular(9),
//                     ),
//                     image: DecorationImage(
//                       image: AssetImage(Images.background),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Text(
//                             'ชื่อสินค้า',
//                             style: TextStyle(fontSize: 11.sp),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           icon: Icon(
//                             Icons.circle,
//                             size: 16.sp,
//                           ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               '฿',
//                               style: TextStyle(
//                                 fontSize: 8.sp,
//                                 color: Colors.grey[600],
//                               ),
//                             ),
//                             Text(
//                               '350',
//                               style: TextStyle(
//                                 fontSize: 9.5.sp,
//                                 color: Colors.grey[600],
//                                 decoration: TextDecoration.lineThrough,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 3,
//                             ),
//                             Text(
//                               '฿',
//                               style: TextStyle(
//                                 fontSize: 8.sp,
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Text(
//                               '250',
//                               style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               'ขายได้ 100 ชิ้น',
//                               style: TextStyle(
//                                 fontSize: 8.sp,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               width: 35.sp,
//                               // color: Colors.black.withOpacity(0.2),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Icon(
//                                     Icons.circle_rounded,
//                                     size: 5.sp,
//                                     color: Colors.yellow[700],
//                                   ),
//                                   Icon(
//                                     Icons.circle_rounded,
//                                     size: 5.sp,
//                                     color: Colors.yellow[700],
//                                   ),
//                                   Icon(
//                                     Icons.circle_rounded,
//                                     size: 5.sp,
//                                     color: Colors.yellow[700],
//                                   ),
//                                   Icon(
//                                     Icons.circle_rounded,
//                                     size: 5.sp,
//                                     color: Colors.yellow[700],
//                                   ),
//                                   Icon(
//                                     Icons.circle_rounded,
//                                     size: 5.sp,
//                                     color: Colors.yellow[700],
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
