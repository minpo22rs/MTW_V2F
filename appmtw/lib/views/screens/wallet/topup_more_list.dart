import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/top_up_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class TopUpMore extends StatefulWidget {
  @override
  _TopUpMoreState createState() => _TopUpMoreState();
}

class _TopUpMoreState extends State<TopUpMore> {
  List<TopUp> topups = <TopUp>[];
  var resultData;
  listpay() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/account-list-payment";
    var data = {'userid': userId};
    await http.post(Uri.parse(url), body: data).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);

        resultData = result;
        topups = <TopUp>[];
        for (var j = 0; j < resultData.length; j++) {
          TopUp d = TopUp.fromJson(resultData[j]);
          topups.add(d);
        }
      }
    });
    return topups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.ICON_Black,
          ),
        ),
        title: Text(
          'Wallet',
          style: TextStyle(
            color: ColorResources.KTextBlack,
          ),
        ),
        backgroundColor: ColorResources.KTextWhite,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: listpay(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: topups.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Divider(
                            thickness: 0.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      topups[index].payment,
                                      style: TextStyle(
                                        fontSize: 12.5.sp,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            topups[index].name,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (topups[index].type == 'IW')
                                          ? 'THB' +
                                              ' ' +
                                              '+' +
                                              NumberFormat('#,###.##')
                                                  .format(topups[index].amount)
                                                  .toString()
                                          : (topups[index].amount == 0)
                                              ? 'vote free'
                                              : ''.toString() +
                                                  'THB' +
                                                  ' ' +
                                                  '-' +
                                                  NumberFormat('#,###.##')
                                                      .format(
                                                          topups[index].amount)
                                                      .toString(),
                                      // 'THB' + '_' + topups[index].amount.toString(),
                                      style: TextStyle(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.bold,
                                        color: (topups[index].type == 'IW')
                                            ? Colors.green
                                            : (topups[index].amount == 0)
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
