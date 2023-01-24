import 'package:flutter/material.dart';
import 'package:mtw_project/utill/color.resouces.dart';

class ProductReviewDetail extends StatelessWidget {
  const ProductReviewDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(true);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorResources.ICON_Gray,
          ),
        ),
        title: Text(
          'รายละเอียดคำสั่งซื้อ',
          style: TextStyle(
            color: ColorResources.ICON_Black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 130,
              color: Colors.blue[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          'คำสั่งซื้อสำเร็จแล้ว',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          'ขอบคุณสำหรับการให้คะแนน ' + 'คุณสามารถแก้ไขรีวิวได้',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text('26-08-2021'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: Icon(Icons.ac_unit),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Divider(thickness: 1),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'สถานะการจัดส่ง',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text('ชื่อบริษัทที่จัดส่งสินค้า-ประเภทการจัดส่ง'),
                              SizedBox(height: 4),
                              Text('รหัสการจัดส่งสินค้า'),
                              SizedBox(height: 14),
                              Text('ชื่อบริษัทที่จัดส่งสินค้า-ประเภทการจัดส่ง'),
                              SizedBox(height: 4),
                              Text('dd/mm/yyyy ' + '00:00'),
                            ],
                          ),
                          // SizedBox(height: 10),
                          // Column(
                          //   children: [],
                          // ),
                        ],
                      ),
                      Text('ดูรายละเอียด')
                    ],
                  ),
                ),
              ],
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.ac_unit),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              Text(
                                'ที่อยู่ในการจัดส่ง',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Text('รายละเอียดที่อยู่'),
                            ],
                          ),
                        ],
                      ),
                      Text('คัดลอก')
                    ],
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
            Divider(thickness: 1),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                          ),
                          SizedBox(width: 10),
                          Text('ชื่อร้านค้า'),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios)
                    ],
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 14, right: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 75,
                            height: 75,
                            color: Colors.amber,
                            // child: ,
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ชื่อสินค้า'),
                              SizedBox(height: 3),
                              Text('จำนวนสินค้า'),
                              SizedBox(height: 3),
                              Text('ราคาต่อหน่วย'),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('x1'),
                          Text('฿ ' + '100.00'),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('รวมค่าสินค้า'),
                                  Text('ค่าจัดส่ง'),
                                  Text('รวมทั้งหมด'),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('฿ ' + '100.00'),
                              Text('฿ ' + '23.00'),
                              Text('฿ ' + '123.00'),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 15, bottom: 15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ช่องทางการชำระเงิน',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text('บัญชีธนาคาร'),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('หมายเลขคำสั่งซื้อ'),
                          SizedBox(height: 2),
                          Text('เวลาที่สั่งซื้อ'),
                          SizedBox(height: 2),
                          Text('เวลาชำระเงิน'),
                          SizedBox(height: 2),
                          Text('เวลาส่งสินค้า'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('คัดลอก'),
                          SizedBox(height: 2),
                          Text('23-08-2021 ' + '14:39'),
                          SizedBox(height: 2),
                          Text('23-08-2021 ' + '14:39'),
                          SizedBox(height: 2),
                          Text('23-08-2021 ' + '14:58'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(thickness: 1),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    // color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat),
                    SizedBox(width: 5),
                    Text('ติดต่อผู้ขาย'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blueAccent)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border),
                    SizedBox(width: 5),
                    Text('ดูคะแนน'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border, color: Colors.black12),
                    SizedBox(width: 5),
                    Text(
                      'ขยายระยะเวลาจัดส่งสำเร็จแล้ว',
                      style: TextStyle(color: Colors.black12),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 14),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ชื้ออีกครั้ง',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
