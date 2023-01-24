import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/password/change_password_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/otp_phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ForgetPass extends StatefulWidget {
  final String phone;
  ForgetPass({Key? key, required this.phone}) : super(key: key);
  @override
  _ForgetPassState createState() => _ForgetPassState(phone);
}

class _ForgetPassState extends State<ForgetPass> {
  late String phone;
  _ForgetPassState(this.phone);
  TextEditingController newpasswordctrl = TextEditingController();
  TextEditingController otpctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'รหัสผ่านใหม่',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, right: 25, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 40.sp,
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        style: TextStyle(
                          fontSize: 13.0,
                          height: 0.9,
                          color: ColorResources.ICON_Light_Gray,
                        ),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                          //WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: otpctrl,
                        decoration: InputDecoration(
                          hintText: 'รหัส OTP',
                          hintStyle: TextStyle(color: ColorResources.KTextGray),
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
                              color: ColorResources.KTextGray,
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
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var url = "https://mtwa.xyz/API/otp-mobile-mtwa-reset";
                        var data = {
                          'phone': phone,
                        };
                        await http
                            .post(Uri.parse(url), body: data)
                            .then((response) {
                          var resultotp = jsonDecode(response.body);
                          print(resultotp);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: ColorResources.KTextBlue,
                        ),
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text(
                            'ส่งรหัส OTP',
                            style: TextStyle(
                              color: ColorResources.KTextWhite,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 40.sp,
                child: TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(
                    fontSize: 13.0,
                    height: 0.9,
                    color: ColorResources.ICON_Light_Gray,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  controller: newpasswordctrl,
                  decoration: InputDecoration(
                    hintText: 'รหัสผ่านใหม่',
                    hintStyle: TextStyle(color: ColorResources.KTextGray),
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
                        color: ColorResources.KTextGray,
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
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: GestureDetector(
                  onTap: () async {
                    print('u');
                    if (newpasswordctrl.text != '') {
                      if (otpctrl.text != '') {
                        var url = "https://mtwa.xyz/API/reset-mobile-mtwa";
                        var data = {
                          'phone': '${phone}',
                          'password': newpasswordctrl.text,
                          'otp_code': otpctrl.text,
                        };
                        await http
                            .post(Uri.parse(url), body: data)
                            .then((response) {
                          var result = jsonDecode(response.body);
                          print(result);
                          if (response.statusCode == 200) {
                            if (result['statusregister'] == '1') {
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "Reset Password Success",
                                  toastLength: Toast.LENGTH_SHORT);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => ProfileScreen(),
                                ),
                              );
                            } else if (result['statusregister'] == '2') {
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "เบอร์โทรศัพท์นี้ไม่พบในระบบค่ะ",
                                  toastLength: Toast.LENGTH_SHORT);
                            } else if (result['statusregister'] == '4') {
                              Fluttertoast.showToast(
                                  gravity: ToastGravity.CENTER,
                                  msg: "รหัส OTP ไม่ถูกต้องค่ะ",
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                            gravity: ToastGravity.CENTER,
                            msg: "กรุณากรอกรหัส OTP ของท่านค่ะ",
                            toastLength: Toast.LENGTH_SHORT);
                        return;
                      }
                    } else {
                      Fluttertoast.showToast(
                          gravity: ToastGravity.CENTER,
                          msg: "กรุณากรอกข้อมูลให้ครบค่ะ",
                          toastLength: Toast.LENGTH_SHORT);
                      return;
                    }
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.cyan),
                    child: Center(
                        child: Text(
                      'ยืนยัน',
                      style: TextStyle(
                        color: ColorResources.KTextWhite,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
