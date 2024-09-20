import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';
import '../forms/inputfield.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final formkey=GlobalKey<FormState>();
  bool formvalidate(){
    return formkey.currentState!.validate();
  }
  TextEditingController username_controller=TextEditingController();
  TextEditingController email_controller=TextEditingController();
  TextEditingController phone_controller=TextEditingController();
  TextEditingController password_controller=TextEditingController();
  String accesslevel="";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Add New User"),
      ),
      body: ProgressHUD(
        child: Consumer<FireData>(
          builder: (BuildContext context, FireData value, Widget? child) {
            return Container(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: Column(
                      children: [
                        InputField(controller: username_controller, lableText: "UserName", hintText: "Enter Username ", textInputType: TextInputType.name,password: false,),
                        InputField(controller: phone_controller, lableText: "Phone", hintText: "Enter Phone Number ", textInputType: TextInputType.phone,password: false,),
                        InputField(controller: email_controller, lableText: "Email", hintText: "Enter Email Address ", textInputType: TextInputType.emailAddress,password: false,),
                        InputField(controller: password_controller, lableText: "Password", hintText: "Enter Password", textInputType: TextInputType.visiblePassword,password: true,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()
                            ),
                            items: <String>['Super Admin', 'Admin', 'Supplier'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              accesslevel=val!;
                            },
                          ),
                        ),
                        ElevatedButton(onPressed: ()async{
      
                          final progress=ProgressHUD.of(context);
                          if(formvalidate()){
                            progress!.show();
      
                            String name=username_controller.text;
                            String email=email_controller.text;
                            String phone=phone_controller.text;
                            String password=password_controller.text;
                            await value.createaccount(phone, name, email, password, accesslevel);
                            if(value.successtxt==1)
                              {
                                SnackBar snackBar=SnackBar(backgroundColor:Colors.amber[900],content: Container(child: const Text("Record Saved Successfully",style: TextStyle(color: Colors.green),),));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            else {
                              SnackBar snackBar= SnackBar(backgroundColor:Colors.red[900],content: Container(child: Text(value.errortxt,style: const TextStyle(color: Colors.white),),));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                            username_controller.clear();
                            email_controller.clear();
                            phone_controller.clear();
                            password_controller.clear();
                            progress.dismiss();
      
      
                          }
      
      
      
                        }, child: const Text("Create Account"))
                      ]
                  ),
                ),
              ),
            ),);
          },
        ),
      ),
    );
  }

}
