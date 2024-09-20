import 'package:ecomoffice/screens/Categorylist.dart';
import 'package:ecomoffice/screens/dashboard.dart';
import 'package:ecomoffice/screens/mainmeu.dart';
import 'package:ecomoffice/screens/settings.dart';
import 'package:ecomoffice/screens/home.dart';
import 'package:ecomoffice/screens/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dataase/FireaseData.dart';
import 'dataase/routes.dart';
import 'firebase_options.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'global.dart';
void main() async{
  String mainpage=Routes.login;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if(FireData().auth.currentUser!=null)
  {
    String? email=FireData().auth.currentUser!.email;
    print(email);
   // await FireData().logindata(email!);
    mainpage=Routes.dashboard;
  }
  //runApp(const MaterialApp(home: MyHome()));
  runApp(
       ChangeNotifierProvider(
         create: (BuildContext context)=>FireData(),
         child: MaterialApp(
             initialRoute:mainpage ,
             debugShowCheckedModeBanner: false,
             routes: pages,
           title: "KologSoft",
            home: Dashboard(title: 'Ecommerce Back Office',)
               ),
       )
  );
}
