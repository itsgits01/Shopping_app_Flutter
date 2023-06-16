import 'package:first_app/Screens/cart_page.dart';
import 'package:first_app/Screens/homepage.dart';
import 'package:first_app/Widgets/themes.dart';
import 'package:first_app/core/store.dart';
import 'package:first_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

import 'Screens/login_page.dart';

void main() {
  runApp(VxState(store: MyStore(),
  child: Myapp()));
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Homepage(),2
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,

      theme: Mytheme.lightTheme(context),
      initialRoute: MyRoutes.loginroute,
      routes: {
        "/": (context)=>LoginPage(),
        MyRoutes.homeRoute:(context)=> Homepage(),
        MyRoutes.loginroute: (context)=> LoginPage(),
        MyRoutes.cartRoute: (context)=> cartPage()
      },

      // darkTheme: ThemeData(
      //   brightness: Brightness.dark
      // ),
    );
  }
}

