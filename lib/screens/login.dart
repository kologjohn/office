import 'package:ecomoffice/forms/inputfield.dart';
import 'package:ecomoffice/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:ecomoffice/dataase/FireaseData.dart';

import '../dataase/routes.dart';
import '../main.dart';
class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final loginkey=GlobalKey<FormState>();
  TextEditingController email_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  bool formvalidate(){
    return loginkey.currentState!.validate();
  }
  @override
  Widget build(BuildContext context) {

    return  ProgressHUD(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:Colors.green[900],
          title: const Text("KologSoft E-commerce",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          child: Consumer<FireData>(
            builder: (BuildContext context, firedata, child) {
              Size screensize=MediaQuery.of(context).size;
              double width=screensize.width;
              double heiht=screensize.height;
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 400,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0,100,0,0),
                        child: Card(
                          child: Form(
                            key: loginkey,
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("BACK OFFICE LOGIN",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                ),
                              InputField(password:false,hintText: "Enter Email Address", controller: email_controller, textInputType: TextInputType.emailAddress, lableText: "Email"),
                             const SizedBox(height: 10,),
                              InputField(password:false,hintText: "Enter Password", controller: password_controller, textInputType: TextInputType.text, lableText: "Password"),
                                ElevatedButton(onPressed: ()async{
                                  if(formvalidate()){
                                    final progress=ProgressHUD.of(context);
                                    progress!.show();
                                    Future.delayed(Duration(seconds: 10),(){
                                      progress.dismiss();
                                    });
                                    String password=password_controller.text;
                                    String email=email_controller.text;
                                    final logi=await firedata.login(email, password,context);
                                    if(firedata.successtxt==1){
                                      FireData().checklogin();
                                      email_controller.clear();
                                      password_controller.clear();
                                      Navigator.pushReplacementNamed(context, Routes.dashboard);
                                      FireData().logindata(email);
                                      progress.dismiss();
                                    }
                                    else
                                    {
                                      SnackBar snackbar=SnackBar(content: Text(firedata.errortxt));
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                      progress.dismiss();
                                    }

                                  }

                                }, child: const Text("Login"))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );

            },
          ),
        ),
      ),
    );
  }
}
