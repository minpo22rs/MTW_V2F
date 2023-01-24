import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/generated/i18n.dart';
import 'package:mtw_project/models/hotel_readyuse_model.dart';
import 'package:mtw_project/models/vouchers_hotel.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/hotels/hotel_readyuse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TabUseLess extends StatefulWidget {
  const TabUseLess({Key? key}) : super(key: key);

  @override
  _TabUseLessState createState() => _TabUseLessState();
}

class _TabUseLessState extends State<TabUseLess> {
  List<VouchersH> vou = <VouchersH>[];
  var resultDataVH;
  listvouchersHotel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var link = "https://mtwa.xyz/API/useless-vouchers-hotel";
    var data = {'userId': '${userId}'};
    await http.post(Uri.parse(link), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataVH = result;
      vou = <VouchersH>[];

      for (var j = 0; j < resultDataVH.length; j++) {
        VouchersH d = VouchersH.fromJson(resultDataVH[j]);
        vou.add(d);
      }
    });
    return vou;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          FutureBuilder(
            future: listvouchersHotel(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: vou.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: GestureDetector(
                            onTap: () {
                              print('object');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelReadyUse(
                                    title: vou[index].name,
                                    vId: '${vou[index].id}',
                                    pageKey: 'useless',
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://mtwa.xyz/storage/app/public/hotel/thumbnail/' +
                                                    vou[index].images),
                                            fit: BoxFit.fill,
                                          ),
                                          color:
                                              Colors.redAccent.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                    ),
                                    SizedBox(width: 14),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          vou[index].name,
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'จำนวน 1 ห้อง',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          NumberFormat('#,###.##')
                                                  .format(vou[index].pirce)
                                                  .toString() +
                                              ' ฿',
                                          style: TextStyle(
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      (vou[index].orderdate.split(' ')[0])
                                              .split('-')[2] +
                                          '/' +
                                          vou[index].orderdate.split('-')[1] +
                                          '/' +
                                          vou[index].orderdate.split('-')[0],
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      vou[index].orderdate.split(' ')[1],
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    if (vou[index].statuspay == 'WG') ...[
                                      Text(
                                        'รอการชำระเงิน ณ ที่พัก',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: ColorResources.ICON_Yellow,
                                        ),
                                      ),
                                    ] else if (vou[index].statuspay == 'S') ...[
                                      Text(
                                        'ชำระเงินเรียบร้อย',
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: ColorResources.ICON_Green,
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
