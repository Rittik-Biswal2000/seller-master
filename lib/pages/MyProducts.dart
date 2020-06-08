import 'dart:collection';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class myp extends StatefulWidget {
  final l;
  myp(this.l);
  @override
  _mypState createState() => _mypState();
}
class EachProduct {
  String name, des, q, img, p, id,cat;
  EachProduct(this.name, this.des, this.q, this.img, this.p, this.id, this.cat);
}
class _mypState extends State<myp> {
  List<EachProduct> allProduct = [];
  @override
  void initState() {
    getproductdetailsNew();
    // TODO: implement initState

    super.initState();
  }

  getproductdetailsNew() async {
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    String link = "https://duckhawk-1699a.firebaseio.com/Seller/" +
        widget.l +
        "/" +
        user.uid +
        "/products.json";
    final resource = await http.get(link);
    print("link is :");

    print(link);
    print(resource.body);
    var pro = resource.body;
    //print(pro);
    if (pro.toString() == null) {
      print("hi");
    }

    if (resource.body != null) {
      if (resource.statusCode == 200) {
        LinkedHashMap<String, dynamic> data1 = jsonDecode(resource.body);
        //print("length is :");
        //print(data1.length);
        if (data1 != null) {
          List k = data1.keys.toList();

          print(k);
          List d = data1.values.toList();

          int h = 0;
          var len1 = d.length;
          while (h < d.length) {
            LinkedHashMap<String, dynamic> data2 =
            jsonDecode(resource.body)[k[h]];
            //List x=data2.values.toList();
            //print(data2["cat"]);
            //prod_id2.add(k[h]);
            //prod_cat2.add(data2["cat"]);
            //badd


            String link2 = "https://duckhawk-1699a.firebaseio.com/Products/" + widget.l + "/" + data2["cat"] + "/" + k[h] + ".json";
            final resource3 = await http.get(link2);
            if (resource3.statusCode == 200) {
              LinkedHashMap<String, dynamic> data4 = jsonDecode(resource3.body);
              // print("city is:");

              EachProduct eachProduct = new EachProduct(
                  data4["ProductName"],
                  data4["ProductDesc"],
                  data4["stock"],
                  data4["Product_Image"],
                  data4["price"],
                  k[h],
                  data2["cat"]);

              setState(() {
                allProduct.add(eachProduct);
              });


            }
            h++;
          }
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Products"),
      ),
      body:
      SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          child: Column(
              children: allProduct
                  .map(
                    (p) =>
                new Card(
                  child: SingleChildScrollView(
                        child: ListTile(

                          leading:
                          new Image.network((p.img==null)?"https://duckhawk.in/icon.jpeg":p.img,width:100.0,height:400.0),

                          title:new Text(p.name),
                          subtitle: new Column(
                            children: <Widget>[
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),

                                    child:new Text("Price : ₹"+p.p,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Quantity : "+p.q,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              new Container(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(8.0),



                                    child:new Text("Product Description : "+p.des,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                              ),
                              /*new Row(
                            children: <Widget>[
                              new FlatButton(onPressed: (){
                                //createAlertDialog(context, name.split(': ')[1], imgurl, price.split(': ')[1]);





                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => new item_info(prod_id2[index],imgurl1[index],name1[index],price1[index],description1[index],quantity1[index])));

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
                          ),*/

                            ],
                          ),

                        ),


                  ),
                ),
                /*Card(
                  elevation: 10,
                  borderOnForeground: true,
                  child: Column(
                    mainAxisAlignment:MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.network(p.img),
                      Text("Sl NO . " +
                          (allProduct.indexOf(p)+1).toString() +
                          " "),
                      Text(p.name),
                      Text(p.des),
                      Text(p.p),
                      Text(p.q),
                      Text(p.id)
                    ],
                  ),
                ),*/
              )
                  .toList())),
    );
  }
}
