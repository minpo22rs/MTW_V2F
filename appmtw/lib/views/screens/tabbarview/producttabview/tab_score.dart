import 'package:flutter/material.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/review/product_review_detail.dart';
import 'package:mtw_project/views/screens/score/score_one.dart';

class TabScore extends StatelessWidget {
  const TabScore({Key? key}) : super(key: key);

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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductReviewDetail()));
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
                      Container(
                        width: 210,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ScoreOne(
                                            sId: '',
                                            type: 'P',
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star_border_rounded),
                                SizedBox(width: 6),
                                Text('ให้คะแนน'),
                              ],
                            )),
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
