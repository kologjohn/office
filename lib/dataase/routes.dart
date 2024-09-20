import 'package:ecomoffice/screens/stafflist.dart';

import '../screens/dashboard.dart';
import '../screens/login.dart';
import '../screens/signup.dart';

class Routes{
  static String login="login";
  static String dashboard="dashboard";
  static String signup="signup";
  static String stafflist="stafflist";
}
final pages={
  Routes.login:(context)=>Dashboard(title: "Dashboard"),
  Routes.dashboard:(context)=>Dashboard(title: "Dashboard"),
  Routes.signup:(context)=>const Signup(),
  Routes.stafflist:(context)=>Stafflist(),
};