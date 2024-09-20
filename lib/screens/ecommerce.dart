import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/dataase/FireaseData.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../forms/menu.dart';

class EcommerceKpi extends StatelessWidget {
   EcommerceKpi({super.key, required this.onscroll});
   final onscroll;
  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    Size screen=MediaQuery.of(context).size;
    double screewith=screen.width;
    return  Consumer<FireData>(
      builder: (BuildContext context, FireData value, Widget? child) {
        if(value.itemcount==0)
          {
            value.itemCounting();
          }
        value.itemCounting();

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: const Color(0xf2050333),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(child: Wrap(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 10,
                                    borderRadius: BorderRadius.circular(10),
                                    //color: Colors.black,
                                    child: FittedBox(
                                      child: Container(
                                        width: 400,
                                        height: 650,
                                        color: const Color(0xe60e1248),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Total sales", style: TextStyle(color: Colors.white,fontSize: 22),),
                                              const Divider(height: 40, thickness: 0.01,),
                                              Row(
                                                children: [
                                                  const Text("\$", style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                                                  Text('${value.totalsales}',
                                                    style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 65),),
                                                ],
                                              ),
                                              const Text("Today",
                                                style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                                              const Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up,color: Colors.green),
                                                  Text("\$229",
                                                    style: TextStyle(color: Colors.green,fontSize: 15),),
                                                  SizedBox(width: 10,),
                                                  Text("vs same day last week",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                ],
                                              ),
                                              const Divider(height: 40,thickness: 0.01,),
                                              const Text("Sales volume",
                                                style: TextStyle(color: Colors.white,fontSize: 22),),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 200,
                                        color: const Color(0xe60e1248),
                                        child: const Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child:  Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Sales by Location",
                                                style: TextStyle(color: Colors.white,fontSize: 22),),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: [
                                                  Text("United States",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  SizedBox(width: 220,),
                                                  Text("\$15.1k",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              Divider(thickness: 0.2),
                                              Row(
                                                children: [
                                                  Text("Canada",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  SizedBox(width: 260,),
                                                  Text("\$3.6k",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              )
                                  
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 860,
                                        color: const Color(0xe60e1248),
                                        child:  Padding(
                                          padding:  const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Completed Orders", style: TextStyle(color: Colors.white,fontSize: 22),),
                                              const Divider(height: 30,thickness: 0.01,),
                                              Text("${value.completedcheckout}",style: const TextStyle(fontSize: 65,color: Colors.white,fontWeight: FontWeight.bold),),
                                              const Text("Today",style: TextStyle(fontSize: 15,color: Colors.white),),
                                              const Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up,color: Colors.green),
                                                  Text("8",style: TextStyle(fontSize: 15,color: Colors.green),),
                                                  SizedBox(width: 10,),
                                                  Text("Vs same day last week",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                ],
                                              ),
                                              const Divider(height: 40, thickness: 0.5,),
                                              const Text("Pending Order",style: TextStyle(color: Colors.white,fontSize: 22),),
                                              InkWell(onTap:(){},child: FittedBox(child: Text("${value.pendingcheckout}",style: const TextStyle(fontSize: 65,color: Colors.white,fontWeight: FontWeight.bold),))),
                                              const Text("Today",style: TextStyle(fontSize: 15,color: Colors.white),),
                                              const Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up,color: Colors.green),
                                                  Text("8",style: TextStyle(fontSize: 15,color: Colors.green),),
                                                  SizedBox(width: 10,),
                                                  Text("Vs same day last week",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                ],
                                              ),
                                              const Divider(height: 30,thickness: 0.5,),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 550,
                                        color: const Color(0xe60e1248),
                                        child: const Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Items & Stock Summary",
                                                style: TextStyle(color: Colors.white,fontSize: 20),),
                                              Divider(height: 30,thickness: 0.01,),
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Stock Value",style: TextStyle(color: Colors.white),),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("\$",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                                                      Text("11.27k",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 65,color: Colors.white),),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Text("This month",style: TextStyle(fontSize: 15,color: Colors.white),),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up,color: Colors.green),
                                                  Text("\$\2.02k",style: TextStyle(fontSize: 15,color: Colors.green),),
                                                  SizedBox(width: 10,),
                                                  Text("Vs last month",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                ],
                                              ),
                                              Divider(height: 30,thickness: 0.01,),
                                              Row(
                                                children: [
                                                  //Text("\$",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                                                  Text("59%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 65,color: Colors.white),),
                                                ],
                                              ),
                                              Text("Net profit margin",style: TextStyle(fontSize: 15,color: Colors.white),),
                                              Row(
                                                children: [
                                                  Icon(Icons.arrow_drop_up,color: Colors.green),
                                                  Text("2%",style: TextStyle(fontSize: 15,color: Colors.green),),
                                                  SizedBox(width: 10,),
                                                  Text("Vs last month",style: TextStyle(fontSize: 15,color: Colors.white),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 300,
                                        color: const Color(0xe60e1248),
                                        child: const Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Avg. Order value",
                                                style: TextStyle(color: Colors.white,fontSize: 22),),
                                              AnimatedRadialGauge(
                                                /// The animation duration.
                                                  duration: const Duration(seconds: 1),
                                                  curve: Curves.elasticOut,
                              
                                                  /// Define the radius.
                                                  /// If you omit this value, the parent size will be used, if possible.
                                                  radius: 100,
                              
                                                  /// Gauge value.
                                                  value: 100,
                              
                                                  /// Optionally, you can configure your gauge, providing additional
                                                  /// styles and transformers.
                                                  axis: GaugeAxis(
                                                    /// Provide the [min] and [max] value for the [value] argument.
                                                    min: 0,
                                                    max: 100,
                                                    /// Render the gauge as a 180-degree arc.
                                                    degrees: 180,
                              
                                                    /// Set the background color and axis thickness.
                                                    style: const GaugeAxisStyle(
                                                      thickness: 20,
                                                      background: Color(0xFFDFE2EC),
                                                      segmentSpacing: 4,
                                                    ),
                              
                                                    /// Define the pointer that will indicate the progress (optional).
                                                    pointer: GaugePointer.needle(
                                                      color: Colors.green,
                                                      height: 50,
                                                      width: 30,
                                                      //size: Size(16, 100),
                                                      borderRadius: 16,
                                                      //backgroundColor: Color(0xFF193663),
                                                    ),
                              
                                                    /// Define the progress bar (optional).
                                                    progressBar: const GaugeProgressBar.rounded(
                                                      color: Color(0xFFB4C2F8),
                                                    ),
                              
                                                    /// Define axis segments (optional).
                                                    segments: [
                                                      const GaugeSegment(
                                                        from: 0,
                                                        to: 50,
                                                        color: Colors.black,
                                                        cornerRadius: Radius.zero,
                                                      ),
                                                      const GaugeSegment(
                                                        from: 50,
                                                        to: 100,
                                                        color: Colors.green,
                                                        cornerRadius: Radius.zero,
                                                      ),
                                                      // const GaugeSegment(
                                                      //   from: 66.6,
                                                      //   to: 100,
                                                      //   color: Color(0xFFD9DEEB),
                                                      //   cornerRadius: Radius.zero,
                                                      // ),
                                                    ],
                              
                                                    /// You can also, define the child builder.
                                                    /// You will build a value label in the following way, but you can use the widget of your choice.
                                                    ///
                                                    /// For non-value related widgets, take a look at the [child] parameter.
                                                    /// ```
                                                    /// builder: (context, child, value) => RadialGaugeLabel(
                                                    ///  value: value,
                                                    ///  style: const TextStyle(
                                                    ///    color: Colors.black,
                                                    ///    fontSize: 46,
                                                    ///    fontWeight: FontWeight.bold,
                                                    ///  ),
                                                    /// ),
                                                    /// ```
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 500,
                                        color: const Color(0xe60e1248),
                                        child: const Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("P&L Statement-last month",
                                                style: TextStyle(color: Colors.white,fontSize: 22),),
                                              Divider(height: 15,thickness: 0.01,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Sale Price",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 220,),
                                                  Text("\$22k",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              Divider(thickness: 0.2),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Referer cut",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 260,),
                                                  Text("\$259",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              Divider(thickness: 0.2,),
                                              Divider(thickness: 0.01,height: 45),
                                              Divider(thickness: 0.2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Packaging Cost",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 220,),
                                                  Text("\$380",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              Divider(thickness: 0.2),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Shiping costs",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 260,),
                                                  Text("\$1,140",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              Divider(thickness: 0.2),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Warehouse cost",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 220,),
                                                  Text("\$912",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),)
                                                ],
                                              ),
                                              // Divider(thickness: 0.2,),
                                              Divider(thickness: 0.2,),
                                              Divider(thickness: 0.01,height: 45,),
                                              Divider(thickness: 0.2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Paypal transaction",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 260,),
                                                  Text("\$3.6k",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                              
                                                ],
                                              ),
                                              Divider(thickness: 0.2,),
                                              Divider(thickness: 0.01,height: 45,),
                                              Divider(thickness: 0.2,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Total cost",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                  //SizedBox(width: 260,),
                                                  Text("\$3.6k",
                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                              
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width: 400,
                                        height: 350,
                                        color: const Color(0xe60e1248),
                                        child:  Padding(
                                          padding:  EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text("Recent Completed Checkout",
                                                style: TextStyle(color: Colors.white,fontSize: 22),),
                                              const Divider(height: 20,thickness: 0.01,),
                                              StreamBuilder<QuerySnapshot>(
                                                stream: value.db.collection("checkout").where('status',isEqualTo: true).snapshots(),
                                                builder: (context, snapshot) {
                                                  if(!snapshot.hasData){
                                                    return const Text("Loading...",style: TextStyle(color: Colors.white),);
                                                  }

                                                  return Container(
                                                    height: 250,
                                                    child: ListView.builder(
                                                      itemCount: snapshot.data!.docs.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        String fullname="${snapshot.data!.docs[index]['lastname']} ${snapshot.data!.docs[index]['firstname']}";
                                                        String email=snapshot.data!.docs[index]['email'];
                                                        String address=snapshot.data!.docs[index]['address'];
                                                        String phone=snapshot.data!.docs[index]['phone'];
                                                        String city=snapshot.data!.docs[index]['city'];
                                                        String country=snapshot.data!.docs[index]['country'];
                                                        String region=snapshot.data!.docs[index]['region'];
                                                        String postalcode=snapshot.data!.docs[index]['postalcode'];
                                                        String id=snapshot.data!.docs[index].id;
                                                        String amt="${snapshot.data!.docs[index]['total']}";
                                                        // Convert timestamp to DateTime
                                                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(id));
                                                        // Format the DateTime
                                                        String date = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

                                                        return  Column(
                                                          children: [
                                                            InkWell(
                                                              onTap:(){
                                                                Menus().Showdetails(context, id, amt, fullname, address, phone, city, country, postalcode,email,date,region);
                                                            },
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                  Text(fullname,
                                                                    style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                  //SizedBox(width: 220,),
                                                                  Text(amt, style: TextStyle(color: Colors.white,fontSize: 15),),
                                                                  Icon(Icons.navigate_next,color: Colors.white,)
                                                                ],
                                                              ),
                                                            ),
                                                            Divider(thickness: 0.2),

                                                          ],

                                                        );

                                                      },
                                                    ),
                                                  );
                                                }
                                              ),

                                            ],
                                          ),
                                        ),

                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
