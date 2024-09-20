import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomoffice/dataase/Dbfields.dart';
import 'package:ecomoffice/dataase/routes.dart';
import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireData extends ChangeNotifier{
  final db=FirebaseFirestore.instance;
  final numformat = NumberFormat("#,##0.00", "en_US");
  final year=DateTime.now().year;
  final month=DateTime.now().month.toString().padLeft(2,'0');
  String currentMonth = DateFormat('MM').format(DateTime.now());
  String currentDay = DateFormat('dd').format(DateTime.now());
  String dayNumberWithLeadingZero = DateFormat('dd').format(DateTime.now());
  DateTime now = DateTime.now();
  // Get the day number with a leading zero if necessary
  final day=DateTime.now().day;
  final dayname=DateTime.now().weekday;
  final tid_txt=DateTime.timestamp().millisecondsSinceEpoch;

  double totalsales=0;
  int itemcount=0;
  int customercount=0;
  int pendingcheckout=0;
  int completedcheckout=0;
  String ctid="";
  String accesslevel="";
  String name="";
  String phone="";
  String errortxt="";
  String mykeys="";
  bool check_status=false;
  int successtxt=0;
  List<dynamic>  items=[];
  List<String>  price=[];
  List<String>  qty=[];
  List<String>  total=[];
  List<String> keys=[];
  List<int> tids=[];
  List<int> supstatus=[];
  String tdata="";
  String ttime="";
  String staff="";
  String tid="";
  int dc=0;
  int record=0;
  final auth=FirebaseAuth.instance;
  String imageUrl="";
  final storageRef = FirebaseStorage.instance.ref();
  ImagePicker imagePicker = ImagePicker();
  File? file;
  int currentpage=0;
  selectedtid(String tid)async{
    ctid=tid;
    notifyListeners();
  }

  itemCounting()async{
    final countdb=await db.collection("items").get();
    final pencheckoutdb=await db.collection("checkout").where('status',isEqualTo:false).get();
    final comcheckoutdb=await db.collection("checkout").where('status',isEqualTo:true).get();
    pendingcheckout=pencheckoutdb.docs.length;
    completedcheckout=comcheckoutdb.docs.length;
    itemcount=countdb.docs.length;
    final shards = await db.collection('checkout').where('status',isEqualTo: true).get();
    totalsales=0;
    shards.docs.forEach(
          (doc) async {
        final sum=doc.data()['total'];
       totalsales+=double.parse("${sum}");
       // print(sum);
      },
    );
    notifyListeners();
  }
  setcurrentpage(int selectedpage){
    currentpage=selectedpage;
    notifyListeners();
  }

  snackbarerror(String message,BuildContext context){
    SnackBar snackBar=SnackBar(content: Text(message,style: const TextStyle(color: Colors.white),),backgroundColor: Colors.red,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  snackbarsucess(String message,BuildContext context){
    SnackBar snackBar=SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  bool validatrform(GlobalKey<FormState> formkey){
    return formkey.currentState!.validate();
  }
  uploadImageToStorage(ImageSource type) async {
    imageUrl="";
    final timestamp = DateTime.timestamp().millisecondsSinceEpoch;
    final uid = auth.currentUser?.uid;
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("$uid$timestamp.jpg");
      final ImagePicker picker = ImagePicker();
      // Create file metadata including the content type
      XFile? image = await picker.pickImage(source: type);
      Uint8List imageData = await XFile(image!.path).readAsBytes();
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      await storageRef.child("$uid$timestamp.jpg").putData(imageData, metadata).then((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          print(await taskSnapshot.ref.getDownloadURL());
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          file = File(image.path);
        }
      });
    } on FirebaseException catch (e) {
      //errorMsgs = e.message!;
     // print("MSG: $e");
    }
    notifyListeners();
  }
  updateImage(ImageSource type,String key) async {
    final timestamp = DateTime.timestamp().millisecondsSinceEpoch;
    final uid = auth.currentUser?.uid;
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child("$uid$timestamp.jpg");
      final ImagePicker picker = ImagePicker();
      // Create file metadata including the content type
      XFile? image = await picker.pickImage(source: type);
      Uint8List imageData = await XFile(image!.path).readAsBytes();
      var metadata = SettableMetadata(
        contentType: "image/jpeg",
      );
      await storageRef
          .child("$uid$timestamp.jpg")
          .putData(imageData, metadata)
          .then((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          print(await taskSnapshot.ref.getDownloadURL());
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          await db.collection("items").doc(key).update({Dbfields.itemurl:imageUrl});
          file = File(image.path);
          print("Updated");
        }
      });
    } on FirebaseException catch (e) {
      //errorMsgs = e.message!;
      print("MSG: $e");
    }
    notifyListeners();
  }
  Category(String item,String code)async{
    try{
      await db.collection("category").add({"name":item,"code":code});

    }catch (e){
      print(e);

    }
}
  Categoryupdate(String item,String oldname,String key)async{
    try{
     // print(oldname);
      await db.collection("category").doc(key).update({"name":item});

      final shards = await db.collection('items').where('category',isEqualTo:oldname ).get();
      shards.docs.forEach(
            (doc) async {
              String id=doc.id;
              await db.collection("items").doc(id).update({"category":item});
          print(id);
        },
      );
    }catch (e){
      print(e);

    }
  }
  deletecategory(String key)async{
    try{
      await db.collection("category").doc(key).delete();
    }catch (e){
      print(e);

    }
  }
  updatedes(String text,String key)async{
    await db.collection("items").doc(key).update({Dbfields.description:text});
}
  settings(String name,String phone,String email,String address,String currency) async{
    try{
      final data={
        "name":name,
        "phone":phone,
        "email":email,
        "address":address,
        "currency":currency
      };
      await db.collection("settings").doc(email).set(data);
    }catch (e){
      print(e);
    }
  }
  registeritem(String item,String sellingprice,String costprice,String wholesaleprice,String quantity,String description,String code,String category,String photourl)async{
    final date=DateTime.timestamp();
    String staff="JohnKolog";
    try{
      final updataData={
         Dbfields.item:item,
         Dbfields.costprice:costprice,
         Dbfields.sellingprice:sellingprice,
         Dbfields.wholesaleprice:wholesaleprice,
         Dbfields.quantity:quantity,
         Dbfields.description:description,
         Dbfields.code:code,
         Dbfields.category:category,
         Dbfields.staff:staff,
         Dbfields.date:date,
         Dbfields.itemurl:photourl,
         Dbfields.companyemail:"info@kologsoft.com",
         Dbfields.companycode:"000001",
      };
      print(code);
      final confirmdata=await db.collection("items").doc(code).set(updataData);
print("Save");

     // print("Successfully${sid}");

    }on FirebaseException catch (e){
      print(e.message);
    }
  }
  updateitem(String item,String sellingprice,String costprice,String wholesaleprice,String quantity,String description,String code,String category,String photourl)async{
    final date=DateTime.timestamp();
    String staff="JohnKolog";
    try{
      final updataData={
         Dbfields.item:item,
         Dbfields.costprice:costprice,
         Dbfields.sellingprice:sellingprice,
         Dbfields.wholesaleprice:wholesaleprice,
         Dbfields.quantity:quantity,
         Dbfields.description:description,
         Dbfields.code:code,
         Dbfields.category:category,
         Dbfields.staff:staff,
         Dbfields.date:date,
         Dbfields.itemurl:photourl,
         Dbfields.companyemail:"info@kologsoft.com",
         Dbfields.companycode:"000001",
      };
      final confirmdata=await db.collection("items").doc(code).update(updataData);
      print("Updated");
     // print("Successfully${sid}");
    }on FirebaseException catch (e){
      print(e.message);
    }
  }
  logindata(String email)async{
    try{
      final dataexist= await db.collection(StaffData.db_user).doc(email).get();
      phone=dataexist[StaffData.phone];
      name=dataexist[StaffData.name];
      datas();
      Cipher cipher = Cipher(secretKey: mykeys);
      String encryptTxt = cipher.xorEncode(accesslevel);
    }on FirebaseException catch(e){
      errortxt=e.message!;
    }
    notifyListeners();
  }
  datas()async{
    try{
      final dbdata=await db.collection("keys").doc("1").get();
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      mykeys=dbdata['key'];
    }catch(e){
      print(e);
    }

    notifyListeners();
  }
  login(String email,String password,BuildContext context)async{
    try{
     // datas();
      Cipher cipher = Cipher(secretKey: mykeys);
      final dataexist= await db.collection(StaffData.db_user).doc(email).get();
      if(dataexist.exists)
      {
        String dbAccesslevel=dataexist[StaffData.accesslevel];
        String name=dataexist[StaffData.name];
        accesslevel=dbAccesslevel;
        phone=dataexist[StaffData.phone];
        name=dataexist[StaffData.name];
        int loginstatus=dataexist[StaffData.loginstatus];
        if(loginstatus==1)
        {
          await auth.signInWithEmailAndPassword(email: email, password: password);
          await auth.currentUser!.updateDisplayName(name);
          successtxt=1;
          String encryptTxt = cipher.xorEncode(accesslevel);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("level",encryptTxt);
        }
        else
        {
          await auth.createUserWithEmailAndPassword(email: email, password: password);
          await auth.currentUser!.updateDisplayName(name);
          final update=await db.collection(StaffData.db_user).doc(email).update({StaffData.loginstatus:1});
          successtxt=1;
          String encryptTxt = cipher.xorEncode(accesslevel);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("level",encryptTxt);
          // print("New account");
        }

        // Navigator.pushNamedAndRemoveUntil(context, Routes.dashboard, (Route<dynamic> route) => false);
        // String name=dataexist[0];
      }
      else
      {
        successtxt=2;
        errortxt="Account Not Found";
      }
      //print("Login Successfully");
    }on FirebaseException catch(e){
      successtxt=2;
      errortxt=e.message!;
       print(e.message);
    }

  }
  logout(BuildContext context)async{
    await auth.signOut();
    final SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.remove("level");
    Navigator.pushReplacementNamed(context, Routes.login);
  }
  createaccount(String phone,String name,String email,String password,String accesslevel)async{
    try{
      datas();
      Cipher cipher = Cipher(secretKey: mykeys);
      String finalpassword=cipher.xorEncode(password);
      String finalaccesslevel=cipher.xorEncode(accesslevel);
      final userdata={
        StaffData.phone:phone,
        StaffData.name:name,
        StaffData.email:email,
        StaffData.accesslevel:accesslevel,
        StaffData.loginstatus:0,
        "tid":tid_txt
      };
      //await auth.createUserWithEmailAndPassword(email: email, password: password);
      await db.collection(StaffData.db_user).doc(email).set(userdata);
      successtxt=1;
      print("Account Created Successfully");

    }on FirebaseException catch(e){
      successtxt=2;
      errortxt=e.message!;
      print(e.message);

    }


  }


  checklogin()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? level = prefs.getString('level');
    await datas();
    Cipher cipher = await Cipher(secretKey: mykeys);
    String encryptTxt =await  cipher.xorDecode(level!);
    accesslevel=encryptTxt;
  }

}