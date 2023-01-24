import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "ชาย",
              style: TextStyle(
                color: ColorResources.KTextBlack,
              ),
            ),
          ),
          value: "MALE"),
      DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "หญิง",
              style: TextStyle(
                color: ColorResources.KTextBlack,
              ),
            ),
          ),
          value: "FEMALE"),
    ];
    return menuItems;
  }

  String selectedValue = 'MALE';

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
          'เพศ',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Container(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, right: 25, left: 25),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              DropdownButtonHideUnderline(
                child: Container(
                  width: double.infinity,
                  height: 40.sp,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: ColorResources.ICON_Gray,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  child: DropdownButton(
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
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
                      'type': 'gender',
                      'text': '${selectedValue}'
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
