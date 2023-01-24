import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/account/myaccount/address/address_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/bio/bio_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/birth/birth_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/email/change_email_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/gender/gender_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/password/change_password_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/picture/image_profile_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/username_screen.dart';
import 'package:mtw_project/views/screens/account/setup_screen.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    super.initState();
  }

  var result1;

  profiledetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/account-detail";
    var data = {'userid': '${userId}'};
    await http.post(Uri.parse(url), body: data).then((response) async {
      // rint('this response = ${response.body}');
      result1 = jsonDecode(response.body);
    });
    return result1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SetupScreen(),
                ),
                (route) => false);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'หน้าโปรไฟล์',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            // flex: 12,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: FutureBuilder(
                future: profiledetail(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: 170,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.central),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () {},
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Stack(
                                    children: [
                                      if (result1['image'] == null) ...[
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              'https://mtwa.xyz/storage/app/public/user/human.png'),
                                        ),
                                      ] else ...[
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(
                                              'https://mtwa.xyz/storage/app/public/user/' +
                                                  result1['image']),
                                        ),
                                      ],
                                      // Positioned(
                                      //   bottom: 1,
                                      //   left: 30,
                                      //   child: Container(
                                      //     child: Center(
                                      //       child: GestureDetector(
                                      //         onTap: () {
                                      //           print('edit pic profile');
                                      //           Navigator.pushReplacement(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (BuildContext
                                      //                       context) =>
                                      //                   MainPic(
                                      //                 title: '',
                                      //               ),
                                      //             ),
                                      //           );
                                      //         },
                                      //         child: Text(
                                      //           'แก้ไข',
                                      //           style: TextStyle(
                                      //               fontSize: 7.sp,
                                      //               color: ColorResources
                                      //                   .KTextWhite),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   child: Center(
                          //     child: DecoratedBox(
                          //       child: Center(
                          //         child: GestureDetector(
                          //           onTap: () {
                          //             print('object bg 2');
                          //           },
                          //           child: Text(
                          //             'แก้ไข',
                          //             style: TextStyle(
                          //                 color: ColorResources.KTextWhite),
                          //           ),
                          //         ),
                          //       ),
                          //       decoration: const BoxDecoration(
                          //           color: ColorResources.ICON_Gray),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ชื่อผู้ใช้',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                UserNameScreen(
                                                    name: result1['name']),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            result1['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Bio',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BioScreen(
                                                    bio: (result1['Bio'] ==
                                                            null)
                                                        ? 'Bio'
                                                        : '${result1['Bio']}'),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          if (result1['Bio'] == null) ...[
                                            Text(
                                              'ตั้งค่าตอนนี้',
                                              style: TextStyle(
                                                color: ColorResources
                                                    .ICON_Light_Gray,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ] else if (result1['Bio'] !=
                                              null) ...[
                                            Text(
                                              result1['Bio'],
                                              style: TextStyle(
                                                color:
                                                    ColorResources.KTextBlack,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'เพศ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                GenderScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          if (result1['gender'] == 'M') ...[
                                            Text(
                                              'ชาย',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ] else if (result1['gender'] ==
                                              'F') ...[
                                            Text(
                                              'หญิง',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ] else if (result1['gender'] ==
                                              null) ...[
                                            Text(
                                              'ตั้งค่าตอนนี้',
                                              style: TextStyle(
                                                color: ColorResources
                                                    .ICON_Light_Gray,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'วันเกิด',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                BirthScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          if (result1['birth'] == null) ...[
                                            Text(
                                              'ตั้งค่าตอนนี้',
                                              style: TextStyle(
                                                color: ColorResources
                                                    .ICON_Light_Gray,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ] else ...[
                                            Text(
                                              result1['birth'].toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'เบอร์ติดต่อ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                PhoneScreen(
                                              phone: (result1['phone'] == null)
                                                  ? 'Phone'
                                                  : '${result1['phone']}',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          if (result1['phone'] == null) ...[
                                            Text(
                                              'ตั้งค่าตอนนี้',
                                              style: TextStyle(
                                                color: ColorResources
                                                    .ICON_Light_Gray,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ] else ...[
                                            Text(
                                              result1['phone'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Email',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChangeEmailScreen(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          if (result1['email'] == null) ...[
                                            Text(
                                              'ตั้งค่าตอนนี้',
                                              style: TextStyle(
                                                color: ColorResources
                                                    .ICON_Light_Gray,
                                                fontSize: 7.sp,
                                              ),
                                            ),
                                          ] else ...[
                                            Text(
                                              result1['email'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8, left: 25, right: 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'เปลี่ยนรหัสผ่าน',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChangePasswordScreen(
                                              phone: result1['phone'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 0.5,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
