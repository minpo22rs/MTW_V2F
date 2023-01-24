// import 'dart:convert';
// import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:mtw_project/models/room_model.dart';
// import 'package:mtw_project/utill/color.resouces.dart';
// import 'package:mtw_project/utill/images.dart';
// import 'package:mtw_project/views/screens/hotels/hotel_detail_screen.dart';
// import 'package:sizer/sizer.dart';

// class HotelListView extends StatefulWidget {
//   final List hotels;
//   const HotelListView({Key? key, required this.hotels}) : super(key: key);
//   @override
//   _HotelListViewState createState() => _HotelListViewState(hotels);
// }

// class _HotelListViewState extends State<HotelListView> {
//   late List hotels;
//   _HotelListViewState(this.hotels);
//   List<RoomsChoose> rooms = <RoomsChoose>[];
//   var resultData;
//   @override
//   Widget build(BuildContext context) {
//     return Flexible(
//       child: ListView.builder(
//         itemCount: hotels.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 9),
//             child: Column(
//               children: [
//                 FlatButton(
//                   onPressed: () async {
//                     var url = "https://mtwa.xyz/API/hotel-detail";
//                     var data = {'hotel_id': '${hotels[index].id}'};
//                     await http
//                         .post(Uri.parse(url), body: data)
//                         .then((response) {
//                       print('this response = ${response.body}');
//                       var result = jsonDecode(response.body);
//                       resultData = result['cr'];
//                       rooms = <RoomsChoose>[];
//                       for (var i = 0; i < resultData.length; i++) {
//                         RoomsChoose t = RoomsChoose.fromJson(resultData[i]);
//                         rooms.add(t);
//                       }
//                       if (response.statusCode == 200) {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => HotelDetailScreen(
//                                 id: '${result['hotel']['id']}',
//                                 name: '${result['hotel']['shopname']}',
//                                 location: '${result['hotel']['position_url']}',
//                                 image: '${result['hotel']['image']}',
//                                 rating: '${result['hotel']['rating']}',
//                                 rooms: rooms),
//                           ),
//                         );
//                       } else {
//                         return;
//                       }
//                     });
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     height: 170.sp,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(12),
//                       ),
//                       border: Border.all(width: 2, color: Colors.grey),
//                     ),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 105.sp,
//                           height: 175.sp,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(10),
//                               bottomLeft: Radius.circular(10),
//                             ),
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                 'https://mtwa.xyz/storage/app/public/seller/' +
//                                     hotels[index].image,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 14,
//                               ),
//                               Row(
//                                 children: [
//                                   Container(
//                                     width: 100.sp,
//                                     // color: Colors.redAccent.withOpacity(0.2),
//                                     child: Text(
//                                       hotels[index].name,
//                                       style: TextStyle(fontSize: 11.sp),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       print('แชร์');
//                                     },
//                                     child: Icon(
//                                       Icons.ios_share_rounded,
//                                       color: ColorResources.ICON_Gray,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   GestureDetector(
//                                     onTap: () {
//                                       print('ถูกใจ');
//                                     },
//                                     child: Icon(
//                                       Icons.favorite,
//                                       color: ColorResources.ICON_Light_Gray,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 width: 60.sp,
//                                 // color: Colors.black.withOpacity(0.2),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.circle_rounded,
//                                         size: 8.sp,
//                                         color: ColorResources.ICON_Yellow),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Icon(Icons.circle_rounded,
//                                         size: 8.sp,
//                                         color: ColorResources.ICON_Yellow),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Icon(Icons.circle_rounded,
//                                         size: 8.sp,
//                                         color: ColorResources.ICON_Yellow),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Icon(Icons.circle_rounded,
//                                         size: 8.sp,
//                                         color: ColorResources.ICON_Yellow),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Icon(Icons.circle_rounded,
//                                         size: 8.sp,
//                                         color: ColorResources.ICON_Light_Gray),
//                                   ],
//                                 ),
//                               ),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     hotels[index].rating + '/5.00',
//                                     style: TextStyle(
//                                       fontSize: 10.sp,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 3,
//                                   ),
//                                   Container(
//                                     width: 1,
//                                     height: 13,
//                                     color: Colors.black54,
//                                   ),
//                                   SizedBox(
//                                     width: 3,
//                                   ),
//                                   Text(
//                                     'ดีมาก',
//                                     style: TextStyle(
//                                       fontSize: 10.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 2,
//                               ),
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/icons/location.svg',
//                                     width: 13,
//                                     height: 13,
//                                     color: ColorResources.ICON_Red,
//                                   ),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     hotels[index].location,
//                                     style: TextStyle(
//                                       fontSize: 10.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 35,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'ประเภทห้อง : ',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         'สแตนดาร์ดเตียงแฝด ',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'จำนวนเตียง : ',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         '2 เตียง',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Text(
//                                         'ราคาห้อง    : ',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                       Text(
//                                         '1,500 บาท',
//                                         style: TextStyle(
//                                           fontSize: 8.5.sp,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 3,
//                                   ),
//                                   Text(
//                                     'รวมภาษีและค่าธรรมเนียมแล้ว',
//                                     style: TextStyle(
//                                       fontSize: 7.sp,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(left: 8),
//                                     child: Text(
//                                       'ไม่ต้องชำระล่วงหน้า',
//                                       style: TextStyle(
//                                         fontSize: 6.5.sp,
//                                         color: Colors.grey[700],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
