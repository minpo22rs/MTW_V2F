import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtw_project/models/cart_product_model.dart';
import 'package:mtw_project/models/cart_seller_model.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/store/store_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TabStore extends StatefulWidget {
  const TabStore({Key? key}) : super(key: key);

  @override
  _TabStoreState createState() => _TabStoreState();
}

class _TabStoreState extends State<TabStore> {
  List<CartProduct> cartProduct = <CartProduct>[];
  var resultData;
  List<ProductCart> productCart = <ProductCart>[];
  var resultData2;
  var resultTotal;

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
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8),
                      child: GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final String? userId = prefs.getString('username');
                          var url = "https://mtwa.xyz/API/list-cart";
                          var data = {'userId': '${userId}'};
                          await http
                              .post(Uri.parse(url), body: data)
                              .then((value) {
                            var result = jsonDecode(value.body);
                            cartProduct = <CartProduct>[];
                            resultData = result['seller'];
                            productCart = <ProductCart>[];
                            resultData2 = result['product'];
                            resultTotal = result['total'];

                            print(resultData);
                            for (var i = 0; i < resultData.length; i++) {
                              CartProduct t =
                                  CartProduct.fromJson(resultData[i]);
                              cartProduct.add(t);
                            }
                            for (var j = 0; j < resultData2.length; j++) {
                              ProductCart k =
                                  ProductCart.fromJson(resultData2[j]);
                              productCart.add(k);
                            }
                          });
                          print('object');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoreScreen(
                                  cart: cartProduct,
                                  product: productCart,
                                  total: '${resultTotal}'),
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
                                  'รอการชำระเงิน',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red[700],
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
}
