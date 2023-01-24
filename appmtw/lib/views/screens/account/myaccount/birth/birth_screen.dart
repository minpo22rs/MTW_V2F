import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class BirthScreen extends StatefulWidget {
  @override
  _BirthScreenState createState() => _BirthScreenState();
}

class _BirthScreenState extends State<BirthScreen> {
  DateTime selectedDate = DateTime.now();
  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: selectedDate, // Refer step 1
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2025),
  //     helpText: 'เลือกวันเกิด',
  //     fieldLabelText: 'เลือกวันที่',
  //     fieldHintText: 'เดือน/วัน/ปี',
  //     cancelText: 'ยกเลิก',
  //     confirmText: 'ดำเนินการต่อ',
  //     builder: (context, child) {
  //       return Theme(
  //         data: ThemeData.light(), // This will change to light theme.
  //         child: child,
  //       );
  //     },
  //   );
  //   if (picked != null && picked != selectedDate)
  //     setState(() {
  //       selectedDate = picked;
  //     });
  // }

  _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// This builds material date picker in Android
  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2025),
      helpText: 'เลือกวันเกิด',
      fieldLabelText: 'เลือกวันที่',
      fieldHintText: 'เดือน/วัน/ปี',
      cancelText: 'ยกเลิก',
      confirmText: 'ดำเนินการต่อ',
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  /// This builds cupertion date picker in iOS
  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null && picked != selectedDate)
                  setState(() {
                    selectedDate = picked;
                  });
              },
              initialDateTime: selectedDate,
              minimumYear: 1950,
              maximumYear: 2025,
            ),
          );
        });
  }

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
          'วันเกิด',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 0, left: 0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'วันเกิด',
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "${selectedDate.toLocal()}".split(' ')[0],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Text(
                            'แก้ไข',
                            style:
                                TextStyle(color: ColorResources.KTextLightBlue),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: GestureDetector(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final String? userId = prefs.getString('username');
                      var url = "https://mtwa.xyz/API/account-change";
                      var data = {
                        'userId': '${userId}',
                        'type': 'birth',
                        'text': "${selectedDate.toLocal()}".split(' ')[0]
                      };
                      await http.post(Uri.parse(url), body: data).then((value) {
                        var result = jsonDecode(value.body);
                        print(result);
                        if (result['status'] == '1') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProfileScreen(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
