import 'dart:collection';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seller/pages/od.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maps_launcher/maps_launcher.dart';
class orders extends StatefulWidget {
  final l;
  orders(this.l);
  @override
  _ordersState createState() => _ordersState();
}
FirebaseUser user;
class _ordersState extends State<orders> {
  List<EachOrder> allorders = [];
  @override
  void initState() {
    getOrders();
    super.initState();
  }
  GoogleMapController mapController;
  final Set<Polyline> poly = {};
  List<LatLng> latlng = List();
  static const String map_api= "AIzaSyCcH5Qy8dTYdMNvQ8ufSzW9wpHY2qGhFK4";
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    void launchMap(String la,String lo) async{
      var url = "http://maps.google.com/maps?q="+la+","+lo;
      if (await canLaunch(url)) {
        print("Can launch");

        await launch(url);
      } else {
        print("Could not launch");
        throw 'Could not launch Maps';
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title:Text("Orders"),
      ),
      body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
              children: allorders
                  .map(
                    (p) =>
                new Card(
                  child: SingleChildScrollView(
                      child:InkWell(
                        child: ListTile(

                          leading:
                          new Image.network("https://duckhawk.in/icon.jpeg"),

                          title:new Text("Address : "+p.add,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                          subtitle: new Column(
                            children: <Widget>[
                              new Container(
                                alignment: Alignment.topLeft,

                                child: Padding(
                                    padding: EdgeInsets.all(8.0),

                                    child:new Text("Total : ₹"+p.total,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Name : "+p.n,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Contact : "+p.pn,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Time : "+p.time,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),


                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: new RaisedButton(
                                        child: Text("Location"),
                                        onPressed: (){
                                          launchMap(p.l['lat'].toString(), p.l['lng'].toString());
                                        },
                                    ),

                                    //http://maps.google.com/maps?q=24.197611,120.780512
                                    //child:new Text("Loc : "+p.l['lat'].toString()+" "+p.l['lng'].toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)



                                    //child:new Text("Latitudes : "+p.l['lat'].toString()+" "+p.l['lng'].toString(),style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),


                            ],
                          ),

                        ),
                        onTap: (){
                          print("key is :");
                          print(sk);
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => new o_details(p.k,widget.l)));



                        },
                      )
                  ),
                ),

              )
                  .toList()))

    );

  }
List sk=[];
  void getOrders() async{
    LinkedHashMap<String, dynamic> data,data3,d;
    pkeys.clear();
    List p=[];
    sk.clear();
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    //https://duckhawk-1699a.firebaseio.com/Seller/Bhubaneswar/T7n6FiUoxsbQ4JWWqFneaUXCKLZ2/Orders.json
    String link = "https://duckhawk-1699a.firebaseio.com/Seller/" + widget.l.toString() + "/" + user.uid + "/Orders.json";
    final resource = await http.get(link);
    print("link is :");
    //print(resource.body);
    if(resource.body!=null){
      if(resource.statusCode==200)
        {
          LinkedHashMap<String, dynamic> data = jsonDecode(resource.body);
          print(data.keys.toList());
          List keys=data.keys.toList();
          sk.add(data.keys);
          int h=0;
          int l=keys.length;
          //https://duckhawk-1699a.firebaseio.com/Orders/Bhubaneswar/-M8GlU7Egj0jKeg4aqao
          while(h<l)
            {
              String link = "https://duckhawk-1699a.firebaseio.com/Orders/" + widget.l.toString() + "/" + keys[h]+".json";
              //print(link);
              final resource = await http.get(link);
              //print(resource.body);
              if(resource.body!=null){
                if(resource.statusCode==200){
                   data = jsonDecode(resource.body);
                  //print(data['time']);
                   EachOrder eachOrder = new EachOrder(
                       data["Address"],
                       data["buyer"],
                       data["time"],
                       data["total"].toString(),
                       data["Products"],
                       data["location"],
                       data["Name"],
                       data["Phone_Number"].toString(),
                       keys[h]
                   );
                   /*

                  //print("ufgiujwhw");
                  //print(eachOrder.p.values);
                  String l="https://duckhawk-1699a.firebaseio.com/Orders/Bhubaneswar/"+keys[h]+"/Products.json";
                  //print(l);
                  final r= await http.get(l);
                  //print(r.body);
                  if(r.body!=null){
                    if(r.statusCode==200)
                      {
                         data3 = jsonDecode(r.body);
                        //print("...........................");
                        //print(data3.keys.toList());
                        List p=data3.keys.toList();
                        //print(p);
                        int x=0;
                        while(x<p.length)
                          {
                            String li="https://duckhawk-1699a.firebaseio.com/Orders/Bhubaneswar/"+keys[h]+"/Products/"+p[x]+".json";
                            //print(li);
                            final re=await http.get(li);
                            if(re.body!=null){
                              if(re.statusCode==200){
                                d =jsonDecode(re.body);
                                //print("@####");
                                //print(d["ProductId"]);
                              }
                            }
                            x++;
                          }


                        //pkeys.add(data3);
                        //String li="https://duckhawk-1699a.firebaseio.com/Orders/Bhubaneswar/"+keys[h]+"/Products/"+.json"

                      }
                  }*/
                   /*EachOrder eachOrder = new EachOrder(
                       data["Address"],
                       data["buyer"],
                       data["time"],
                       data["total"].toString(),
                       data["Products"],
                       data["location"],
                       data["Name"],
                       data["Phone_Number"].toString(),
                       d["price"].toString(),
                       d["quantity"].toString(),
                       keys[h]
                   );
                  print("h...............");
                  print(keys[h]);
                  print(eachOrder.p.keys.toList());*/

                   setState(() {
                     allorders.add(eachOrder);
                   });
                }


              }



              h++;
            }

        }
    }

  }
}
class EachOrder {
  String add, buyer, time, total,n,pn,k;
  var p,l;
  EachOrder(this.add, this.buyer, this.time, this.total,this.p,this.l,this.n,this.pn,this.k);
}
List pkeys=[];