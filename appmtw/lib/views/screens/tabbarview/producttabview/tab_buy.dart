import 'package:flutter/material.dart';
import 'package:mtw_project/utill/images.dart';

class TabBuy extends StatelessWidget {
  const TabBuy({Key? key}) : super(key: key);

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
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Column(
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
                                    'ชื่อร้าน',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'จำนวนรายการสินค้า',
                                    style: TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'ราคาทั้งหมด',
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
