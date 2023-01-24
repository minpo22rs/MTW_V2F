// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mtw_project/models/attraction_model.dart';
// import 'package:mtw_project/models/banner_main.dart';
// import 'package:mtw_project/models/category_product_model.dart';
// import 'package:mtw_project/models/hotel_model.dart';
// import 'package:mtw_project/models/product_reccomment_model.dart';
// import 'package:mtw_project/models/rating_line_one.dart';
// import 'package:mtw_project/models/rating_line_two.dart';
// import 'package:mtw_project/models/rating_one_model.dart';
// import 'package:mtw_project/models/rating_two_model.dart';
// import 'package:mtw_project/models/restaurant_model.dart';
// import 'package:mtw_project/utill/dimensions.dart';
// import 'package:mtw_project/utill/images.dart';
// import 'package:mtw_project/views/basewidget/custom_bottomnavigator.dart';
// import 'package:mtw_project/views/screens/auth/register_screen.dart';
// import 'package:mtw_project/views/screens/dashboard/dashboard_screen.dart';
// import 'package:mtw_project/views/screens/pages/home_scrren.dart';
// import 'package:sizer/sizer.dart';

// class LoginScreen extends StatefulWidget {
//   final List mainbanner,
//       onecon,
//       twocon,
//       onelinecon,
//       twolinecon,
//       restaurants,
//       products,
//       categoryProduct,
//       categoryrestaurants,
//       hotels,
//       attractions;
//   final String bannersub, bannerfooter;
//   const LoginScreen({
//     Key? key,
//     required this.mainbanner,
//     required this.onecon,
//     required this.twocon,
//     required this.onelinecon,
//     required this.twolinecon,
//     required this.bannersub,
//     required this.bannerfooter,
//     required this.restaurants,
//     required this.products,
//     required this.categoryProduct,
//     required this.categoryrestaurants,
//     required this.hotels,
//     required this.attractions,
//   }) : super(key: key);

//   @override
//   _LoginScreenState createState() => _LoginScreenState(
//         mainbanner,
//         onecon,
//         twocon,
//         onelinecon,
//         twolinecon,
//         bannersub,
//         bannerfooter,
//         restaurants,
//         products,
//         categoryProduct,
//         categoryrestaurants,
//         hotels,
//         attractions,
//       );
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final phonectrl = TextEditingController();
//   final passwordctrl = TextEditingController();
//   late List mainbanner,
//       onecon,
//       twocon,
//       onelinecon,
//       twolinecon,
//       restaurants,
//       products,
//       categoryProduct,
//       categoryrestaurants,
//       hotels,
//       attractions;
//   late String bannersub, bannerfooter;
//   _LoginScreenState(
//       this.mainbanner,
//       this.onecon,
//       this.twocon,
//       this.onelinecon,
//       this.twolinecon,
//       this.bannersub,
//       this.bannerfooter,
//       this.restaurants,
//       this.products,
//       this.categoryProduct,
//       this.categoryrestaurants,
//       this.hotels,
//       this.attractions);
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(Images.background),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(
//               bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: Dimensions.PADDING_SIZE_DEFAULT,
//                   ),
//                   child: Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 25.sp,
//                       color: kTextcolor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.sp,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: Dimensions.PADDING_SIZE_LARGE,
//                   ),
//                   child: Text(
//                     "Phone Number",
//                     style: TextStyle(
//                       fontSize: Dimensions.FONT_SIZE_DEFAULT,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: Dimensions.PADDING_SIZE_LARGE,
//                       right: Dimensions.PADDING_SIZE_EXTRA_LARGE),
//                   child: Container(
//                     height: 30.sp,
//                     child: TextField(
//                       style: TextStyle(
//                           fontSize: 13.0, height: 0.9, color: Colors.black),
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(10),
//                       ],
//                       controller: phonectrl,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15.sp,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: Dimensions.PADDING_SIZE_LARGE,
//                   ),
//                   child: Text(
//                     "Password",
//                     style: TextStyle(
//                       fontSize: Dimensions.FONT_SIZE_DEFAULT,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: Dimensions.PADDING_SIZE_LARGE,
//                       right: Dimensions.PADDING_SIZE_EXTRA_LARGE),
//                   child: Container(
//                     height: 30.sp,
//                     child: TextField(
//                       style: TextStyle(
//                           fontSize: 13.0, height: 0.9, color: Colors.black),
//                       // inputFormatters: [
//                       //   LengthLimitingTextInputFormatter(10),
//                       // ],
//                       controller: passwordctrl,
//                       decoration: InputDecoration(
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                           borderSide: BorderSide(
//                             color: Colors.blueAccent,
//                             width: 1.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 40, bottom: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () {},
//                         child: Text("Forgot Password?"),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 7.sp,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                       left: Dimensions.PADDING_SIZE_LARGE),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 5,
//                                 blurRadius: 10,
//                               ),
//                             ]),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(10),
//                                 topRight: Radius.circular(10),
//                                 bottomLeft: Radius.circular(10),
//                                 bottomRight: Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.1),
//                                 spreadRadius: 5,
//                                 blurRadius: 10,
//                               ),
//                             ]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: Dimensions.PADDING_SIZE_LARGE,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             ('New Here? '),
//                             style: TextStyle(
//                               fontSize: 10.sp,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w200,
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               print('goto HomeScreen');
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (ctx) => RegisterScreen(
//                                       mainbanner: mainbanner,
//                                       onecon: onecon,
//                                       twocon: twocon,
//                                       onelinecon: onelinecon,
//                                       twolinecon: twolinecon,
//                                       bannersub: bannersub,
//                                       bannerfooter: bannerfooter,
//                                       restaurants: restaurants,
//                                       categoryProduct: categoryProduct,
//                                       categoryrestaurants: categoryrestaurants,
//                                       products: products,
//                                       hotels: hotels,
//                                       attractions: attractions),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               ("Register"),
//                               style: TextStyle(
//                                 fontSize: 10.sp,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             right: Dimensions.PADDING_SIZE_DEFAULT),
//                         child: Container(
//                           decoration: BoxDecoration(
//                               border: Border.all(color: Colors.white),
//                               borderRadius: BorderRadius.circular(10)),
//                           width: 90.sp,
//                           height: 40.sp,
//                           child: OutlinedButton(
//                             onPressed: () async {
//                               var url =
//                                   "https://mtwa.xyz/API/login-mobile-mtwa";
//                               var data = {
//                                 'phone': phonectrl.text,
//                                 'password': passwordctrl.text
//                               };
//                               await http
//                                   .post(Uri.parse(url), body: data)
//                                   .then((response) {
//                                 print(phonectrl.text);
//                                 var result = jsonDecode(response.body);
//                                 if (response.statusCode == 200) {
//                                   if (result['statuslogin'] == '1') {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (ctx) => CustomBottomNavigator(
//                                             mainbanner: mainbanner,
//                                             onecon: onecon,
//                                             twocon: twocon,
//                                             onelinecon: onelinecon,
//                                             twolinecon: twolinecon,
//                                             bannersub: bannersub,
//                                             bannerfooter: bannerfooter,
//                                             restaurants: restaurants,
//                                             categoryProduct: categoryProduct,
//                                             categoryrestaurants:
//                                                 categoryrestaurants,
//                                             products: products,
//                                             hotels: hotels,
//                                             attractions: attractions),
//                                       ),
//                                     );
//                                   } else {
//                                     Fluttertoast.showToast(
//                                         msg: "password is incorrect",
//                                         toastLength: Toast.LENGTH_SHORT);
//                                   }
//                                 } else {
//                                   Fluttertoast.showToast(
//                                       msg: "error 50x contact Adminstator",
//                                       toastLength: Toast.LENGTH_SHORT);
//                                 }
//                               });
//                             },
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
