import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:ecomoffice/global.dart';
import 'package:ecomoffice/screens/checkoutitem.dart';
import 'package:ecomoffice/screens/ecommerce.dart';
import 'package:ecomoffice/screens/report.dart';
import 'package:ecomoffice/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

import '../dataase/FireaseData.dart';
import 'Categorylist.dart';
import 'home.dart';
import 'homedashoard.dart';
import 'mainmeu.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final autoSizeGroup = 0;
  var _bottomNavIndex = 0;
  int currentPageIndex = 0;

  String tid="";
  bool checkstatus=false;
  bool norecord=false;
  final   formval=GlobalKey<FormState>();
  //default index of a first screen
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;
  final tid_imput=TextEditingController();
  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home,
    Icons.card_travel,
    Icons.receipt,
    Icons.brightness_7,
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Consumer<FireData>(
      builder: (BuildContext context, value, Widget? child) {
        return  Scaffold(
            backgroundColor: const Color(0xf2050333),
          // drawer: Drawer(
          //     elevation: 5,
          //     child: ListView(
          //       children: [
          //         const DrawerHeader(
          //             decoration: BoxDecoration(
          //                 color: Colors.blueGrey
          //             ),
          //             child: Column(
          //               children: [
          //                 // Icon(Icons.monetization_on,size: 60,),
          //                 Expanded(
          //                   child: CircleAvatar(
          //                     foregroundColor: Colors.white,
          //                     radius: 70,
          //                     child: Icon(Icons.card_travel),
          //                   ),
          //                 )
          //               ],
          //             )),
          //         ListTile(
          //           onTap: () {
          //             // Navigator.pushNamed(context, Routes.dashboard);
          //           },
          //           leading: const Icon(Icons.home),
          //           title: const Text("Home"),
          //         ),
          //         const Divider(height: 10, color: Colors.grey,),
          //         ExpansionTile(title: const Text("Staff",),
          //           leading: const Icon(
          //               Icons.supervised_user_circle_sharp),
          //           children: [
          //             ListTile(
          //               onTap: () {
          //                  Navigator.pushNamed(context, Routes.stafflist);
          //               },
          //               leading: const Icon(Icons.person),
          //               title: const Text("Staff List"),
          //             ),
          //             ListTile(
          //               onTap: () {
          //                 Navigator.pushNamed(context, Routes.signup);
          //               },
          //               leading: const Icon(Icons.add),
          //               title: const Text("Add Staff"),
          //             ),
          //           ],
          //         ),
          //
          //         ExpansionTile(title: const Text("Accounts",),
          //           leading: const Icon(Icons.account_balance),
          //           children: [
          //             ListTile(
          //               onTap: () {
          //                 // Navigator.pushNamed(context, Routes.banks);
          //               },
          //               leading: const Icon(Icons.person),
          //               title: const Text("Accounts List"),
          //             ),
          //             ListTile(
          //               onTap: () {
          //                 // Navigator.pushNamed(context, Routes.addbank);
          //               },
          //               leading: const Icon(Icons.add),
          //               title: const Text("Add Accounts"),
          //             ),
          //           ],
          //         ),
          //         ListTile(
          //           onTap: () {
          //             // Navigator.pushNamed(context, Routes.customers);
          //           },
          //           leading: const Icon(Icons.person),
          //           title: const Text("Clients"),
          //         ),
          //         ListTile(
          //           onTap: () {
          //             // Navigator.pushNamed(context, Routes.rates);
          //           },
          //           leading: const Icon(Icons.balance),
          //           title: const Text("Set Rate "),
          //         ),
          //         const Divider(height: 10, color: Colors.grey,),
          //
          //         ListTile(
          //           onTap: () async {
          //             await value.logout(context);
          //           },
          //           leading: const Icon(Icons.logout,color: Colors.green,),
          //           title: const Text("Signout "),
          //         ),
          //       ],
          //
          //     )
          //
          //
          // ),
          extendBody: true,
          appBar: AppBar(
            elevation: 5,
            backgroundColor: const Color(0xf2050333),
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
            ),
          ),
          body:<Widget>[
            //Homedashboard(tid: tid, norecord: norecord, checkstatus: checkstatus, tid_imput: tid_imput,onNotification: onScrollNotification,),
            EcommerceKpi(onscroll: onScrollNotification,),
            Report(tid: tid, norecord: norecord, checkstatus: checkstatus, tid_imput: tid_imput, onNotification: onScrollNotification),
            Categorylist(norecord: norecord, checkstatus: checkstatus, onNotification: onScrollNotification,),
            Mainmenu(onscroll: onScrollNotification,),
            Home(tid: tid, norecord: norecord, checkstatus: checkstatus, tid_imput: tid_imput,onNotification: onScrollNotification,formval: formval,),
            Settings(onNotification: onScrollNotification, formval: formval),
            CheckoutItems(tid: tid, norecord: norecord, checkstatus: checkstatus, tid_imput: tid_imput, onNotification: onScrollNotification)
          ][value.currentpage],

          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive
                  ? Colors.amber
                  : Colors.green;
              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      iconList[index],
                      size: 24,
                      color: color,
                    ),
                    const SizedBox(height: 4),

                  ],
                ),
              );
            },
            backgroundColor:  const Color(0xf2050333),
            activeIndex: _bottomNavIndex,
            notchAndCornersAnimation: borderRadiusAnimation,
            splashSpeedInMilliseconds: 300,
            notchSmoothness: NotchSmoothness.defaultEdge,
            gapLocation: GapLocation.center,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) async{
              if(index==0){
                value.setcurrentpage(0);
                widget.title="Dashboard";
              }
              else if(index==1){
                widget.title="Register Items";
                value.setcurrentpage(1);
              }
              else if(index==2){
                value.setcurrentpage(2);
                widget.title="Category List";
              }
              else if(index==3){
                value.setcurrentpage(3);
                widget.title="Company Info";
              }
              //currentPageIndex=index;
              setState(() => _bottomNavIndex = index);
            },
            hideAnimationController: _hideBottomBarAnimationController,
            shadow: const BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 12,
              //spreadRadius: 0.5,
              color: Colors.black12,
            ),
          ),
        );
      },
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context);
    return Container(child: const Column(
      children: [
        Text("Total  Uploaded",style: TextStyle(
            fontSize: 30
        ),),
      ],
    ) );
  }
}
