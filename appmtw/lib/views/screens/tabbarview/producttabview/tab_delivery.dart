import 'package:flutter/material.dart';
import 'package:mtw_project/models/product_delivery_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/delivery/product_delivery_screen.dart';

class TabDelivery extends StatelessWidget {
  const TabDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productdelivery.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDeliveryScreen()));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 8, bottom: 8),
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
                                        image: AssetImage(Images.bangkok),
                                        fit: BoxFit.fill,
                                      ),
                                      color: Colors.redAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // 'ชื่อร้าน',
                                      productdelivery[index].namestore,
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      productdelivery[index]
                                          .quantity
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      productdelivery[index].price.toString(),
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
                                  'วว/ดด/ปป',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'เวลา',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'ชำระเงินเรียบร้อย',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
