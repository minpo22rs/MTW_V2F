// import 'package:flutter/material.dart';
// import 'package:mtw_project/views/screens/pages/widgets/circleavatar_widget.dart';
// import 'package:mtw_project/views/screens/pages/widgets/circleavtar_topthree_widget.dart';
// import 'package:sizer/sizer.dart';

// class RatingWidget extends StatelessWidget {
//   const RatingWidget({Key? key}) : super(key: key);

//   Widget _buildTopThree() {
//     return Container(
//       // color: Colors.amberAccent,
//       width: double.infinity,
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             child: Column(
//               children: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       CircleAvatarTopThreeWidget(
//                         rating: 1,
//                         province: 'กรุงเทพมหานคร',
//                         name: 'Name',
//                         score: 999,
//                         raduis: 55,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Column(
//                         children: [
//                           CircleAvatarTopThreeWidget(
//                             rating: 2,
//                             province: 'พระนครศรีอยุธยา',
//                             name: 'Name',
//                             score: 999,
//                             raduis: 55,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Column(
//                         children: [
//                           CircleAvatarTopThreeWidget(
//                             rating: 3,
//                             province: 'Province',
//                             name: 'Name',
//                             score: 999,
//                             raduis: 55,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildBoard() {
//     return Container(
//       width: double.infinity,
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 4,
//                   name: 'Name',
//                   province: 'กรุงเทพมหานคร',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 5,
//                   name: 'Name',
//                   province: 'พระนครศรีอยุธยา',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 6,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 7,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 8,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 9,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 10,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 11,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 12,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 13,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 14,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//                 CircleAvatarWidget(
//                   raduis: 35,
//                   rating: 15,
//                   name: 'Name',
//                   province: 'Province',
//                   score: 999,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildTopThree(),
//         _buildBoard(),
//       ],
//     );
//   }
// }
