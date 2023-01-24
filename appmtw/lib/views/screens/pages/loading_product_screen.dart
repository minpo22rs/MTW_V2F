import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mtw_project/models/category_product_model.dart';
import 'package:mtw_project/models/product_img_model.dart';
import 'package:mtw_project/models/product_reccomment_model.dart';
import 'package:mtw_project/models/similar_product_model.dart';
import 'package:mtw_project/models/top_up_model.dart';
import 'package:mtw_project/utill/color.resouces.dart';
import 'package:mtw_project/views/screens/pages/account_screen.dart';
import 'package:mtw_project/views/screens/products/product_2_screen.dart';
import 'package:mtw_project/views/screens/products/product_detail_screen.dart';
import 'package:mtw_project/views/screens/products/product_screen.dart';
import 'package:mtw_project/views/screens/wallet/wallet_main.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LoadingProScreen extends StatefulWidget {
  final String productKey, pageKey;
  const LoadingProScreen(
      {Key? key, required this.productKey, required this.pageKey})
      : super(key: key);
  @override
  _LoadingProScreenState createState() =>
      _LoadingProScreenState(productKey, pageKey);
}

class _LoadingProScreenState extends State<LoadingProScreen> {
  late String productKey, pageKey;
  _LoadingProScreenState(this.productKey, this.pageKey);
  @override
  void initState() {
    super.initState();
    if (pageKey == 'detail') {
      proDetail();
    } else if (pageKey == 'screen' || pageKey == 'all') {
      productpage();
    } else {
      productcate();
    }

    _mockcheckforSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  var id;
  var pname;
  var pdetail;
  var image;
  var unitprice;
  var saleprice;
  var stock;
  var seller;
  var address;
  var simage;
  var rating;
  var seller_id;
  List<SimilarProduct> similar = <SimilarProduct>[];
  var resultData;
  List<Proimg> proimg = <Proimg>[];
  var resultData2;

  Future<Null> proDetail() async {
    var url = "http://10.0.2.2/flutter/api_php/ApiController.php";
    var data = {'pro_id': '${productKey}'};
    print(data);
    await http.post(Uri.parse(url), body: data).then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        resultData = result['similar'];
        similar = <SimilarProduct>[];
        for (var i = 0; i < resultData.length; i++) {
          SimilarProduct t = SimilarProduct.fromJson(resultData[i]);
          similar.add(t);
        }
        resultData2 = result['productimg'];
        proimg = <Proimg>[];
        for (var i = 0; i < resultData2.length; i++) {
          Proimg t = Proimg.fromJson(resultData2[i]);
          proimg.add(t);
        }
        print(result);
        id = result['productd']['id'];
        pname = result['productd']['name'];
        saleprice = result['productd']['purchase_price'];
        unitprice = result['productd']['unit_price'];
        image = result['productd']['thumbnail'];
        pdetail = result['productd']['details'];
        stock = result['productd']['current_stock'];
        seller = result['seller']['shopname'];
        address = result['seller']['address'];
        simage = result['seller']['image'];
        rating = result['seller']['rating'];
        seller_id = result['seller']['id'];
      }
    });
  }

  List<CategoryProduct> cate = <CategoryProduct>[];
  var resultDatacate;

  List<ProductRec> products = <ProductRec>[];
  var resultProduct;

  late String bannersub, bannerfooter;

  Future<Null> productpage() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final String? userId = prefs.getString('username');

    var url = "http://10.0.2.2/flutter/api_php/product_page.php";
    await http.get(Uri.parse(url)).then((response) async {
      print('this response = ${response.body}');
      var result1 = jsonDecode(response.body);
      resultData = result1['bannermain'];
      bannersub = result1['banners']['photo'];
      bannerfooter = result1['bannerf']['photo'];
      resultProduct = result1['product'];
      products = <ProductRec>[];
      resultDatacate = result1['cate_p'];
      cate = <CategoryProduct>[];

      for (var j = 0; j < resultProduct.length; j++) {
        ProductRec d = ProductRec.fromJson(resultProduct[j]);
        products.add(d);
      }
      for (var i = 0; i < resultDatacate.length; i++) {
        CategoryProduct t = CategoryProduct.fromJson(resultDatacate[i]);
        cate.add(t);
      }
    });
  }

  Future<Null> productcate() async {
    var url = "http://10.0.2.2/flutter/api_php/ApiController.php";
    var data = {'cate_id': '${productKey}'};
    print(productKey);
    await http.post(Uri.parse(url), body: data).then((response) async {
      var result1 = jsonDecode(response.body);
      resultProduct = result1;
      products = <ProductRec>[];
      for (var j = 0; j < resultProduct.length; j++) {
        ProductRec d = ProductRec.fromJson(resultProduct[j]);
        products.add(d);
      }
    });
  }

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});

    return true;
  }

  void _navigateToHome() async {
    if (pageKey == 'detail') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ProductDetailScreen(
                id: '${id}',
                p_name: '${pname}',
                p_detail: '${pdetail}',
                image: '${image}',
                unit_price: '${unitprice}',
                sale_price: '${saleprice}',
                stock: '${stock}',
                seller: '${seller}',
                address: '${address}',
                simage: '${simage}',
                rating: '${rating}',
                seller_id: '${seller_id}',
                images: proimg,
                similar: similar,
              )));
    } else if (pageKey == 'screen') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ProductScreen(
              categoryProduct: cate,
              products: products,
              bannersub: '${bannersub}',
              bannerfooter: '${bannerfooter}')));
    } else if (pageKey == 'all') {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ProductScreen2(
                products: products,
                title: '',
              )));
    } else {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ProductScreen2(
                products: products,
                title: pageKey,
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
