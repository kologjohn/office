import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Global {
  static const Color backgroundColor = Color.fromRGBO(24, 24, 32, 1);
  static const Color gradient1 = Color.fromRGBO(187, 67, 221, 1);
  static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
  static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
  static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
  static const Color whiteColor = Colors.white;
  static const Color txtcolor = Colors.black;
  static  Color? ksoft = Colors.grey[100];


  static const Color primaryColor = Color(0xFF2697FF);
  static const Color secondaryColor = Color(0xFF2A2D3E);
  static const Color bgColor = Color(0xFF212332);

  static const Color newbg = Colors.orange;
  static const Color bgs = Colors.black12;

  static const defaultPadding = 16.0;
  static final  nomalfont = GoogleFonts.k2d(fontSize: 12);
  static final  heading = GoogleFonts.k2d(fontSize: 14);

}

class Convert{

  static double truncateToDecimalPlaces(num value, int fractionalDigits)
  {
    double converted=0;
    if(value>0)
    {
      converted=(value * pow(10,fractionalDigits)).truncate() / pow(10, fractionalDigits);

    }

    return converted;

  }
}
