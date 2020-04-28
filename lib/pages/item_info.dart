import 'package:flutter/material.dart';
import 'package:seller/src/welcomPage.dart';
class item_info extends StatefulWidget {
  String p_cat,p_id,n,i,p,q,d;
  item_info(
      this.p_cat,this.p_id,this.n,this.i,this.p,this.q);
  @override
  _item_infoState createState() => _item_infoState();
}
bool _isEditingText1 = false;
TextEditingController _editingController1;
String initialText1="";
bool _isEditingText2 = false;
TextEditingController _editingController2;
//String initialText2="Edit Price";
bool _isEditingText3 = false;
TextEditingController _editingController3;
//String initialText3="Edit Quantity";
class _item_infoState extends State<item_info> {
  @override
  void initState() {
    super.initState();
    _editingController1 = TextEditingController(text: widget.n);
  }
  @override
  void dispose() {
    _editingController1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    print("in item info page");
    print(widget.p_cat);
    print(widget.p_id);
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
                    child: _isEditingText1==true?
                    new TextField(
                      onSubmitted: (newValue){
                        setState(() {
                          initialText1 = newValue;
                          _isEditingText1 =false;
                        });
                      },
                      autofocus: true,
                      controller: _editingController1,
                    ),
                    child: InkWell(
                      onTap: () {
    setState(() {
    _isEditingText1 = true;
    });
    },
      child: Text(
        initialText1==""?widget.n:initialText1,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
      ),);

                        :null,
                    //child: new Text(widget.n),


                  ),


              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new Text("Product Price :"+widget.p.toString()),
                ),

              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new Text("Product quantity :"+widget.q.toString()),
                ),

              ),
            ],
          ),
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              Padding(
                padding: EdgeInsets.all(16.0),
                child: new Container(
                  child: new FlatButton(onPressed: (){

                  },
                      splashColor: Colors.greenAccent,
                      color: Colors.redAccent,
                      child: Text("Update",style: new TextStyle(fontSize: 20.0, color: Colors.white),))
                ),

              ),
            ],
          ),

        ],
      )
    );


  }
  Widget _editTitleTextField() {
    if (_isEditingText1)
      return Container(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText1 = newValue;
              _isEditingText1 =false;
            });
          },
          autofocus: true,
          controller: _editingController1,
        ),
      );
    return InkWell(
        onTap: () {
      setState(() {
        _isEditingText1 = true;
      });
    },
    child: Text(
    initialText1==""?widget.n:initialText1,
    style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    ),
    ),);
  }


}


