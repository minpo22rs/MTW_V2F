import 'package:flutter/material.dart';
import 'package:mtw_project/views/basewidget/button/custom_button.dart';
import 'package:mtw_project/views/basewidget/custom_bottomnavigator.dart';
import 'package:mtw_project/views/screens/account/foseller/scanner_screen.dart';
import 'package:mtw_project/views/screens/account/foseller/seller_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/pages/loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    autoLogin();
    _mockcheckforSession().then((status) {
      if (status) {
        _navigateToHome();
      } else {
        _navigateToHome();
      }
    });
  }

  var roleUser;
  late String accountId;
  bool isLoggedIn = false;
  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');
    final String? role = prefs.getString('role');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        accountId = userId;
        roleUser = role;
      });
      return;
    }
  }

  Future<bool> _mockcheckforSession() async {
    await Future.delayed(Duration(milliseconds: 3500), () {});

    return true;
  }

  void _navigateToHome() async {
    if (isLoggedIn == false) {
      await Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NewLoginScreen()));
    } else if (isLoggedIn == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userId = prefs.getString('username');
      if (roleUser == 'U') {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => CustomBottomNavigator(
              userid: '${userId}',
            ),
          ),
        );
      } else if (roleUser == 'S') {
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => SellerScreen(
              userId: '${userId}',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          new Container(
            child: Image.asset('assets/images/bg2.jpg', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
