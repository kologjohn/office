import 'package:ecomoffice/dataase/FireaseData.dart';
import 'package:ecomoffice/forms/menu.dart';
import 'package:ecomoffice/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Mainmenu extends StatelessWidget {
  final onscroll;

  const Mainmenu({super.key, required this.onscroll});

  @override
  Widget build(BuildContext context) {
    return  Consumer<FireData>(builder: (BuildContext context, FireData value, Widget? child) {
      if(value.itemcount==0){
        value.itemCounting();
      }
      return Consumer<FireData>(
        builder: (BuildContext context, FireData value, Widget? child) {
          return NotificationListener<ScrollNotification>(
            onNotification: onscroll,
            child: Scaffold(
              backgroundColor: Colors.black12,
              body: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 5,
                  runAlignment: WrapAlignment.spaceAround,
                  children: [
                    //Staff registration
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,

                                      ),
                                      child: const Icon(Icons.person_add,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Add New Staff"),
                                  ],),
                                  InkWell(
                                      onTap: (){
                                        Menus().AddStaff(context);
                                      },
                                      child: const Icon(Icons.navigate_next)
                                  ),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.amber,

                                      ),
                                      child: const Icon(Icons.person_add,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Staff List"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),




                          ],

                        ),
                      ),
                    ),
                    //product Registation
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      value.setcurrentpage(4);

                                    },
                                    child: Row(children: [
                                      Container(
                                        height: 27,
                                        width: 27,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue,
                                        ),
                                        child: const Icon(Icons.add_shopping_cart,color:Global.whiteColor ,),
                                      ),
                                      const SizedBox(width: 10,),
                                      const Text("Add New Items"),
                                    ],),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      value.setcurrentpage(1);
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child:  Text("${value.itemcount}",style: TextStyle(color: Colors.white),))
                                    ),
                                  ),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),
                            Divider(height: 10,),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      //value.setcurrentpage(4);

                                    },
                                    child: Row(children: [
                                      Container(
                                        height: 27,
                                        width: 27,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Colors.blue,

                                        ),
                                        child: const Icon(Icons.add_shopping_cart,color:Global.whiteColor ,),
                                      ),
                                      const SizedBox(width: 10,),
                                      const Text("Cart"),
                                    ],),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      //value.setcurrentpage(1);
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child:  Text("${value.completedcheckout}",style: TextStyle(color: Colors.white),))
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      //value.setcurrentpage(1);
                                    },
                                    child: Container(
                                        height: 20,
                                        width: 25,
                                        decoration: BoxDecoration(
                                            color: Colors.red[900],
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Center(child:  Text("${value.pendingcheckout}",style: TextStyle(color: Colors.white),))
                                    ),
                                  ),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),

                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.amber,

                                      ),
                                      child: const Icon(Icons.cabin,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Add Product Categories"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.deepPurple,

                                      ),
                                      child: const Icon(Icons.app_registration_rounded,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Add Product Categories"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),


                          ],

                        ),
                      ),
                    ),
                    //stocking
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,

                                      ),
                                      child: const Icon(Icons.storage,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Add Stock"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.cyan[200],

                                      ),
                                      child: const Icon(Icons.add,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("View Stock"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.cyan[200],

                                      ),
                                      child: const Icon(Icons.phone,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Change Phone Number"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),




                          ],

                        ),
                      ),
                    ),

                    //company settings
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        decoration:  BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,

                                      ),
                                      child: const Icon(Icons.home,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Change Business Name"),
                                  ],),
                                  InkWell(onTap:(){
                                    value.setcurrentpage(5);
                                  },child: const Icon(Icons.navigate_next)),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.cyan[200],

                                      ),
                                      child: const Icon(Icons.email,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Change Email Address"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              child: Divider(height: 10,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 27,
                                      width: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.cyan[200],

                                      ),
                                      child: const Icon(Icons.phone,color:Global.whiteColor ,),
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text("Change Phone Number"),
                                  ],),
                                  const Icon(Icons.navigate_next),
                                ],
                              ),

                            ),




                          ],

                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          );
        },
      );
    },
    );
  }
}
