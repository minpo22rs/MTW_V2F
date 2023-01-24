import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mtw_project/models/cart_product_model.dart';
import 'package:mtw_project/models/cart_seller_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/list_screen.dart';
import 'package:mtw_project/views/screens/store/store_screen.dart';
import 'package:mtw_project/views/screens/tabbarview/producttabview/tab_store.dart';
import 'package:mtw_project/views/screens/tabbarview/tab_product.dart';

class LoadingCartScreen extends StatefulWidget {
  final String productKey, pageKey;
  const LoadingCartScreen(
      {Key? key, required this.productKey, required this.pageKey})
      : super(key: key);
  @override
  _LoadingCartScreenState createState() =>
      _LoadingCartScreenState(productKey, pageKey);
}

class _LoadingCartScreenState extends State<LoadingCartScreen> {
  late String productKey, pageKey;
  _LoadingCartScreenState(this.productKey, this.pageKey);
  @override
  void initState() {
    super.initState();
    if (pageKey == 'cart') {
      cart();
    } else if (pageKey == 'main') {
      _navigateToHome();
    }
  }

  List<CartProduct> cartProduct = <CartProduct>[];
  var resultData;
  List<ProductCart> productCart = <ProductCart>[];
  var resultData2;
  var resultTotal;

  Future<Null> cart() async {
    var url = "https://mtwa.xyz/API/list-cart";
    await http.get(Uri.parse(url)).then((value) {
      var result = jsonDecode(value.body);
      cartProduct = <CartProduct>[];
      resultData = result['seller'];
      productCart = <ProductCart>[];
      resultData2 = result['product'];
      resultTotal = result['total'];

      print(resultData);
      for (var i = 0; i < resultData.length; i++) {
        CartProduct t = CartProduct.fromJson(resultData[i]);
        cartProduct.add(t);
      }
      for (var j = 0; j < resultData2.length; j++) {
        ProductCart k = ProductCart.fromJson(resultData2[j]);
        productCart.add(k);
      }
    });

    _navigateToHome();
  }

  void _navigateToHome() async {
    if (pageKey == 'main') {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => ListScreen()));
    } else if (pageKey == 'cart') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => StoreScreen(
                cart: cartProduct,
                product: productCart,
                total: resultTotal,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Colors.black),
          ),
          new Container(
            child: Image.asset('assets/images/bg2.jpg', fit: BoxFit.cover),
          ),
          Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          ColorResources.KTextPink),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      '   loading....',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
