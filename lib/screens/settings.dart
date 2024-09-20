import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/forms/inputfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';

class Settings extends StatelessWidget {
  bool optio=false;
  final formval;
  final onNotification;

  Settings({super.key,required this.onNotification, required this.formval});

  @override
  Widget build(BuildContext context) {

    TextEditingController companyname_controller=TextEditingController();
    TextEditingController email_controller=TextEditingController();
    TextEditingController phone_contrler=TextEditingController();
    TextEditingController address_controller=TextEditingController();
    TextEditingController currency_controller=TextEditingController();
    String photourl="";
    return ProgressHUD(
      child: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {
          return NotificationListener<ScrollNotification>(
              onNotification: onNotification,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,8,8,60),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireData().db.collection("settings").where('code',isEqualTo: '002').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData)
                      {
                        if(snapshot.data!.docs.isNotEmpty){
                          companyname_controller.text=snapshot.data!.docs[0]['name'];
                          email_controller.text=snapshot.data!.docs[0]['email'];
                          address_controller.text=snapshot.data!.docs[0]['address'];
                          currency_controller.text=snapshot.data!.docs[0]['currency'];
                          phone_contrler.text=snapshot.data!.docs[0]['phone'];
                        }
                      }
                    return Container(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Form(
                              key: formval,
                              child: Column(
                                children: [
                                  InputField(d_color:Colors.white,password:false,hintText: "Enter Company Name", controller: companyname_controller, textInputType: TextInputType.text,lableText: "Item Category",),
                                  const SizedBox(height: 10,),
                                  InputField(d_color:Colors.white,password:false,hintText: "Company Phone Number", controller: phone_contrler, textInputType: TextInputType.text,lableText: "Company Phone",),
                                  const SizedBox(height: 10,),
                                  InputField(d_color:Colors.white,password:false,hintText: "Company Email", controller: email_controller, textInputType: TextInputType.text,lableText: "Company Email",),
                                  const SizedBox(height: 10,),
                                  InputField(d_color:Colors.white,password:false,hintText: "Company Address", controller: address_controller, textInputType: TextInputType.text,lableText: "Company Address",),
                                  const SizedBox(height: 10,),
                                  InputField(d_color:Colors.white,password:false,hintText: "Currency", controller: currency_controller, textInputType: TextInputType.text,lableText: "Currency",),
                                  const SizedBox(height: 10,),
                                  ElevatedButton(onPressed: ()async{
                                    if(value.validatrform(formval))
                                    {
                                      String company=companyname_controller.text.trim();
                                      String phone=phone_contrler.text.trim();
                                      String email=email_controller.text.trim();
                                      String address=address_controller.text.trim();
                                      String currency=phone_contrler.text.trim();
                                      final progress=ProgressHUD.of(context);
                                      progress!.show();
                                      await value.settings(company, phone, email, address,currency);
                                      progress.dismiss();
                                    }
                                    // value.validatrform();

                                  }, child: const Text("Update Company Info",style: TextStyle(fontSize: 20),))


                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              )
      
          );
        },
      ),
    );
  }
}
