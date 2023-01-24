import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mtw_project/models/address_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/address/add_address_screen.dart';
import 'package:mtw_project/views/screens/account/myaccount/profile_screen.dart';
import 'package:mtw_project/views/screens/account/setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<AddressM> addressm = <AddressM>[];
  var resultDataA;

  addressdetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/address-detail";
    var data = {'userId': '${userId}'};
    await http.post(Uri.parse(url), body: data).then((response) async {
      // rint('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultDataA = result1;
      addressm = <AddressM>[];
      for (var i = 0; i < resultDataA.length; i++) {
        AddressM t = AddressM.fromJson(resultDataA[i]);
        addressm.add(t);
      }
    });
    return addressm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SetupScreen(),
                ),
                (route) => false);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'ที่อยู่ของฉัน',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: addressdetail(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          // color: Colors.redAccent,
                          width: double.infinity,
                          height: 550,
                          child: ListView.builder(
                            itemCount: addressm.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Container(
                                    height: 100.sp,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              top: 8,
                                              bottom: 8),
                                          child: Row(
                                            children: [
                                              Text(
                                                addressm[index].name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.sp,
                                              ),
                                              if (addressm[index].mdf ==
                                                  '1') ...[
                                                Text(
                                                  'ค่าเริ่มต้น',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorResources
                                                        .KTextBlue,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              top: 8,
                                              bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/location.svg',
                                                    width: 14,
                                                    height: 14,
                                                    color:
                                                        ColorResources.ICON_Red,
                                                  ),
                                                  SizedBox(
                                                    width: 10.sp,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      width: 200.sp,
                                                      child: Text('จังหวัด ' +
                                                          addressm[index]
                                                              .province +
                                                          ' เขต/เมือง ' +
                                                          addressm[index]
                                                              .district +
                                                          ' ตำบล' +
                                                          addressm[index]
                                                              .subdistrict +
                                                          ' รหัสไปรษณีย์ ' +
                                                          addressm[index]
                                                              .postcode
                                                              .toString() +
                                                          ' ' +
                                                          addressm[index]
                                                              .detail),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (addressm[index].mdf ==
                                                  '1') ...[
                                                SvgPicture.asset(
                                                  'assets/icons/check-01.svg',
                                                  width: 24,
                                                  height: 24,
                                                  color: ColorResources
                                                      .KTextLightBlue,
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 0.5,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Divider(
            thickness: 0.5,
          ),
          Container(
            // color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'เพิ่มที่อยู่ใหม่',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  AddAddressScreen(),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/icons/plus.svg',
                          width: 24,
                          height: 24,
                          color: ColorResources.ICON_Black,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
