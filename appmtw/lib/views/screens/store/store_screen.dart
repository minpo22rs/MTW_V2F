import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mtw_project/models/cart_product_model.dart';
import 'package:mtw_project/models/cart_seller_model.dart';
import 'package:mtw_project/models/check_cart.dart';
import 'package:mtw_project/models/product_store_model.dart';
import 'package:mtw_project/models/slidable_action.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/utill/images.dart';
import 'package:mtw_project/views/screens/pages/list_screen.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class StoreScreen extends StatefulWidget {
  final List cart, product;
  final String total;
  const StoreScreen(
      {Key? key,
      required this.cart,
      required this.product,
      required this.total})
      : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState(cart, product, total);
}

class _StoreScreenState extends State<StoreScreen> {
  late List cart, product;
  late String total;
  _StoreScreenState(this.cart, this.product, this.total);
  bool allvalue = false;
  bool value = false;
  int counter = 1;
  bool valueswitch = true;
  List count = [];
  List items = [];
  int qty = 0;
  int checkId = 0;
  bool _statuscart = false;
  bool _statusseller = false;
  List<CheckCart> checkCart = <CheckCart>[];

  void counterlenght() {
    // int i = 1;
    for (var i = 1; i <= productStore.length; i++) {
      count.add(i);

      // bool
    }
    print(count);
  }

  List<CartProduct> cartProduct = <CartProduct>[];
  var resultData;
  List<ProductCart> productCart = <ProductCart>[];
  var resultData2;
  var resultTotal, seller;

  @override
  void initState() {
    counterlenght();
    _statuscart = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<int> text = [1, 2];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return ListScreen();
            }), (route) => false);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ตะกร้าสินค้า',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    splashRadius: 0,
                                    value: cart[index].check,
                                    onChanged: (value) {
                                      setState(() {
                                        cart[index].check = value!;
                                        if (value == true) {
                                          for (int k = 0;
                                              k < product.length;
                                              k++) {
                                            if (cart[index].id ==
                                                product[k].seller) {
                                              checkCart.add(new CheckCart(
                                                  cart_id: product[k].cartId,
                                                  seller_id: product[k].seller,
                                                  status: true));
                                            }
                                            print(checkCart);
                                          }
                                        } else {
                                          for (int k = 0;
                                              k < product.length;
                                              k++) {
                                            checkCart.removeWhere((item) =>
                                                item.cart_id ==
                                                product[k].cartId);
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  Icon(Icons.storefront_rounded),
                                  Text(cart[index].nameseller),
                                  Icon(Icons.arrow_forward_ios_rounded),
                                ],
                              ),
                              Text(
                                'แก้ไข',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                        Column(
                          children: List.generate(product.length, (index2) {
                            final item = product[index2];
                            if (_statuscart == false) {
                              qty = product[index2].qty;
                            } else {
                              qty = productCart[index2].qty;
                            }
                            // return Text(text[index2].toString());
                            return (product[index2].seller == cart[index].id)
                                ? Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.15,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12),
                                          child: Row(
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              if (cart[index].check ==
                                                  false) ...[
                                                Checkbox(
                                                  splashRadius: 0,
                                                  value: product[index2].check,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      product[index2].check =
                                                          value!;
                                                      if (value == true) {
                                                        checkCart.add(new CheckCart(
                                                            cart_id:
                                                                product[index2]
                                                                    .cartId,
                                                            seller_id:
                                                                product[index2]
                                                                    .seller,
                                                            status: value));
                                                      } else if (value ==
                                                          false) {
                                                        checkCart.removeWhere(
                                                            (item) =>
                                                                item.cart_id ==
                                                                product[index2]
                                                                    .cartId);
                                                      }
                                                      // allvalue = value;
                                                      print(checkCart);
                                                    });
                                                  },
                                                ),
                                              ] else ...[
                                                Checkbox(
                                                    value: cart[index].check,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        value = value!;
                                                      });
                                                    })
                                              ],
                                              Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          'https://mtwa.xyz/storage/app/public/product/thumbnail/' +
                                                              product[index2]
                                                                  .image),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    color: Colors.redAccent
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    product[index2].name,
                                                    style: TextStyle(
                                                        fontSize: 10.5),
                                                  ),
                                                  // DropdownButton(items: items),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '฿',
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          color: ColorResources
                                                              .KTextGray,
                                                        ),
                                                      ),
                                                      Text(
                                                        NumberFormat('#,###.##')
                                                            .format(
                                                                product[index2]
                                                                    .price)
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 9.5.sp,
                                                          color: ColorResources
                                                              .KTextGray,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        '฿',
                                                        style: TextStyle(
                                                          fontSize: 8.sp,
                                                          color: ColorResources
                                                              .BG_Blue,
                                                        ),
                                                      ),
                                                      Text(
                                                        NumberFormat('#,###.##')
                                                            .format(
                                                                product[index2]
                                                                    .saleprice)
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          color: ColorResources
                                                              .BG_Blue,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          if (qty > 1) {
                                                            var url =
                                                                "https://mtwa.xyz/API/qty-cart";
                                                            var data = {
                                                              'type': 'minus',
                                                              'cartId':
                                                                  '${product[index2].cartId}'
                                                            };
                                                            await http
                                                                .post(
                                                                    Uri.parse(
                                                                        url),
                                                                    body: data)
                                                                .then(
                                                                    (value) async {
                                                              var res =
                                                                  jsonDecode(
                                                                      value
                                                                          .body);
                                                              print(res);
                                                              if (res['type'] ==
                                                                  'minus') {
                                                                final SharedPreferences
                                                                    prefs =
                                                                    await SharedPreferences
                                                                        .getInstance();
                                                                final String?
                                                                    userId =
                                                                    prefs.getString(
                                                                        'username');
                                                                var url =
                                                                    "https://mtwa.xyz/API/list-cart";
                                                                var data = {
                                                                  'userId':
                                                                      '${userId}'
                                                                };
                                                                await http
                                                                    .post(
                                                                        Uri.parse(
                                                                            url),
                                                                        body:
                                                                            data)
                                                                    .then(
                                                                        (value) {
                                                                  var result =
                                                                      jsonDecode(
                                                                          value
                                                                              .body);
                                                                  cartProduct =
                                                                      <CartProduct>[];
                                                                  resultData =
                                                                      result[
                                                                          'seller'];
                                                                  productCart =
                                                                      <ProductCart>[];
                                                                  resultData2 =
                                                                      result[
                                                                          'product'];
                                                                  resultTotal =
                                                                      result[
                                                                          'total'];

                                                                  print(
                                                                      resultData);
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          resultData
                                                                              .length;
                                                                      i++) {
                                                                    CartProduct
                                                                        t =
                                                                        CartProduct.fromJson(
                                                                            resultData[i]);
                                                                    cartProduct
                                                                        .add(t);
                                                                  }
                                                                  for (var j =
                                                                          0;
                                                                      j <
                                                                          resultData2
                                                                              .length;
                                                                      j++) {
                                                                    ProductCart
                                                                        k =
                                                                        ProductCart.fromJson(
                                                                            resultData2[j]);
                                                                    productCart
                                                                        .add(k);
                                                                  }
                                                                });
                                                                setState(() {
                                                                  _statuscart =
                                                                      true;
                                                                });
                                                              }
                                                            });
                                                          } else if (qty < 2) {
                                                            return;
                                                          }
                                                        },
                                                        child: Icon(Icons
                                                            .remove_circle_outline_rounded),
                                                      ),
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      if (_statuscart ==
                                                          false) ...[
                                                        Text(
                                                            '${product[index2].qty}'),
                                                      ] else if (_statuscart ==
                                                          true) ...[
                                                        Text(
                                                            '${productCart[index2].qty}'),
                                                      ],
                                                      SizedBox(
                                                        width: 16,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          print('add');
                                                          print(qty);
                                                          var url =
                                                              "https://mtwa.xyz/API/qty-cart";
                                                          var data = {
                                                            'type': 'plus',
                                                            'cartId':
                                                                '${product[index2].cartId}'
                                                          };
                                                          await http
                                                              .post(
                                                                  Uri.parse(
                                                                      url),
                                                                  body: data)
                                                              .then(
                                                                  (value) async {
                                                            var res =
                                                                jsonDecode(
                                                                    value.body);
                                                            print(res);
                                                            if (res['type'] ==
                                                                'plus') {
                                                              final SharedPreferences
                                                                  prefs =
                                                                  await SharedPreferences
                                                                      .getInstance();
                                                              final String?
                                                                  userId =
                                                                  prefs.getString(
                                                                      'username');
                                                              var url =
                                                                  "https://mtwa.xyz/API/list-cart";
                                                              var data = {
                                                                'userId':
                                                                    '${userId}'
                                                              };
                                                              await http
                                                                  .post(
                                                                      Uri.parse(
                                                                          url),
                                                                      body:
                                                                          data)
                                                                  .then(
                                                                      (value) {
                                                                var result =
                                                                    jsonDecode(
                                                                        value
                                                                            .body);
                                                                cartProduct = <
                                                                    CartProduct>[];
                                                                resultData =
                                                                    result[
                                                                        'seller'];
                                                                productCart = <
                                                                    ProductCart>[];
                                                                resultData2 =
                                                                    result[
                                                                        'product'];
                                                                resultTotal =
                                                                    result[
                                                                        'total'];

                                                                for (var i = 0;
                                                                    i <
                                                                        resultData
                                                                            .length;
                                                                    i++) {
                                                                  CartProduct
                                                                      t =
                                                                      CartProduct
                                                                          .fromJson(
                                                                              resultData[i]);
                                                                  cartProduct
                                                                      .add(t);
                                                                }
                                                                for (var j = 0;
                                                                    j <
                                                                        resultData2
                                                                            .length;
                                                                    j++) {
                                                                  ProductCart
                                                                      k =
                                                                      ProductCart
                                                                          .fromJson(
                                                                              resultData2[j]);
                                                                  productCart
                                                                      .add(k);
                                                                }
                                                              });
                                                              setState(() {
                                                                _statuscart =
                                                                    true;

                                                                print('object');
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Icon(Icons
                                                            .add_circle_outline_rounded),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    secondaryActions: [
                                      IconSlideAction(
                                        caption: 'ลบ',
                                        icon: Icons.delete_rounded,
                                        color: Colors.red,
                                        onTap: () {
                                          onDismissed(
                                              index2, SlidableAction.delete);
                                        },
                                      ),
                                    ],
                                  )
                                : Slidable(
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.15,
                                    child: Column(),
                                  );
                          }),
                        )
                      ],
                    );
                  })),
          Expanded(
            flex: 0,
            child: (_statuscart)
                ? Displaybottom(checkCart: checkCart, total: '${resultTotal}'
                    // total: total,
                    )
                : Displaybottom(checkCart: checkCart, total: total
                    // total: total,
                    ),
          )
        ],
      ),
      // bottomNavigationBar: Stack(children: [(Displaybottom())]),
    );
  }

  // Widget displaybottom() {
  //   return
  // }

  void onDismissed(int index, SlidableAction action) {
    setState(() {
      productStore.removeAt(index);
    });
  }
}

class Displaybottom extends StatefulWidget {
  final List checkCart;
  final String total;
  const Displaybottom({Key? key, required this.checkCart, required this.total})
      : super(key: key);

  @override
  _DisplaybottomState createState() => _DisplaybottomState(checkCart, total);
}

class _DisplaybottomState extends State<Displaybottom> {
  late List checkCart;
  late String total;
  _DisplaybottomState(this.checkCart, this.total);
  bool value1 = false;
  bool valueswitch = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.card_giftcard_rounded),
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
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.monetization_on_outlined),
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
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  splashRadius: 0,
                  value: this.value1,
                  onChanged: (value3) {
                    setState(() {
                      // this.allvalue = value!;
                      this.value1 = value3!;
                    });
                  },
                ),
                Text('ทั้งหมด'),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('ราคาทั้งหมด ฿ ' + total),
                    Text('ได้รับ 0 คะแนน'),
                  ],
                ),
                SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (checkCart.isNotEmpty) {
                      // print(checkCart);
                      List cartId = [];
                      for (var n = 0; n < checkCart.length; n++) {
                        cartId.add(checkCart[n].cart_id);
                      }
                      List sellerId = [];
                      for (var j = 0; j < checkCart.length; j++) {
                        sellerId.add(checkCart[j].seller_id);
                      }
                      print('${cartId}');
                      print('yes');
                      var url = "https://mtwa.xyz/API/search-cart";
                      var dataarray = {
                        'cartId': '${cartId}',
                        'sellerId': '${sellerId}',
                      };
                      http.post(Uri.parse(url), body: dataarray).then((value) {
                        var result = jsonDecode(value.body);
                        print(result);
                      });
                    } else {
                      print('no');
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.cyan),
                  child: Text(
                    'ชำระเงิน',
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
