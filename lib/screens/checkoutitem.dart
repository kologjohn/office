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

class CheckoutItems extends StatelessWidget {
  TextEditingController tid_imput;
  String tid;
  bool norecord;
  bool checkstatus;
  bool optio=false;
  final onNotification;
  CheckoutItems({super.key,required this.tid,required this.norecord,required this.checkstatus,required this.tid_imput, required this.onNotification});

  @override
  Widget build(BuildContext context) {
    String reason="";
    final txt_iput=TextEditingController();
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
                            stream: value.db.collection("cart").where('cartidnumber', isEqualTo: value.ctid).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {


                              //print(value.ctid);
                              if(!snapshot.hasData){
                                return Center(child: Text("Loading",style: GoogleFonts.abel(color:Colors.white,textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),));
                              }
                              if(snapshot.hasError)
                              {
                                return Center(child: Text("Error Loading Data",style: GoogleFonts.abel(textStyle: TextStyle(color:Colors.white,fontSize: 30,fontWeight: FontWeight.bold,)),));
                              }
                              if(snapshot.connectionState==ConnectionState.waiting)
                              {
                                const CircularProgressIndicator();
                              }
                              return Container(
                                decoration: const BoxDecoration(
                                ),
                                child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    final textedit=TextEditingController();
                                    textedit.text=snapshot.data!.docs[index][Dbfields.description];
                                    String id=snapshot.data!.docs[index].id;
                                    String sprice=snapshot.data!.docs[index]['price'].toString();
                                    String quantity=snapshot.data!.docs[index]['quantity'].toString();
                                    double tottal=0;
                                    Widget statusicon=Icon(Icons.pause_circle_outline);
                                    try{
                                      if(snapshot.data!.docs[index]['status']=="delivered"){
                                        statusicon=const Icon(Icons.done_all,color: Colors.blue,);
                                      }
                                      else if(snapshot.data!.docs[index]['status']=="rejected"){
                                        statusicon=Icon(Icons.not_interested_outlined,color: Colors.red[900],);
                                      }
                                      tottal=double.parse(sprice)*double.parse(quantity);
                                      reason=snapshot.data!.docs[index]['reason'];
                                      txt_iput.text=reason;
                                      //sprice*quantity;
                                     // String reason=snapshot.data!.docs[index]['reason'].toString();
                                    }
                                    catch(e)
                                    {
                                      print(e);
                                    }
                                    // String timestampString = value.ttime;
                                    // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString) * 1000);
                                    //Icon respon=const Icon(Icons.camera_alt,color: Colors.green );
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
                                                const SizedBox(width: 20,),
                                                Flexible(
                                                  child: Column(
                                                    children: [
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
                                                                      child: Text(snapshot.data!.docs[index][Dbfields.name],style: GoogleFonts.k2d(fontSize: 14,fontWeight: FontWeight.w900,color: Colors.white),),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("Price $sprice",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("Quantity: $quantity",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Text("Total: $tottal",style:GoogleFonts.k2d(fontSize: 14,color: Colors.white)),
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
                                                                          child:Padding(
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
                                                                        ),
                                                                      ),
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
                                                          decoration: BoxDecoration(
                                                              color: Colors.blue.withOpacity(0.2),
                                                              borderRadius: BorderRadius.circular(10)
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Wrap(
                                                                  direction: Axis.horizontal,
                                                                  children: [
                                                                    InkWell(
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.blue[900],
                                                                            borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          height: 34,
                                                                          width: 100,
                                                                          child: const Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text("Approve",style: TextStyle(color: Colors.white),),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      onTap: (){
                                                                        showDialog(context: context,builder: (dialogContex){
                                                                          return Dialog(
                                                                            child: Container(
                                                                              margin: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: <Widget>[
                                                                                  const Padding(
                                                                                    padding: EdgeInsets.all(8.0),
                                                                                    child: Text("Deliver order",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                                                  ),
                                                                                  const Padding(
                                                                                    padding: EdgeInsets.all(8.0),
                                                                                    child: Text("Do you want to deliver this item?"),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                        children: <Widget>[
                                                                                          ElevatedButton(
                                                                                            onPressed: () {
                                                                                              Navigator.of(dialogContex).pop();
                                                                                            },style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                            child: const Text("No",style: TextStyle(color: Colors.white70),),),
                                                                                          const SizedBox(width: 20,),
                                                                                          ElevatedButton(
                                                                                            onPressed: () async {
                                                                                              try{
                                                                                                await value.db.collection("cart").doc(id).update({"status":"delivered"});
                                                                                                Navigator.of(dialogContex).pop();
                                                                                                value.snackbarsucess("The customer will be noify that the item has been delivered", context);
                                                                                                //Navigator.pop(context);
                                                                                              }on FirebaseException catch(e)
                                                                                              {
                                                                                                Navigator.pop(context);
                                                                                                value.snackbarerror(e.code, context);
                                                                                              }

                                                                                            },style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                                                                                            child: const Text("Yes",style: TextStyle(color: Colors.white),),)
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                      },
                                                                    ),
                                                                    InkWell(
                                                                      onTap: (){
                                                                        showDialog(context: context,builder: (dialogContex){
                                                                          return Dialog(
                                                                            child: ConstrainedBox(
                                                                              constraints: const BoxConstraints(
                                                                                maxWidth: 800,
                                                                              ),
                                                                              child: Container(
                                                                                margin: const EdgeInsets.all(8.0),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: <Widget>[
                                                                                    const Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text("Decline Order",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                                                    ),
                                                                                    Container(
                                                                                      height: 100,
                                                                                      width: 400,
                                                                                      child: TextFormField(
                                                                                        controller: txt_iput,
                                                                                        decoration: const InputDecoration(
                                                                                          hintText: "Input the reason for declining the order",

                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    const Padding(
                                                                                      padding: EdgeInsets.all(8.0),
                                                                                      child: Text("Do you really want to decline this order"),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                          children: <Widget>[
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                Navigator.pop(context);
                                                                                              },style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                                              child: const Text("No",style: TextStyle(color: Colors.white70),),),
                                                                                            const SizedBox(width: 20,),
                                                                                            ElevatedButton(
                                                                                              onPressed: () async {
                                                                                                await value.db.collection("cart").doc(id).update({"status":"rejected","reason":txt_iput.text});
                                                                                                value.snackbarsucess("Item declined, the customer will be notified that the transactions has been declined", context);
                                                                                                Navigator.of(dialogContex).pop();
                                                                                               // txt_iput.clear();
                                                                                                // Navigator.pop(context);
                                                                                              },style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                                                                                              child: const Text("Yes",style: TextStyle(color: Colors.white),),)
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });

                                                                      },
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                              color: Colors.red[900],
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          height: 34,
                                                                          width: 100,
                                                                          child: const Padding(
                                                                            padding: EdgeInsets.all(8.0),
                                                                            child: Text("Decline",style: TextStyle(color: Colors.white),),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                            color: Colors.brown[900],
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                        height: 34,
                                                                        width: 100,
                                                                        child:  Padding(
                                                                          padding: EdgeInsets.all(8.0),
                                                                          child: statusicon//Text("Status",style: TextStyle(color: Colors.white),),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
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
