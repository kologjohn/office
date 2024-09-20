import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/dataase/Dbfields.dart';
import 'package:ecomoffice/forms/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../dataase/FireaseData.dart';

class Report extends StatelessWidget {
  TextEditingController tid_imput;
  String tid;
  bool norecord;
  bool checkstatus;
  bool optio=false;
  final onNotification;
  Report({super.key,required this.tid,required this.norecord,required this.checkstatus,required this.tid_imput, required this.onNotification});

  @override
  Widget build(BuildContext context) {
    final FocusNode _focusNode = FocusNode();
    return ProgressHUD(
      child: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0,10,0,50),
                child: NotificationListener<ScrollNotification>(
                    onNotification: onNotification,
                    child: Column(
                      children: [
                        Flexible(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: value.db.collection("items").where('companyemail', isEqualTo: 'info@kologsoft.com').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(!snapshot.hasData){
                                return Center(child: Text("Loading",style: GoogleFonts.abel(color:Colors.white,textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),));
                              }
                              if(snapshot.hasError)
                                {
                                  return Center(child: Text("Error Loading Data",style: GoogleFonts.abel(textStyle: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),));

                                }
                              if(snapshot.connectionState==ConnectionState.waiting)
                                {
                                  CircularProgressIndicator();
                                }
                             return Container(
                                decoration: const BoxDecoration(

                                ),
                                child: Focus(
                                  focusNode: _focusNode,
                                  child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      final textedit=TextEditingController();
                                      textedit.text=snapshot.data!.docs[index][Dbfields.description];
                                      // String timestampString = value.ttime;
                                      // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString) * 1000);
                                      Icon respon=const Icon(Icons.camera_alt,color: Colors.green );
                                      // if(snapshot.data!.docs[index]['sync_status']==1)
                                      // {
                                      //   respon=Icon(Icons.done_all_outlined,color: Colors.blue );
                                      // }

                                      return  Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Material(
                                          elevation: 10,
                                          color: const Color(0xf2050333),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                 color: const Color(0xe60e1248),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                SizedBox(width: 20,),
                                                  Flexible(
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            width: 200,
                                                            height: 200,
                                                            decoration:  BoxDecoration(
                                                              color: Colors.black38,
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child:CachedNetworkImage(
                                                              height: 180,
                                                              width: 180,
                                                              imageUrl: snapshot.data!.docs[index][Dbfields.itemurl],
                                                              fit:BoxFit.fill,
                                                              errorListener: (err){
                                                                print(err);
                                                              },
                                                            ) , //ImageNetwork(image: snapshot.data!.docs[index][Dbfields.itemurl], height: 200, width: 200),
                                                          ),
                                                        ),
                                                        Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                               Expanded(
                                                                 flex: 1,
                                                                 child: Column(
                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text(snapshot.data!.docs[index][Dbfields.item],style: GoogleFonts.k2d(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.white),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("USD: ${snapshot.data!.docs[index][Dbfields.sellingprice]}",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("Code: ${snapshot.data!.docs[index][Dbfields.code]}",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("Category: ${snapshot.data!.docs[index][Dbfields.category]}",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
                                                                    ),

                                                                  ],
                                                                                                                             ),
                                                               ),
                                                               Expanded(
                                                                 flex: 2,
                                                                 child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Container(
                                                                        height:200,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        child: Material(
                                                                          color: Colors.black54,
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(10.0),
                                                                            child: EditableText(
                                                                                selectionColor: Colors.white38,
                                                                                expands: true,
                                                                                maxLines:null,
                                                                                controller: textedit, focusNode: FocusNode(),
                                                                                style: const TextStyle(fontSize: 16,color: Colors.white),
                                                                                cursorColor:Colors.white ,
                                                                                backgroundCursorColor: Colors.black
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: ElevatedButton(onPressed: ()async{
                                                                        final progress=ProgressHUD.of(context);
                                                                        progress!.show();
                                                                        await value.updatedes(textedit.text, snapshot.data!.docs[index].id);
                                                                        progress!.dismiss();
                                                                        SnackBar snackbar=const SnackBar(content: Text("Updated Successfully"),backgroundColor: Colors.green,);
                                                                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                                                      },child: const Text("Update Description")),
                                                                    ),
                                                                  ],
                                                                                                                             ),
                                                               )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(
                                                            height: 50,
                                                            decoration: BoxDecoration(
                                                              color: Colors.blue.withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(10)
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Wrap(
                                                                  children: [
                                                                    InkWell(child: const Icon(Icons.qr_code,color: Colors.white,),onTap: ()async{
                                                                      //final login=await value.auth.createUserWithEmailAndPassword(email: "jona@heritagebaskethub.com", password: "1234qw");
                                                                      //print("$login");
                                                                    },),
                                                                    const SizedBox(width: 20,),
                                                                    InkWell(child: Icon(Icons.delete,color: Colors.red,),onTap: ()async{
                                                                      await value.db.collection("items").doc(snapshot.data!.docs[index].id).delete();
                                                                      value.snackbarsucess("Item Deleted Successfully", context);
                                                                      print("Delte");
                                                                    },),
                                                                    const SizedBox(width: 20,),
                                                                    InkWell(child: Icon(Icons.edit,color: Colors.amber,),onTap: (){
                                                                      String item=snapshot.data!.docs[index][Dbfields.item];
                                                                      String barcode=snapshot.data!.docs[index][Dbfields.code];
                                                                      String category=snapshot.data!.docs[index][Dbfields.category];
                                                                      String sellingprice=snapshot.data!.docs[index][Dbfields.sellingprice];
                                                                      String costprice=snapshot.data!.docs[index][Dbfields.costprice];
                                                                      String wholesaleprice=snapshot.data!.docs[index][Dbfields.wholesaleprice];
                                                                      String description=snapshot.data!.docs[index][Dbfields.description];
                                                                      String quantity=snapshot.data!.docs[index][Dbfields.quantity];
                                                                      String photo=snapshot.data!.docs[index][Dbfields.itemurl];
                                                                      String key=snapshot.data!.docs[index].id;
                                                                      Menus().editItems(context, item, barcode, sellingprice, costprice, wholesaleprice, description, category,quantity,photo,key);
                                                                      print("Edit");
                                                                    },),
                                                                    const SizedBox(width: 20,),
                                                                    InkWell(child: Icon(Icons.camera_alt,color: Colors.teal,),onTap: ()async{
                                                                      ImageSource source=ImageSource.camera;
                                                                      await value.updateImage(source, snapshot.data!.docs[index].id);
                                                                      print(value.imageUrl);
                                                                    },),
                                                                    const SizedBox(width: 20,),
                                                                    InkWell(child: Icon(Icons.image,color: Colors.blueGrey,),onTap: ()async{
                                                                      ImageSource source=ImageSource.gallery;
                                                                      await value.updateImage(source, snapshot.data!.docs[index].id);
                                                                      print(value.imageUrl);
                                                                    },)

                                                                  ],
                                                                )
                                                              ],),
                                                          ),
                                                        )
                                                    ],),
                                                  ),

                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )

                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
