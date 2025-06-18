//flutter packages
import 'package:flutter/material.dart';

class COLOR {
  static final Color background = Colors.white;
  static final Color appBaseColor = Color(0xff900C3F);
  static final Color pink = Color(0xff9e2089);

  static final Color pinkLight = Colors.red.shade50;
  static final Color pink400 = Colors.red.shade400;
  static final Color grey = Colors.grey;
  static final Color searchgrey = Color.fromARGB(255, 206, 206, 206);
  static final Color greyLight = Color.fromRGBO(238, 238, 238, 1);
  static final Color greyback = Color(0xFF616161);
  static final Color black = Colors.black87;
  static final Color purple = Colors.purple;
  static final Color purpleLight = Colors.purple.shade100;
  static final Color lightOrange = Colors.orange.shade100;
  static final Color deepOrange = Colors.deepOrange;
  static final Color indigo = Colors.indigo;
  static final Color green = Colors.green;
  static final Color green50 = Colors.green.shade50;
  static final Color yellow100 = Colors.yellow.shade100;
  static final Color amber = Colors.amber.shade100;
  static final Color transparent = Colors.transparent;
}


Map<int, Color> appprimarycolors = {
  50: Color.fromRGBO(238, 193, 76, .1),
  100: Color.fromRGBO(238, 193, 76, .2),
  200: Color.fromRGBO(238, 193, 76, .3),
  300: Color.fromRGBO(238, 193, 76, .4),
  400: Color.fromRGBO(238, 193, 76, .5),
  500: Color.fromRGBO(238, 193, 76, .6),
  600: Color.fromRGBO(238, 193, 76, 0.7),
  700: Color.fromRGBO(238, 193, 76, .8),
  800: Color.fromRGBO(238, 193, 76, .9),
  900: Color.fromRGBO(238, 193, 76, 1)
};

// MaterialColor(0xFFd98e8e, appprimarycolors)
MaterialColor appPrimaryMaterialColor2 =
MaterialColor(0xFFEEC14C, appprimarycolors);

MaterialColor appPrimaryMaterialColorcard =
MaterialColor(0xFFEEC14C, appprimarycolors);

MaterialColor appPrimaryMaterialColorcardfont =
MaterialColor(0xFFFFFFFF, appprimarycolors);

MaterialColor appPrimaryMaterialColoreventcard =
MaterialColor(0xFFEEC14C, appprimarycolors);

MaterialColor appPrimaryMaterialColoreventcardfont =
MaterialColor(0xFFFFFFFF, appprimarycolors);
