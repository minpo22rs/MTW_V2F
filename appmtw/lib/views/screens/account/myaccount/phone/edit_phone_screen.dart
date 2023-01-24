import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/otp_phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class EditPhoneScreen extends StatefulWidget {
  final String phone;
  EditPhoneScreen({Key? key, required this.phone}) : super(key: key);
  @override
  _EditPhoneScreenState createState() => _EditPhoneScreenState(phone);
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  late String phone;
  _EditPhoneScreenState(this.phone);
  TextEditingController newphonectrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => PhoneScreen(
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
          'เบอร์โทรศัพท์ใหม่',
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
                'กรุณาใส่หมายเลขโทรศัพท์เพื่อรับ OTP',
                style: TextStyle(
                  color: ColorResources.KTextGray,
                  fontSize: 7.sp,
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
                    LengthLimitingTextInputFormatter(10),
                    //WhitelistingTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                  controller: newphonectrl,
                  decoration: InputDecoration(
                    hintText: 'หมายเลขโทรศัพท์',
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
                  'หากคุณแก้ไขหมายเลขโทรศัพท์ หมายเลขโทรศัพท์ของบัญชีทั้งหมดที่ผูกกับบัญชีผู้ใช้นี้จะถูกแก้ไขตามไปด้วย',
                  style: TextStyle(
                    color: ColorResources.KTextGray,
                    fontSize: 6.sp,
                  ),
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
                    var url = "https://mtwa.xyz/API/otp-phone-mtwa-reset";
                    var data = {'phone': '${newphonectrl.text}'};
                    await http.post(Uri.parse(url), body: data).then((value) {
                      var result = jsonDecode(value.body);
                      print(result);
                      if (result['status'] == '1') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => OTPPhoneScreen(
                              phone: phone,
                              newphone: '${newphonectrl.text}',
                            ),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: "พบปัญหากรุณาติดต่อผู้ดูแลค่ะ",
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
                      'ดำเนินการต่อ',
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
