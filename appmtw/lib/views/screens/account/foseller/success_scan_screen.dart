import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/foseller/seller_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class SucScanScreen extends StatefulWidget {
  @override
  _SucScanScreenState createState() => _SucScanScreenState();
}

class _SucScanScreenState extends State<SucScanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.ICON_Blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.KTextBlue,
              ),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'MTW',
                    style: TextStyle(
                      color: ColorResources.KTextWhite,
                      fontSize: 15.sp,
                    ),
                  ),
                  Text(
                    'Success!',
                    style: TextStyle(
                      color: ColorResources.KTextWhite,
                      fontSize: 20.sp,
                    ),
                  ),
                  Text(
                    'ใช้สิทธิเรียบร้อยแล้วค่ะ',
                    style: TextStyle(
                      color: ColorResources.KTextWhite,
                      fontSize: 10.sp,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/check-01.svg',
                    width: 24,
                    height: 24,
                    color: ColorResources.ICON_Green,
                  ),
                ],
              )),
            ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          GestureDetector(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final String? userId = prefs.getString('username');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SellerScreen(userId: '${userId}'),
                  ),
                  (route) => false);
            },
            child: Container(
              width: 300,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorResources.KTextWhite,
              ),
              child: Center(
                child: Text(
                  'กลับสู่หน้าหลัก',
                  style: TextStyle(
                    color: ColorResources.KTextLightBlue,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
