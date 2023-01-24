import 'package:flutter/material.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';

class SupportCenterScreen extends StatelessWidget {
  const SupportCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _showcontent = false;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'ศูนย์ความช่วยเหลือ',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'ศูนย์ความช่วยเหลือ',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   backgroundColor: Colors.white,
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.login_facebook),
                          fit: BoxFit.fill,
                        ),
                        // borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text('Facebook'),
                    Text('SAPAPPS - แซปแอป'),
                  ],
                ),
                // Column(
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 100,
                //       decoration: BoxDecoration(
                //         color: Colors.redAccent,
                //         borderRadius: BorderRadius.circular(14),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 22,
                //     ),
                //     Text('Line'),
                //     Text('ID Line'),
                //   ],
                // ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _showcontent
                    ? Text('เบอร์ติดต่อ' + ' ' + ':' + ' ' + 'xxx-xxx-xxxx')
                    : Container(),
                SizedBox(
                  height: 14,
                ),
                Text('อีเมล' + ' ' + ':' + ' ' + 'dev@sapappsthailand.co.th'),
              ],
            ),
          ),
          _showcontent
              ? RowList(
                  nameText: 'คำถามที่พบบ่อย',
                  iconData: Icons.build_circle_outlined,
                  onTap: () {},
                )
              : Container(),
          _showcontent
              ? RowList(
                  nameText: 'ให้คะแนน' + ' ' + 'แอพ',
                  iconData: Icons.build_circle_outlined,
                  onTap: () {},
                )
              : Container(),
          _showcontent
              ? RowList(
                  nameText: 'ข้อตกลงและเงื่อนไข',
                  iconData: Icons.build_circle_outlined,
                  onTap: () {},
                )
              : Container(),
          Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}

class RowList extends StatelessWidget {
  final String nameText;
  final IconData iconData;
  final Function onTap;

  const RowList({
    Key? key,
    required this.nameText,
    required this.iconData,
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
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      iconData,
                      size: 32,
                    ),
                    SizedBox(
                      width: 14,
                    ),
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
