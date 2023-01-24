import 'dart:convert';
import 'dart:ui';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mtw_project/models/sos_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:sizer/sizer.dart';

class SosScreen extends StatefulWidget {
  @override
  _SosScreenState createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  List<SosModel> sosmodel = <SosModel>[];
  var resultDataS;
  listsosloop() async {
    var url = "https://mtwa.xyz/API/sos";
    await http.get(Uri.parse(url)).then((response) async {
      var result1 = jsonDecode(response.body);
      resultDataS = result1;
      sosmodel = <SosModel>[];
      for (var i = 0; i < resultDataS.length; i++) {
        SosModel t = SosModel.fromJson(resultDataS[i]);
        sosmodel.add(t);
      }
    });

    return sosmodel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: ColorResources.ICON_Gray,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text(
          'แจ้งเหตุฉุกเฉิน',
          style: TextStyle(color: Colors.black),
        ),
        // backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: 200,
              child: FutureBuilder(
                future: listsosloop(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      child: ListView.builder(
                          itemCount: sosmodel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Divider(
                                  thickness: 0.5,
                                  color: Colors.grey,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 25, right: 10, top: 10),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                "https://mtwa.xyz/storage/app/public/emgs_logo/" +
                                                    sosmodel[index].img),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 10, top: 10),
                                          child: Container(
                                              width: 120.sp,
                                              child:
                                                  Text(sosmodel[index].name)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 25, right: 25, top: 10),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  // width: double.infinity,
                                                  height: 130,
                                                  // decoration: BoxDecoration(
                                                  //   borderRadius: (BorderRadius.only(
                                                  //     topLeft: Radius.circular(40),
                                                  //     topRight: Radius.circular(12),
                                                  //   )),
                                                  // ),
                                                  // color: Colors.redAccent.withOpacity(0.2),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 50,
                                                        // color: Colors.redAccent,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Center(
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            40),
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () async {
                                                                        var number = sosmodel[index]
                                                                            .tel
                                                                            .toString();
                                                                        bool?
                                                                            res =
                                                                            await FlutterPhoneDirectCaller.callNumber(number);
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        'โทรหา ' +
                                                                            sosmodel[index].tel.toString(),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          print('object');
                                                        },
                                                        child: Text(
                                                          'ยกเลิก',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.cyan,
                                          minimumSize: const Size(20, 20),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                        ),
                                        child: Text(
                                          'โทร',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
