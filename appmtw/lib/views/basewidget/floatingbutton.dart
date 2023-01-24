import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:mtw_project/views/screens/products/buy_product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FancyFab extends StatefulWidget {
  final String pro_id, qty, seller;
  const FancyFab(
      {Key? key, required this.pro_id, required this.qty, required this.seller})
      : super(key: key);
  @override
  _FancyFabState createState() => _FancyFabState(pro_id, qty, seller);
}

class _FancyFabState extends State<FancyFab>
    with SingleTickerProviderStateMixin {
  late String pro_id, qty, seller;
  _FancyFabState(this.pro_id, this.qty, this.seller);
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget buy() {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          print('สั่งซื้อสินค้า');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString('username');
          var url = "https://mtwa.xyz/API/add-cart";
          var data = {
            'userid': '${userId}',
            'pro_id': pro_id,
            'qty': qty,
            'seller': seller
          };
          await http.post(Uri.parse(url), body: data).then((value) {
            var result = jsonDecode(value.body);
            if (result['status_cart'] == 'S') {
              Fluttertoast.showToast(
                  msg: "เพิ่มสินค้าในตะกร้าเรียบร้อยค่ะ",
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT);
            } else if (result['status_cart'] == 'F') {
              Fluttertoast.showToast(
                  msg: "พบปัญหากรุณาติดต่อผู้ดูแล",
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT);
            }
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BuyProduct()));
        },
        tooltip: 'Buy',
        child: Icon(Icons.shopping_cart_outlined),
      ),
    );
  }

  // Widget image() {
  //   return Container(
  //     child: FloatingActionButton(
  //       onPressed: null,
  //       tooltip: 'Image',
  //       child: Icon(Icons.image),
  //     ),
  //   );
  // }

  Widget addCart() {
    return Container(
      child: FloatingActionButton(
        onPressed: () async {
          print('เพิ่มสินค้าลงในตะกร้า');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final String? userId = prefs.getString('username');
          var url = "https://mtwa.xyz/API/add-cart";
          var data = {
            'userid': '${userId}',
            'pro_id': pro_id,
            'qty': qty,
            'seller': seller
          };
          print(data);
          await http.post(Uri.parse(url), body: data).then((value) {
            var result = jsonDecode(value.body);
            if (result['status_cart'] == 'S') {
              Fluttertoast.showToast(
                  msg: "เพิ่มสินค้าในตะกร้าเรียบร้อยค่ะ",
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT);
            } else if (result['status_cart'] == 'F') {
              Fluttertoast.showToast(
                  msg: "พบปัญหากรุณาติดต่อผู้ดูแล" + result['catch'],
                  gravity: ToastGravity.CENTER,
                  toastLength: Toast.LENGTH_SHORT);
            }
          });
        },
        tooltip: 'AddCart',
        child: Icon(Icons.shopping_basket_outlined),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: buy(),
        ),
        // Transform(
        //   transform: Matrix4.translationValues(
        //     0.0,
        //     _translateButton.value * 2.0,
        //     0.0,
        //   ),
        //   child: image(),
        // ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: addCart(),
        ),
        toggle(),
      ],
    );
  }
}
