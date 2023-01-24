import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/edit_phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class OTPPhoneScreen extends StatefulWidget {
  final String phone, newphone;
  OTPPhoneScreen({Key? key, required this.phone, required this.newphone})
      : super(key: key);
  @override
  _OTPPhoneScreenState createState() => _OTPPhoneScreenState(phone, newphone);
}

class _OTPPhoneScreenState extends State<OTPPhoneScreen> {
  late String phone, newphone;
  _OTPPhoneScreenState(this.phone, this.newphone);
  TextEditingController otpctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => EditPhoneScreen(
                  phone: phone,
                ),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'รหัส OTP',
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
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'กรุณาใส่หมายเลข OTP',
                      style: TextStyle(
                        color: ColorResources.KTextGray,
                        fontSize: 8.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'ส่ง OTP อีกครั้ง',
                        style: TextStyle(
                          color: ColorResources.KTextLightBlue,
                          fontSize: 8.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                height: 40.sp,
                child: TextField(
                  style: TextStyle(
                    fontSize: 13.0,
                    height: 0.9,
                    color: ColorResources.ICON_Light_Gray,
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  controller: otpctrl,
                  decoration: InputDecoration(
                    hintText: 'OTP',
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
                height: 50,
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String? userId = prefs.getString('username');
                    var url = "https://mtwa.xyz/API/account-change";
                    var data = {
                      'userId': '${userId}',
                      'type': 'phone',
                      'text': '${otpctrl.text}',
                      'text2': '${newphone}',
                    };
                    await http.post(Uri.parse(url), body: data).then((value) {
                      var result = jsonDecode(value.body);
                      print(result);
                      if (result['status'] == '1') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => ProfileScreen(),
                          ),
                        );
                      } else if (result['status'] == '2') {
                        Fluttertoast.showToast(
                            msg: "กรุณากรอกข้อมูลค่ะ",
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT);
                      } else if (result['status'] == '4') {
                        Fluttertoast.showToast(
                            msg: "รหัส OTP ไม่ถูกต้องค่ะ",
                            gravity: ToastGravity.CENTER,
                            toastLength: Toast.LENGTH_SHORT);
                      }
                    });
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
