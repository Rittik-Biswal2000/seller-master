//import 'dart:html';

import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seller/main.dart';
import 'package:seller/pages/MyProducts.dart';
import 'package:seller/pages/register.dart';
import 'package:seller/src/loginPage.dart';
import 'package:seller/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seller/pages/login_page.dart';
import 'package:seller/src/signup.dart';
import 'package:http/http.dart' as http;

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}
FirebaseUser user;
List seller=[];
List imgurl=[];
List quantity=[];
List price=[];
List name=[];
List description=[];
List l=[];
List prod_id=[];
List prod_cat=[];
var len;

class _WelcomePageState extends State<WelcomePage> {

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => lp()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xff104670).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xff104670)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

/*  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Quick login with Touch ID',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
            SizedBox(
              height: 20,
            ),
            Icon(Icons.fingerprint, size: 90, color: Colors.white),
            SizedBox(
              height: 20,
            ),
            Text(
              'Touch ID',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ));
  }*/

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'DuckHawk',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [/*
            TextSpan(
              text: 'kHa',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'wk',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          */]),
    );
  }
  @override
  void initState() {
    getuser();
    // TODO: implement initState
   // getproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff104670), Color(0xff104672)])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _title(),
              SizedBox(
                height: 80,
              ),
              _submitButton(),
              SizedBox(
                height: 20,
              ),
              _signUpButton(),
              SizedBox(
                height: 20,
              ),
              //_label()
            ],
          ),
        ),
      ),
    );
  }

   getuser() async{

    FirebaseUser user=await FirebaseAuth.instance.currentUser();

    if(user.uid!=null)
      {
        Fluttertoast.showToast(
            msg: "Welcome "+user.email,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            //backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 8.0
        );

      }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(null)),
    );


   }
}


final Geolocator geolocator = Geolocator()
  ..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress,badd="loading";
String curlat,curlon;
getproducts() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  user = await _auth.currentUser();
  await getdata();
  print(user.uid);

  print("bye");






}
getdata()async {
  String scity;
  imgurl.clear();
  quantity.clear();
  name.clear();
  price.clear();
  List p=[];
  prod_id.clear();
  prod_cat.clear();
  String link="https://duckhawk-1699a.firebaseio.com/ApplicationForSeller/"+user.uid+".json";
  final resource = await http.get(link);
  if(resource.statusCode == 200)
  {
    LinkedHashMap<String,dynamic>data=jsonDecode(resource.body);
    print("city is:");
    print(data["City"]);
    scity=data["City"];

  }
  String link1="https://duckhawk-1699a.firebaseio.com/Seller/"+scity+"/"+user.uid+"/"+"products.json";
  final resource1 = await http.get(link1);
  if(resource1.statusCode==200)
    {
      LinkedHashMap<String,dynamic>data1=jsonDecode(resource1.body);
      List k=data1.keys.toList();
      //print(k);
      List d=data1.values.toList();
      //print(d);
      int h=0;
      len=d.length;
      while(h<d.length){
        LinkedHashMap<String, dynamic> data2 = jsonDecode(resource1.body)[k[h]];
        //List x=data2.values.toList();
        //print(data2["cat"]);
        prod_id.add(k[h]);
        prod_cat.add(data2["cat"]);

        String link2="https://duckhawk-1699a.firebaseio.com/Products/"+scity+"/"+data2["cat"]+"/"+k[h]+".json";
        print(link2);
        final resource3 = await http.get(link2);
        if(resource3.statusCode == 200)
        {
          LinkedHashMap<String,dynamic>data4=jsonDecode(resource3.body);
         // print("city is:");
          imgurl.add(data4["imgurl"]);
          quantity.add(data4["quantity"]);
          price.add(data4["price"]);
          name.add(data4["name"]);



        }
        h++;

      }


    }

 // var o= await _getCurrentLocation();
  //print("badd is :"+'${o}');
  /*
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'Seller').child('Cuttack').child(user.uid).child('products');
  await ref.once().then((DataSnapshot snap)  async {
    var keys = snap.key;
    var data = snap.value;
    /*
    print("Keys are");
    print(keys);
    print(snap.toString().length);*/
    //print(data.toString().split('}, ')[1]);
    print(snap.value);
    var n = snap.value
        .toString()
        .split('}, ');
    len = n.length;
    //print(n[1].split(': {').toString().split(': ').toString().split(',')[2]);
    //var x=n[0].split(': {')[0].length;
    //var p=n[0].split(': {')[0];
    //prod_id.add(n[0].split(': {')[0].substring(1,x));
    for (int i = 0; i < len; i++) {
      if (i == 0) {
        var x = n[0].split(': {')[0].length;
        var p = n[0].split(': {')[0];
        prod_id.add(n[0].split(': {')[0].substring(1, x));
        prod_cat.add(
            n[0].split(': {').toString().split(': ').toString().split(
                ',')[2]);
      }
      else {
        prod_id.add(n[i].toString().split(':')[0]);
        prod_cat.add(
            n[i].split(': {').toString().split(': ').toString().split(
                ',')[2]);
      }
    }
    for (int i = 0; i < len; i++) {
      var n = prod_cat[i]
          .toString()
          .length;
      var str = prod_cat[i].toString().substring(1, n);

      DatabaseReference ref = FirebaseDatabase.instance.reference().child(
          'Products').child('Cuttack').child(str).child(prod_id[i]);
      await ref.once().then((DataSnapshot snap) {
        var keys = snap.key;
        var data = snap.value;
        print("For products :");
        //print(keys);
        //print(data);
        imgurl.add(data.toString().split(',')[1].split(': ')[1]);
        quantity.add(data.toString().split(',')[2].split(': ')[1]);
        price.add(data.toString().split(',')[3].split(': ')[1]);
        name.add(data.toString().split(',')[4].split(': ')[1]);
      });
    }
  });*/
  //return p;
}
Future<String>_getCurrentLocation() async{
  var p;
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;

  await geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) async {
    _currentPosition = position;
    p=await _getAddressFromLatLng();
    /*setState(() {

    });*/
    //
  }).catchError((e) {
    print(e);
  });

  //print("p is :"+'${p}');
  return p;
}

Future<String>_getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    curlat = _currentPosition.latitude.toString();
    curlon = _currentPosition.longitude.toString();

    Placemark place = p[0];
    //print("in this page");
    _currentAddress="${place.locality}";
    //print(place.locality);

    /*setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });*/
    badd = _currentAddress;
    // print("Current location is :"+badd);
  } catch (e) {
    print(e);
  }

  var x=badd;
  // print("location is : "+x);
  return x;
}