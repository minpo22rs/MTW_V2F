import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtw_project/utill/dimensions.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/pages/home_scrren.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final namectrl = TextEditingController();
  final phonectrl = TextEditingController();
  final passwordctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Images.splash_screen,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              child: ListView(
                children: [
                  SizedBox(
                    height: 38.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: kTextcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_LARGE,
                        right: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: Container(
                      height: 30.sp,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 13.0, height: 0.9, color: Colors.black),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: namectrl,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        // keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_LARGE,
                        right: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: Container(
                      height: 30.sp,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 13.0, height: 0.9, color: Colors.black),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: phonectrl,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      "Password",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_LARGE,
                        right: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    child: Container(
                      height: 30.sp,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 13.0, height: 0.9, color: Colors.black),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: passwordctrl,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 1.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Text(
                      "OTP",
                      style: TextStyle(
                        fontSize: Dimensions.FONT_SIZE_SMALL,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 55.w,
                          height: 30.sp,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 13.0,
                                height: 0.9,
                                color: Colors.black),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 20.w,
                          height: 4.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue[900],
                            ),
                            onPressed: () {},
                            child: Text(
                              "ส่ง OTP",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_LARGE),
                    child: Row(
                      children: [
                        Container(
                          width: 32.sp,
                          height: 32.sp,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                ),
                              ]),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 32.sp,
                          height: 32.sp,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.PADDING_SIZE_LARGE,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              ('Already Member?'),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => NewLoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                (" Login "),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: Dimensions.PADDING_SIZE_DEFAULT),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            width: 90.sp,
                            height: 40.sp,
                            child: OutlinedButton(
                              onPressed: () async {
                                var url =
                                    "https://mtwa.xyz/API/register-mobile-mtwa";
                                var data = {
                                  'name': namectrl.text,
                                  'phone': phonectrl.text,
                                  'password': passwordctrl.text
                                };
                                await http
                                    .post(Uri.parse(url), body: data)
                                    .then((response) {
                                  print(phonectrl.text);
                                  var result = jsonDecode(response.body);
                                  if (response.statusCode == 200) {
                                    if (result['statusregister'] == '1') {
                                      Fluttertoast.showToast(
                                          msg: "Register Success",
                                          toastLength: Toast.LENGTH_SHORT);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (ctx) => NewLoginScreen(),
                                        ),
                                      );
                                    }
                                  }
                                });
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
