import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/address/select_address.dart';
import 'package:mtw_project/views/screens/payment/select_payment.dart';

class BuyProduct extends StatefulWidget {
  const BuyProduct({Key? key}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  bool value1 = false;
  bool valueswitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ทำการสั่งซื้อ',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'ชื่อ-นามสกุล',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/location.svg',
                              width: 15,
                              height: 15,
                              color: ColorResources.ICON_Red,
                            ),
                            SizedBox(width: 18),
                            Container(
                              child: Text('รายละเอียดที่อยู่'),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              width: 320,
                              height: 85,
                              // color: Colors.redAccent,
                              child: Text('รายละเอียด'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print('object');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectAddress()));
                      },
                      child: Container(
                        child: Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shop.svg',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 10),
                        Text('ชื่อร้านค้า'),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18, top: 10, right: 18),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.3),
                              image: DecorationImage(
                                  image: AssetImage(Images.icon_vote_1),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              // color: Colors.redAccent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('ชื่อสินค้า'),
                                      Text('ตัวเลือกสินค้า'),
                                      Text('ราคาต่อหน่วย'),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(''),
                                      Text('x1'),
                                      Text('฿' + '100.00'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 11),
                  Container(
                    width: double.infinity,
                    height: 115,
                    decoration: BoxDecoration(
                        color: Colors.blue[100]!.withOpacity(0.5),
                        border: Border.all(color: Colors.black12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 18, top: 14, bottom: 4),
                          child: Text(
                            'ตัวเลือกการขนส่ง',
                            style: TextStyle(
                              color: ColorResources.KTextLightBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(
                          indent: 14,
                          endIndent: 14,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 18, top: 4, bottom: 4, right: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ชื่อบริษัทขนส่ง - ประเภทของการจัดส่ง'),
                                  Text(
                                    'จะได้รับใน' +
                                        ' ' +
                                        'dd/mm/yy' +
                                        ' ' +
                                        '-' +
                                        ' ' +
                                        'dd/mm/yy',
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('฿' + ' ' + '23.00'),
                                  Icon(Icons.arrow_forward_ios_rounded)
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('หมายเหตุ :'),
                        Text(
                          'ฝากข้อความถึงผู้ขายหรือบริษัทขนส่ง',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorResources.KTextGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 2, right: 20, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('คำสั่งซื้อทั้งหมด ' + '(1 ชิ้น)'),
                        Text(
                          '฿' + ' ' + '123.00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorResources.KTextLightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(thickness: 1),
                  Divider(thickness: 1),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.card_giftcard_rounded),
                                SizedBox(width: 6),
                                Text('โค้ดส่วนลด'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('เลือกโค้ดส่วนลด'),
                                Icon(Icons.arrow_forward_ios_rounded),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/coin.svg',
                                  width: 25,
                                  height: 25,
                                ),
                                SizedBox(width: 6),
                                Text('คุณมีคะแนนไม่พอ'),
                              ],
                            ),
                            Row(
                              children: [
                                CupertinoSwitch(
                                    value: valueswitch,
                                    onChanged: (value) {
                                      setState(() {
                                        valueswitch = !valueswitch;
                                      });
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.card_giftcard_rounded),
                                SizedBox(width: 6),
                                Text('วิธีการชำระเงิน'),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectPayment()));
                                print('object');
                              },
                              child: Row(
                                children: [
                                  Text('เลือกวิธีการชำระเงิน'),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('รวมการสั่งซื้อ'),
                            SizedBox(height: 4),
                            Text('ค่าจัดส่ง'),
                            SizedBox(height: 4),
                            Text('ยอดชำระเงินทั้งหมด'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('฿' + ' ' + '100.00'),
                            SizedBox(height: 4),
                            Text('฿' + ' ' + '23.00'),
                            SizedBox(height: 4),
                            Text('฿' + ' ' + '123.00'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('ยอดชำระเงินทั้งหมด ฿ 100.00'),
                          Text('ได้รับ 0 คะแนน'),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        width: 120,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(primary: Colors.cyan),
                          child: Text(
                            'สั่งสินค้า',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
