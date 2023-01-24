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

class NewPasswordScreen extends StatefulWidget {
  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController newpasswordctrl = TextEditingController();
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'เพื่อความปลอดภัยของบัญชีคุณ',
                    style: TextStyle(
                      color: ColorResources.KTextGray,
                      fontSize: 7.sp,
                    ),
                  ),
                  Text(
                    'กรุณายืนยันรหัสผ่านเพื่อดำเนินการต่อ',
                    style: TextStyle(
                      color: ColorResources.KTextGray,
                      fontSize: 7.sp,
                    ),
                  ),
                ],
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
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String? userId = prefs.getString('username');
                    var url = "https://mtwa.xyz/API/account-change";
                    var data = {
                      'userId': '${userId}',
                      'type': 'password',
                      'text': '${newpasswordctrl.text}'
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
