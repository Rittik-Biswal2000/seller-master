import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:seller/pages/MyProducts.dart';
import 'package:seller/pages/add_product.dart';

class edit extends StatefulWidget {
  @override
  _editState createState() => _editState();
}
String n,p;
bool _isEditingText = false;
TextEditingController _editingController;
String initialText = ip;
bool _isEditingText1 = false;
TextEditingController _editingController1;
String initialText1 = iq;
class _editState extends State<edit> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Details"),
      ),
      body: Container(
        child: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                    child: new Text("Price")
                ),
              ],
            ),

            new Column(
              children: <Widget>[
                Container(
                  child: _editTitleTextField(),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                Container(
                    child: new Text("Quantity")
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                Container(
                  child: _editTitleTextField2(),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                RaisedButton(onPressed: ()async{
                  pr.show();
                  await updatedata();
                  //await getuac();
                  pr.hide();
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>new acc1()));
                },
                  child: new Text("Update"),)
              ],
            ),



          ],
        ),

        //child: _editTitleTextField(),
      ),
    );
  }
  Widget _editTitleTextField() {
    if (_isEditingText)
      return Container(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              n=newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
  Widget _editTitleTextField2() {
    if (_isEditingText1)
      return Container(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText1 = newValue;
              p=newValue;
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
          initialText1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
  Widget _editTitleTextField3() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }
  Widget _editTitleTextField4() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },
        child: Text(
          initialText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        ));
  }

  updatedata() async{
    print(icat);
    print(iid);
   await  FirebaseDatabase.instance.reference().child('Products').child('Cuttack').child(icat).child(iid).update({
      'price':n,
      'quantity':p,
    });


  }

}

