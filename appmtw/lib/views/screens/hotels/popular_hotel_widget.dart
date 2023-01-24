import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:sizer/sizer.dart';

class PoppularHotelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 135.sp,
          decoration: BoxDecoration(
            // color: Colors.redAccent.withOpacity(0.2),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            border: Border.all(width: 2, color: Colors.grey),
          ),
          child: Row(
            children: [
              Container(
                width: 140.sp,
                height: 175.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(Images.background),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Text(
                          'ชื่อโรงแรม',
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: 80.sp,
                      // color: Colors.black.withOpacity(0.2),
                      child: Row(
                        children: [
                          Icon(
                            Icons.circle_rounded,
                            size: 9.sp,
                            color: Colors.yellow[700],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 9.sp,
                            color: Colors.yellow[700],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 9.sp,
                            color: Colors.yellow[700],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 9.sp,
                            color: Colors.yellow[700],
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Icon(
                            Icons.circle_rounded,
                            size: 9.sp,
                            color: Colors.yellow[700],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                        Text(
                          ' | ',
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        Text(
                          'ดีมาก',
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 13.sp,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ตำแหน่ง',
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Row(
                    //       children: [
                    //         Text(
                    //           'ประเภทห้อง : ',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //         Text(
                    //           'สแตนดาร์ดเตียงแฝด ',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: 12,
                    //     ),
                    //     Row(
                    //       children: [
                    //         Text(
                    //           'จำนวนเตียง : ',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //         Text(
                    //           '2 เตียง',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: 12,
                    //     ),
                    //     Row(
                    //       children: [
                    //         Text(
                    //           'ราคาห้อง    : ',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //         Text(
                    //           '1,500 บาท',
                    //           style: TextStyle(
                    //             fontSize: 9.5.sp,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     SizedBox(
                    //       height: 3,
                    //     ),
                    //     Text(
                    //       'รวมภาษีและค่าธรรมเนียมแล้ว',
                    //       style: TextStyle(
                    //         fontSize: 7.sp,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 5,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 8),
                    //       child: Text(
                    //         'ไม่ต้องชำระล่วงหน้า',
                    //         style: TextStyle(
                    //           fontSize: 6.5.sp,
                    //           color: Colors.grey[700],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
