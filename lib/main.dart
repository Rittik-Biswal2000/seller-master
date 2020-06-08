
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seller/entry.dart';
import 'package:seller/pages/add_product.dart';
import 'package:seller/pages/MyProducts.dart';
import 'package:seller/pages/location.dart';
import 'package:seller/pages/mloc.dart';
import 'package:seller/pages/orders.dart';
import 'package:seller/pages/register.dart';
import 'package:seller/pages/sellerlogin.dart';
import 'package:seller/src/welcomPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import './pages/login_page.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
FirebaseUser user;

/*void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,



      home: MyApp()));
}*/
String badd="Loading";
String x;
final Geolocator geolocator = Geolocator()
  ..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress;
String curlat1,curlon1;
class HomePage extends StatefulWidget {

  final add;
  HomePage(this.add);

  @override
  _HomePageState createState() => _HomePageState();
}
Future<void> currentUser() async {
  user = await FirebaseAuth.instance.currentUser();
  print(user.email);
  print(user.uid);
  print(user.displayName);
  return user;
}
DateTime backbuttonpressedTime;
class _HomePageState extends State<HomePage> {

  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  String u;
  String name = "hello";
  String s = "Login to view Status";
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  ProgressDialog pr;

  String _value = '';

  void _onClick(String value) => setState(() => _value = value);

  @override
  void initState() {
    super.initState();
    //getproducts();
    //test();
    _getculoc();
    _getCurrentUser();
    print("Here outside async");
  }

  _getCurrentUser() async {
    _auth = FirebaseAuth.instance;
    mCurrentUser = await _auth.currentUser();
    print("Hello" + mCurrentUser.email.toString());
    name = mCurrentUser.email.toString();
    u = mCurrentUser.uid.toString();
    if (mCurrentUser.uid.toString() != null) {
      s = "Logged in";
    }
  }

  _signOut() async {
    await _auth.signOut();
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }


  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );


    return Scaffold(
        backgroundColor: Color(0xff03a9fa),

        appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          automaticallyImplyLeading: false,
          title: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: <Widget>[
                    Row(
                      children:
                      <Widget>[
                        new IconButton(
                          icon: new Icon(Icons.place),
                          onPressed: () async{
                            await _getCurrentLocation();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>new mloc()));

                            currentUser();
                          },
                        ),
                        SingleChildScrollView(
                          child: Container(
                              child: new FlatButton(onPressed: () async{
                                await _getCurrentLocation();
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => new mloc()));
                              }, child: Text(widget.add == null
                                  ? badd
                                  : widget.add   , style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white),))),)
                        //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),


                      ],
                    ),
                  ],

                ),
              )
          ),
          //leading:new Text("hi"),


        ),


        /*endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            InkWell(
              child: new UserAccountsDrawerHeader(


                accountName: Text(name),
                accountEmail: null,
                currentAccountPicture: GestureDetector(
                    child: new CircleAvatar(
                      //backgroundImage: ImageProvider("images/men-jeans@2x.png"),
                      backgroundColor: Colors.grey,
                    )),
                decoration: new BoxDecoration(color: Color(0xff104670)),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
              },
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Men'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(title: Text('Women')),
            ),
            InkWell(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new electronics()));
              },
              child: ListTile(title: Text('Electronics')),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(title: Text('Sports')),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(title: Text('Books')),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(title: Text('Home & Furniture')),
            ),
            InkWell(
              onTap: () {},
              child: ListTile(title: Text('Beauty & Personal Care')),
            ),
            Divider(),
            Container(
                color: Color(0xffaaaaaa),
                child: new Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('My Orders')),
                    ),
                    InkWell(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
                      },
                      child: ListTile(title: Text('My Cart')),
                    ),
                    InkWell(
                      onTap: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
                      },
                      child: ListTile(title: Text('Account')),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Notifications')),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Budget')),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Share')),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('Settings')),
                    ),
                    InkWell(
                      onTap: () {
                        _signOut();
                        name="hi";
                      },
                      child: ListTile(title: Text('LOGOUT')),
                    ),
                    InkWell(
                      onTap: () {},
                      child: ListTile(title: Text('HELP')),
                    )
                  ],
                )),
          ],
        ),
      ),*/
        body: WillPopScope(
          onWillPop: _onBackPressed,
          child: new ListView(

            children: <Widget>[
              new Image.asset('images/16x9@2x.png'),
              new Padding(padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0)),
              new Container(/*
                child:
                new OutlineButton(/*
                    child: new Text("SELLER LOGIN"),
                    onPressed: (u==null)?(){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>new SellerLogin()));

                    }:null,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                */),
             */),


              new Padding(padding: EdgeInsets.all(30.0)),

              new Text(s, textAlign: TextAlign.center,
                style: TextStyle(color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0),),
              new Padding(padding: EdgeInsets.all(10.0)),
              /*Container(
                child: new OutlineButton(
                    child: new Text("APPLY FOR SELLER"),
                    onPressed: (u!=null)?(){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>new SellerRegister()));
                    }:null,
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                ),
              ),*/
              Container(
                child: new OutlineButton(
                    child: new Text("Add Products"),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => new AddProduct(null)));
                    } ,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))
                ),

              ),
              Container(
                child: new OutlineButton(
                    child: new Text("My Products"),
                    onPressed:  () async {
                      pr.show();
                      await getproducts();
                      pr.hide();
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => new mp()));
                    } ,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))
                ),

              ),
              Container(
                child: new OutlineButton(
                    child: new Text("Orders"),
                    onPressed:  () async {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => new orders(widget.add)));
                    } ,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))
                ),

              ),
              Container(
                child: new OutlineButton(
                    child: new Text("Logout"),
                    onPressed: (u != null) ? () {
                      _signOut();

                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => new HomePage(null)));
                    } : null,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))
                ),
              ),
            ],
          ),
        )

    );
  }

  void test() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    _firestore
        .collection("users").where("uid", isEqualTo: user.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => x = '${f.data}');
      print(x.split(',')[2].split(': ')[1]);
      x = x.split(',')[2].split(': ')[1];
      print(x);

      //print(s('isSeller'));
      /*if(s.split(',')[2].split(': ')[1]=='true'){
        print("true");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new AddProduct()));
      }*/

    });
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      var clat = _currentPosition.latitude.toString();
      var clon = _currentPosition.longitude.toString();

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });
      badd = _currentAddress;
    } catch (e) {
      print(e);
    }
  }


  Future<bool> _onBackPressed() {


    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to exit an App'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            )
          ],
        );
      },
    ) ?? false;
  }


}
_getculoc() async{
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
  //return p;
}

Future<String>_getAddressFromLatLng() async {
  try {
    List<Placemark> p = await geolocator.placemarkFromCoordinates(
        _currentPosition.latitude, _currentPosition.longitude);
    curlat1 = _currentPosition.latitude.toString();
    curlon1 = _currentPosition.longitude.toString();

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