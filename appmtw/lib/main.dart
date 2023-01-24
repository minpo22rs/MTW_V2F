import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mtw_project/views/basewidget/custom_bottomnavigator.dart';
import 'package:mtw_project/views/screens/auth/login_screen.dart';
import 'package:mtw_project/views/screens/auth/new_login_screen.dart';
import 'package:mtw_project/views/screens/auth/register_screen.dart';
import 'package:mtw_project/views/screens/auth/welcome_screen.dart';
import 'package:mtw_project/views/screens/dashboard/dashboard_screen.dart';
import 'package:mtw_project/views/screens/products/product_2_screen.dart';
import 'package:mtw_project/views/screens/products/product_screen.dart';
import 'package:mtw_project/views/screens/splashscreen/splashscreen.dart';
import 'package:mtw_project/views/screens/vote/vote_central_screen.dart';
import 'package:mtw_project/views/screens/wallet/wallet_one_screen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(Phoenix(
    child: MyApp(),
  ));
}

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'mtw',
        theme: ThemeData(
            textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        )),
        home: SafeArea(child: (SplashScreen())),
      );
    });
  }
}
