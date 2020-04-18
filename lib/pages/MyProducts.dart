import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:seller/pages/item_info.dart';
import 'package:seller/pages/login_page.dart';
import 'package:seller/src/welcomPage.dart';
import 'package:progress_dialog/progress_dialog.dart';
class mp extends StatefulWidget {
  @override
  _mpState createState() => _mpState();
}
bool _isEditingText = false;
TextEditingController _editingController;
FirebaseUser user;
ProgressDialog pr;
String qu;
/*
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
  List p=[];
  var o= await _getCurrentLocation();
  print("badd is :"+'${o}');
  DatabaseReference ref = FirebaseDatabase.instance.reference().child(
      'Seller').child(o).child(user.uid).child('products');
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
          'Products').child(o).child(str).child(prod_id[i]);
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
  });
  //return p;
}*/

class _mpState extends State<mp> {
  @override
 void initState()  {
    // TODO: implement initState
    //getproducts();
    _editingController = TextEditingController(text: qu);



    super.initState();
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
    print(imgurl);
    print(name);
    print(price);
    print(quantity);

    //showdata();
    return Scaffold(
      appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          automaticallyImplyLeading: false,
          title: Text("My Products")
        //leading:new Text("hi"),


      ),
      body: Container(
        child: new ListView.builder(
          itemCount: len,
          itemBuilder: (BuildContext context,int index){
            print("name is : ");
            print(name[index]);
            qu=quantity[index];
            //total_price+=double.parse(prod_price[index])*double.parse(units[index]);
            //return new Text(item_name[index]);
            return new Card(
              child: SingleChildScrollView(
                  child:ListTile(

                    leading:InkWell(
                        onTap: (){
                        },
                        child:
                        new Image.network(imgurl[index],width:100.0,height:400.0)
                    ),
                    title:new Text(name[index]),
                    subtitle: new Column(
                      children: <Widget>[
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),

                              child:new Text("Price : ₹"+price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          /*alignment: Alignment.topLeft,
                        child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                        ),
                        new Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),



                              child:new Text("Quantity : "+quantity[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                          ),
                          //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                        ),
                        new Row(
                          children: <Widget>[
                            new FlatButton(onPressed: (){
                              //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);




                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => new item_info(prod_cat[index],prod_id[index],name[index],imgurl[index],price[index],quantity[index])));

                             // createAlertDialog(context,item_name[index],imageurl[index],prod_price[index],item_units[index],u[index].data["ProductId"]);
                            },
                                child:Text("Update")
                            ),
                            new FlatButton(
                                onPressed: (){

                                  //l[index].toString().split(': ')[1].split(',')[0]
                                 // firestore.collection('users').document(user.uid).collection('cart').document(u[index].data["ProductId"]).delete();


                                  //refreshList();
                                  //Navigator.pop(context, MaterialPageRoute(builder: (context)=>new LogoutOverlay()));
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));

                                }, child: Text("Remove")),

                          ],
                        ),
                      ],
                    ),

                  )
              ),
            );
          },



        ),

      ),
    );
  }

  showdata() async{
    await getproducts();
    print("name is : "+name[0]);
  }

}





/*Future<String>_getCurrentLocation() async{
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
  /*cr(){
    var str = Future.delayed(Duration(seconds: 4), () => 'rittik');
    return str;
  }*/


*/
    