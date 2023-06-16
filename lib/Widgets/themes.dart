import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Mytheme{
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.lightBlue,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6,
      )
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.lightBlue,
      cardColor: Colors.black,
      canvasColor: darkCreamColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), toolbarTextStyle: Theme.of(context).textTheme.bodyText2, titleTextStyle: Theme.of(context).textTheme.headline6,
      )
  );
  //colors
static Color creamColor=Color(0xfff5f5f);
static Color darkblue=Color(0xff9e94ce);
static Color darkCreamColor=Vx.gray800;
static Color lightBluishColor=Vx.purple400;


}