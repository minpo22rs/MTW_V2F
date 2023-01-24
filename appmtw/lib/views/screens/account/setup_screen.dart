import 'package:flutter/material.dart';
import 'package:mtw_project/views/screens/account/myaccount/address/address_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => AcountScreen()),
                (route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ตั้งค่าบัญชี',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 30),
              child: Text('บัญชีของฉัน'),
            ),
            RowList(
                nameText: 'หน้าโปรไฟล์',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => ProfileScreen()));
                }),
            RowList(
                nameText: 'ที่อยู่ของฉัน',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => AddressScreen()));
                }),
            // RowList(nameText: 'รายการบัญชีธนาคาร/บัตรที่บันทึก', onTap: () {}),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, top: 30),
            //   child: Text('ตั่งค่า'),
            // ),
            // RowList(nameText: 'ตั่งค่าการแจ้งเตือน', onTap: () {}),
            // RowList(nameText: 'การตั้งค่าความเป็นส่วนตัว', onTap: () {}),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, top: 30),
            //   child: Text('ช่วยเหลือ'),
            // ),
            // RowList(nameText: 'ศูนย์ช่วยเหลือ', onTap: () {}),
            // RowList(nameText: 'เคล็ดลับและเทคนิค', onTap: () {}),
            // RowList(nameText: 'กฏระเบียบในการใช้', onTap: () {}),
            // RowList(nameText: 'นโยบายของ MTW', onTap: () {}),
            // RowList(nameText: 'ให้คะแนนชื่อแอพ', onTap: () {}),
            // RowList(nameText: 'เกี่ยวกับ', onTap: () {}),
            // RowList(nameText: 'คำขอลบบัญชีผู้ใช้', onTap: () {}),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class RowList extends StatelessWidget {
  final String nameText;

  final VoidCallback onTap;

  const RowList({
    Key? key,
    required this.nameText,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 0.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(nameText),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          ),
        ),
        // Divider(
        //   thickness: 0.5,
        // ),
      ],
    );
  }
}
