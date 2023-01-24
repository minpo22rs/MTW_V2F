import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/account/myaccount/address/address_screen.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController namectrl = TextEditingController();
  TextEditingController phonectrl = TextEditingController();
  TextEditingController detailctrl = TextEditingController();
  bool valueswitch = false;
  String provinceChoose = 'จังหวัด';
  String districtChoose = 'อำเภอ';
  String subdistrictChoose = 'ตำบล';
  String postcodeChoose = 'รหัสไปรษณีย์';

  late List provinces = ['จังหวัด'];
  late List district = ['อำเภอ'];
  late List subdistrict = ['ตำบล'];
  late List postcode = ['รหัสไปรษณีย์'];

  getProvinces() async {
    var url = "https://mtwa.xyz/API/getProvinces";
    await http.get(Uri.parse(url)).then((response) async {
      var result1 = jsonDecode(response.body);
      provinces = result1['name'];
    });
    return provinces;
  }

  Future getDistrict(var p) async {
    if (p != '') {
      var url = "https://mtwa.xyz/API/getDistrict";
      var data = {'province': '${p}'};
      await http.post(Uri.parse(url), body: data).then((value) {
        var result = jsonDecode(value.body);
        if (value.statusCode == 200) {
          setState(() {
            district = result['name'];
          });
        }
      });
    } else {
      district = ['อำเภอ'];
    }
  }

  Future getSubDistrict(var p, var t) async {
    if (p != '') {
      var url = "https://mtwa.xyz/API/getSubDistrict";
      var data = {'district': '${p}', 'type': '${t}'};
      await http.post(Uri.parse(url), body: data).then((value) {
        var result = jsonDecode(value.body);
        if (value.statusCode == 200) {
          setState(() {
            subdistrict = result['name'];
          });
        }
      });
    } else {
      subdistrict = ['ตำบล'];
    }
  }

  Future getPostCode(var p, var t) async {
    if (p != '') {
      var url = "https://mtwa.xyz/API/getSubDistrict";
      var data = {'district': '${p}', 'type': '${t}'};
      await http.post(Uri.parse(url), body: data).then((value) {
        var result = jsonDecode(value.body);
        if (value.statusCode == 200) {
          setState(() {
            postcode = result['name'];
          });
        }
      });
    } else {
      postcode = ['รหัสไปรษณีย์'];
    }
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
                builder: (BuildContext context) => AddressScreen(),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'ที่อยู่ใหม่',
          style: TextStyle(color: ColorResources.KTextBlack),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 600,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Text('ช่องทางการติดต่อ'),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Container(
                    height: 10.sp,
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
                        hintText: 'ชื่อ-นามสกุล',
                        hintStyle: TextStyle(color: ColorResources.KTextGray),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Container(
                    height: 10.sp,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 13.0,
                        height: 0.9,
                        color: ColorResources.ICON_Light_Gray,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      controller: phonectrl,
                      decoration: InputDecoration(
                        hintText: 'หมายเลขโทรศัพท์',
                        hintStyle: TextStyle(color: ColorResources.KTextGray),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Text('ที่อยู่'),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.ICON_Light_Gray,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: FutureBuilder(
                      future: getProvinces(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return DropdownButton(
                            value: provinceChoose,
                            onChanged: (newValue) {
                              setState(() {
                                if (newValue == 'จังหวัด') {
                                  provinceChoose = 'จังหวัด';
                                  district = ['อำเภอ'];
                                  subdistrict = ['ตำบล'];
                                  districtChoose = 'อำเภอ';
                                  subdistrictChoose = 'ตำบล';
                                } else {
                                  district = ['อำเภอ'];
                                  subdistrict = ['ตำบล'];
                                  districtChoose = 'อำเภอ';
                                  subdistrictChoose = 'ตำบล';
                                  provinceChoose = newValue.toString();
                                }
                              });
                            },
                            icon: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(Icons.arrow_drop_down)),
                            iconEnabledColor: Colors.black,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                            underline: Container(),
                            isExpanded: true,
                            items: provinces.map((valueItem) {
                              return DropdownMenuItem(
                                value: valueItem,
                                child: Text(
                                  valueItem,
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                        return DropdownButton(
                          value: provinceChoose,
                          onChanged: (newValue) {
                            setState(() {
                              if (newValue == 'จังหวัด') {
                                provinceChoose = 'จังหวัด';
                                district = ['อำเภอ'];
                                subdistrict = ['ตำบล'];
                                postcode = ['รหัสไปรษณีย์'];
                                districtChoose = 'อำเภอ';
                                subdistrictChoose = 'ตำบล';
                                postcodeChoose = 'รหัสไปรษณีย์';
                              } else {
                                district = ['อำเภอ'];
                                subdistrict = ['ตำบล'];
                                postcode = ['รหัสไปรษณีย์'];
                                districtChoose = 'อำเภอ';
                                subdistrictChoose = 'ตำบล';
                                postcodeChoose = 'รหัสไปรษณีย์';
                                provinceChoose = newValue.toString();
                                getDistrict(provinceChoose);
                              }
                            });
                          },
                          icon: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.arrow_drop_down)),
                          iconEnabledColor: Colors.black,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10.sp,
                          ),
                          underline: Container(),
                          isExpanded: true,
                          items: provinces.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(
                                valueItem,
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.ICON_Light_Gray,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButton(
                      value: districtChoose,
                      onChanged: (newValuedistrict) {
                        setState(() {
                          if (newValuedistrict == 'อำเภอ') {
                            districtChoose = 'อำเภอ';
                            subdistrict = ['ตำบล'];
                            postcode = ['รหัสไปรษณีย์'];
                            subdistrictChoose = 'ตำบล';
                            postcodeChoose = 'รหัสไปรษณีย์';
                          } else {
                            districtChoose = newValuedistrict.toString();
                            subdistrict = ['ตำบล'];
                            postcode = ['รหัสไปรษณีย์'];
                            subdistrictChoose = 'ตำบล';
                            postcodeChoose = 'รหัสไปรษณีย์';
                            getSubDistrict(districtChoose, 'T');
                          }
                        });
                      },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.arrow_drop_down)),
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      items: district.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.ICON_Light_Gray,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButton(
                      value: subdistrictChoose,
                      onChanged: (newValuesubdistrict) {
                        setState(() {
                          if (newValuesubdistrict == 'ตำบล') {
                            subdistrictChoose = 'ตำบล';
                            postcode = ['รหัสไปรษณีย์'];
                            postcodeChoose = 'รหัสไปรษณีย์';
                          } else {
                            subdistrictChoose = newValuesubdistrict.toString();
                            postcode = ['รหัสไปรษณีย์'];
                            postcodeChoose = 'รหัสไปรษณีย์';
                            getPostCode(subdistrictChoose, 'P');
                          }
                        });
                      },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.arrow_drop_down)),
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      items: subdistrict.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorResources.ICON_Light_Gray,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: DropdownButton(
                      value: postcodeChoose,
                      onChanged: (newValuepostcode) {
                        setState(() {
                          if (newValuepostcode == 'รหัสไปรษณีย์') {
                            postcodeChoose = 'รหัสไปรษณีย์';
                          } else {
                            postcodeChoose = newValuepostcode.toString();
                          }
                        });
                      },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.arrow_drop_down)),
                      iconEnabledColor: Colors.black,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                      ),
                      underline: Container(),
                      isExpanded: true,
                      items: postcode.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(
                            valueItem,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Container(
                    height: 10.sp,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 13.0,
                        height: 0.9,
                        color: ColorResources.ICON_Light_Gray,
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(100),
                      ],
                      controller: detailctrl,
                      decoration: InputDecoration(
                        hintText: 'รายละเอียดที่อยู่',
                        hintStyle: TextStyle(color: ColorResources.KTextGray),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Text('ตั้งค่า'),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ตั้งค่าที่อยู่หลัก'),
                      CupertinoSwitch(
                          value: valueswitch,
                          onChanged: (value) {
                            setState(() {
                              valueswitch = !valueswitch;
                            });
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 25, right: 25),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    child: GestureDetector(
                      onTap: () async {
                        if (namectrl.text != '' &&
                            phonectrl.text != '' &&
                            provinceChoose != 'จังหวัด' &&
                            districtChoose != 'อำเภอ' &&
                            subdistrictChoose != 'ตำบล' &&
                            postcodeChoose != 'รหัสไปรษณีย์' &&
                            detailctrl.text != '') {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String? userId = prefs.getString('username');
                          var url = "https://mtwa.xyz/API/add-address";
                          var data = {
                            'userId': '${userId}',
                            'name': '${namectrl.text}',
                            'phone': '${phonectrl.text}',
                            'province': '${provinceChoose}',
                            'district': '${districtChoose}',
                            'subdistrict': '${subdistrictChoose}',
                            'postcode': '${postcodeChoose}',
                            'detail': '${detailctrl.text}',
                            'main': valueswitch ? '1' : '0',
                          };
                          print(data);
                          await http
                              .post(Uri.parse(url), body: data)
                              .then((value) {
                            var result = jsonDecode(value.body);
                            print(result);
                            if (result['status'] == '1') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddressScreen(),
                                ),
                              );
                            } else if (result['status'] == '2') {
                              Fluttertoast.showToast(
                                  msg: "กรุณากรอกข้อมูลค่ะ",
                                  gravity: ToastGravity.CENTER,
                                  toastLength: Toast.LENGTH_SHORT);
                            }
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg: "กรุณากรอกข้อมูลค่ะ",
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_SHORT);
                        }
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
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
