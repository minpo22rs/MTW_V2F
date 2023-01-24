import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/phone/edit_phone_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:sizer/sizer.dart';

class PhoneScreen extends StatefulWidget {
  final String phone;
  PhoneScreen({Key? key, required this.phone}) : super(key: key);
  @override
  _PhoneScreenState createState() => _PhoneScreenState(phone);
}

class _PhoneScreenState extends State<PhoneScreen> {
  late String phone;
  _PhoneScreenState(this.phone);
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
          'โทรศัพท์',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'เบอร์ติดต่อ',
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Text(phone),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EditPhoneScreen(
                                phone: phone,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'แก้ไข',
                          style:
                              TextStyle(color: ColorResources.KTextLightBlue),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.5,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
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
          ],
        ),
      ),
    );
  }
}
