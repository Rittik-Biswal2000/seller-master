import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seller/pages/orders.dart';
import 'package:http/http.dart' as http;
class o_details extends StatefulWidget {
  String k;
  final li;

  o_details(this.k,this.li);
    @override
  _o_detailsState createState() => _o_detailsState();
}

class _o_detailsState extends State<o_details> {
  List<Pdetails> allP = [];
  @override
  void initState() {
    // TODO: implement initState
    getpd(widget.k);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("................0000");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff104670),
        title: new Text("Products"),
      ),
        body:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            child: Column(
                children: allP
                    .map(
                      (q) =>
                  new Card(
                    child: SingleChildScrollView(
                        child:InkWell(
                          child: ListTile(

                            leading:
                            new Image.network(q.img==null?"https://duckhawk.in/icon.jpeg":q.img),

                            title:new Text("Name : "+q.name,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
                            subtitle: new Column(
                              children: <Widget>[
                                new Container(
                                  alignment: Alignment.topLeft,

                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),

                                      child:new Text("Total : ₹"+q.total,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  /*alignment: Alignment.topLeft,
                          child:new Text("Price is : ₹"+prod_price[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)*/
                                ),
                                new Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),



                                      child:new Text("Quantity : "+q.quantity,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),
                                new Container(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                      padding: EdgeInsets.all(8.0),



                                      child:new Text("Price/Unit : "+q.price,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                  ),
                                  //child:new Text("Quantity : "+item_units[index],style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),)
                                ),







                              ],
                            ),

                          ),
                          onTap: (){




                          },
                        )
                    ),
                  ),

                )
                    .toList()))

    );
  }

  void getpd(String k) async {
    LinkedHashMap<String, dynamic> data, data3, d;

    String link = "https://duckhawk-1699a.firebaseio.com/Orders/" +
        widget.li.toString() + "/" + k + ".json";
    //print(link);
    final resource = await http.get(link);
    //print(resource.body);
    if (resource.body != null) {
      if (resource.statusCode == 200) {
        data = jsonDecode(resource.body);
        //print(data['time']);

        print("ufgiujwhw");
        //print(eachOrder.p.values);
        String l = "https://duckhawk-1699a.firebaseio.com/Orders/" +widget.li.toString()+"/"+
            k + "/Products.json";
        //print(l);
        final r = await http.get(l);
        //print(r.body);
        if (r.body != null) {
          if (r.statusCode == 200) {
            data3 = jsonDecode(r.body);
            //print("...........................");
            //print(data3.keys.toList());
            List p = data3.keys.toList();
            //print(p);
            int x = 0;
            while (x < p.length) {
              String li = "https://duckhawk-1699a.firebaseio.com/Orders/" +widget.li.toString()+"/"+
                  k + "/Products/" + p[x] + ".json";
              //print(li);
              final re = await http.get(li);
              if (re.body != null) {
                if (re.statusCode == 200) {
                  d = jsonDecode(re.body);
                  //print("@####");
                  print(d["price"]);
                  print(d["quantity"]);
                  String lin="https://duckhawk-1699a.firebaseio.com/Products/"+widget.li.toString()+"/"+d["category"]+"/"+d["ProductId"]+".json";
                  final r=await http.get(lin);
                  if(r.body!=null){
                    if(r.statusCode==200){
                      data=jsonDecode(r.body);
                          print(data["ProductName"]);
                          print(data["Product_Image"]);
                          print(data["price"]);
                    }
                  }

                }
                Pdetails eachP = new Pdetails(
                    d["price"].toString(),
                    d["quantity"].toString(),
                  data["ProductName"],
                  data["Product_Image"],
                  data["price"].toString()

                );
                setState(() {
                  allP.add(eachP);
                });
                print("name is :");
                print(eachP.name);
              }
              x++;
            }


            //pkeys.add(data3);
            //String li="https://duckhawk-1699a.firebaseio.com/Orders/Bhubaneswar/"+keys[h]+"/Products/"+.json"

          }
        }
      }
    }
  }
}
class Pdetails {
  String img, name, price, total,quantity;
  var p,l;
  Pdetails(this.total, this.quantity, this.name, this.img,this.price);
}