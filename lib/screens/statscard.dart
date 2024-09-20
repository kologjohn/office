import 'package:flutter/material.dart';
import '../global.dart';
class dailydata extends StatelessWidget {
  final String daydate;
  final String dayname;
  final String amount;
  const dailydata({super.key, required this.daydate, required this.dayname, required this.amount,});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxWidth: 800
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Column(children: [
              Icon(Icons.monetization_on,size: 100,color: Colors.cyan,)
            ],),
            SizedBox(width: 50,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(dayname,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("GHS $amount",style: const TextStyle(fontSize: 20),),
                  Text(daydate,style: const TextStyle(fontSize:24),),
                ],),
            )


          ],
        ),
      ),
    );
  }
}