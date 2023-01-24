import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:mtw_project/views/screens/api/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UserNameScreen extends StatefulWidget {
  final String name;
  const UserNameScreen({Key? key, required this.name}) : super(key: key);
  @override
  _UserNameScreenState createState() => _UserNameScreenState(name);
}

class _UserNameScreenState extends State<UserNameScreen> {
  late String name;
  _UserNameScreenState(this.name);
  TextEditingController namectrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfileScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'เปลี่ยนชื่อผู้ใช้',
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
              Text(
                'ชื่อใหม่',
                style: TextStyle(
                  fontSize: 13.sp,
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
                  controller: namectrl,
                  decoration: InputDecoration(
                    hintText: name,
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
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 6),
                child: Text(
                  'ห้ามเกิน 100 ตัวอักษร',
                  style: TextStyle(color: ColorResources.KTextGray),
                ),
              ),
              SizedBox(
                height: 20,
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
                      'type': 'name',
                      'text': '${namectrl.text}'
                    };
                    print(data);
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
                      'บันทึก',
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
