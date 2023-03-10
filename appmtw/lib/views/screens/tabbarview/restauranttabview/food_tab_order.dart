import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/order_res_model.dart';
import 'package:mtw_project/models/order_restaurant_model.dart';
import 'package:mtw_project/models/restaurant_readyuse_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_order.dart';
import 'package:mtw_project/views/screens/restaurant/restaurant_readyuse.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FoodTabOrder extends StatefulWidget {
  const FoodTabOrder({Key? key}) : super(key: key);

  @override
  _FoodTabOrderState createState() => _FoodTabOrderState();
}

class _FoodTabOrderState extends State<FoodTabOrder> {
  @override
  List<OrderResM> order = <OrderResM>[];

  var resultDataO;

  listorder() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    var url = "https://mtwa.xyz/API/show-order";
    var data = {'userId': '${userId}'};
    await http.post(Uri.parse(url), body: data).then((value) {
      var result = jsonDecode(value.body);
      resultDataO = result;
      order = <OrderResM>[];

      for (var j = 0; j < resultDataO.length; j++) {
        OrderResM d = OrderResM.fromJson(resultDataO[j]);
        order.add(d);
      }
      print(order);
    });
    return order;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          FutureBuilder(
            future: listorder(),
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
                    itemCount: order.length,
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
                                    builder: (context) => RestaurantOrder(
                                      resId: '${order[index].productId}',
                                      vId: '${order[index].id}',
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://mtwa.xyz/storage/app/public/vouchers/' +
                                                      order[index].images),
                                              fit: BoxFit.fill,
                                            ),
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                      SizedBox(width: 14),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order[index].name,
                                            style: TextStyle(
                                              fontSize: 11,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                              order[index].details,
                                              style: TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            '??????????????????????????? : ' +
                                                order[index]
                                                    .enddate
                                                    .split('-')[2] +
                                                '/' +
                                                order[index]
                                                    .enddate
                                                    .split('-')[1] +
                                                '/' +
                                                order[index]
                                                    .enddate
                                                    .split('-')[0],
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
                                        (order[index].orderdate.split(' ')[0])
                                                .split('-')[2] +
                                            '/' +
                                            order[index]
                                                .orderdate
                                                .split('-')[1] +
                                            '/' +
                                            order[index]
                                                .orderdate
                                                .split('-')[0],
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text(
                                        order[index].orderdate.split(' ')[1],
                                        style: TextStyle(
                                          fontSize: 11,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      if (order[index].statuspay == 'S') ...[
                                        Text(
                                          '???????????????????????????????????????????????????',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ] else ...[
                                        Text(
                                          '???????????????????????????',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.red[700],
                                          ),
                                        ),
                                      ],
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
              }
            },
          ),
        ],
      ),
    );
  }
}
