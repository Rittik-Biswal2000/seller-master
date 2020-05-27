import 'package:flutter/material.dart';
import 'package:seller/pages/edittable.dart';
import 'package:seller/src/welcomPage.dart';

import 'MyProducts.dart';
class item_info extends StatefulWidget {
  String p_cat,p_id,n,i,p,q,d;
  item_info(
      this.p_cat,this.p_id,this.n,this.i,this.p,this.q);
  @override
  _item_infoState createState() => _item_infoState();
}
String pri,quant;
bool _isEditingText = false;
TextEditingController _editingController;
String initialText=ip;
bool _isEditingText1 = false;
TextEditingController _editingController1;
String initialText1=iq;
class _item_infoState extends State<item_info> {
  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _editingController1 = TextEditingController(text: initialText1);
  }
  @override
  void dispose() {
    _editingController.dispose();
    _editingController1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("in item info page");
    print(ip);
    print(iq);
    return Scaffold(
      appBar: AppBar(
        title: new Text(widget.n),
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child:GridTile(
              child: Container(
                color: Colors.white,
                child:Image.network(widget.i)
              ),
            )
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new Text(widget.n.toString()),
                ),

              ),
            ],


          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new Text("Product Price :"+widget.p),
                ),

              ),
            ],
          ),


          /*new Row(
            children: <Widget>[
              Container(
                child: _editTitleTextField(),
              ),
            ],
          ),*/
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new Text("Product quantity :"+widget.q),
                ),

              ),
            ],
          ),
          /*Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: _editTitleTextField1(),
                ),

              ),
            ],
          ),*/
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              /*Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new FlatButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new edit()));

                  },
                      splashColor: Colors.greenAccent,
                      color: Colors.redAccent,
                      child: Text("Update",style: new TextStyle(fontSize: 20.0, color: Colors.white),))
                ),

              ),*/
            ],
          ),

        ],
      )
    );


  }




}


