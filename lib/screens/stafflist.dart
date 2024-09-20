import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../dataase/Dbfields.dart';
import '../dataase/FireaseData.dart';
import '../dataase/routes.dart';

class Stafflist extends StatelessWidget {
  Stafflist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,8,8,80),
        child: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, Routes.signup);
          //Navigator.push(context, MaterialPageRoute(builder: (context) => const Signup()),);

        },child: const Icon(Icons.add),),
      ),
      body: Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {

          return NotificationListener<ScrollNotification>(
              //onNotification: onNotification,
              child: Column(
                children: [
                  Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: value.db.collection(StaffData.db_user).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if(!snapshot.hasData){
                          return const Text("No Records yet");
                        }
                        return Container(
                          decoration: const BoxDecoration(
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              // String timestampString = value.ttime;
                              // DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampString) * 1000);
                              String name=snapshot.data!.docs[index][StaffData.name].toString();
                              String email=snapshot.data!.docs[index][StaffData.email].toString();
                              String phone=snapshot.data!.docs[index][StaffData.phone].toString();
                              String accesslevel=snapshot.data!.docs[index][StaffData.accesslevel].toString();
                              Icon respon=const Icon(Icons.send,color: Colors.green );
                              return  InkWell(
                                onLongPress: ()async{
                                //  value.deletedata(email);
                                  // print(value.tids[index]);
                                  //  await value.confirmreceipt("supStaff", "supTime", value.keys[index],0);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(color: Colors.white),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Expanded(flex:1,child: Column(
                                            children: [
                                              Icon(Icons.card_travel,size: 30,color: Colors.orangeAccent,)
                                            ],
                                          )),
                                          Expanded(
                                            flex: 4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(name,style: GoogleFonts.k2d(fontSize: 18,fontWeight: FontWeight.w900),),
                                                Text(email,style:GoogleFonts.k2d(fontSize: 18)),
                                                Text(phone,style:GoogleFonts.k2d(fontSize: 18)),
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: const EdgeInsets.fromLTRB(0, 3, 5, 0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(accesslevel,style:GoogleFonts.abel(fontSize: 10),),
                                                  Text(snapshot.data!.docs[index][StaffData.email].toString(),style:GoogleFonts.abel(fontSize: 10),),
                                                ],
                                              ),
                                            ),
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

          );
        },
      ),
    );
  }
}
