import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';

class SelectAddress extends StatelessWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'เลือกที่อยู่',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ-นามสกุล',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ค่าเริ่มต้น',
                      style: TextStyle(
                        color: ColorResources.KTextBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 15,
                              height: 15,
                              color: ColorResources.ICON_Red,
                            ),
                            SizedBox(width: 18),
                            Container(
                              child: Text('รายละเอียดที่อยู่'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              width: 320,
                              height: 85,
                              // color: Colors.redAccent,
                              child: Text('รายละเอียด'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print('object');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectAddress()));
                      },
                      child: Container(
                        child: Icon(
                          Icons.check_circle,
                          color: ColorResources.ICON_Blue,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ-นามสกุล',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 15,
                              height: 15,
                              color: ColorResources.ICON_Red,
                            ),
                            SizedBox(width: 18),
                            Container(
                              child: Text('รายละเอียดที่อยู่'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              width: 320,
                              height: 85,
                              // color: Colors.redAccent,
                              child: Text('รายละเอียด'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Text(
                      'ชื่อ-นามสกุล',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 15,
                              height: 15,
                              color: ColorResources.ICON_Red,
                            ),
                            SizedBox(width: 18),
                            Container(
                              child: Text('รายละเอียดที่อยู่'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              width: 320,
                              height: 85,
                              // color: Colors.redAccent,
                              child: Text('รายละเอียด'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 1),
              Divider(thickness: 1),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'เพิ่มที่อยู่ใหม่',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  'assets/icons/plus.svg',
                  width: 30,
                  height: 30,
                )
              ],
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
