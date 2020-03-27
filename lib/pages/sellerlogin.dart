

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seller/main.dart';
import 'package:seller/pages/add_product.dart';
String _email;
String _password;
class SellerLogin extends StatefulWidget {
  @override
  _SellerLoginState createState() => _SellerLoginState();
}
FirebaseUser user;
class _SellerLoginState extends State<SellerLogin> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
       /* appBar: new AppBar(
          backgroundColor: Color(0xff104670),
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
                          /*onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                          //_getCurrentLocation();
                          currentUser();
                        },*/
                        ),
                        SingleChildScrollView(
                          child: Container(
                              width: 200,
                              child: new FlatButton(onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new Lo()));
                              }, child: Text("hi", style: new TextStyle(
                                  fontSize: 15.0, color: Colors.white),))),)
                        //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),


                      ],
                    ),
                  ],

                ),
              )
          ),
          //leading:new Text("hi"),


        ),*/

        /*endDrawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              InkWell(
                child: new UserAccountsDrawerHeader(


                  accountName: Text("hi"),
                  accountEmail: null,
                  currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        //backgroundImage: ImageProvider("images/men-jeans@2x.png"),
                        backgroundColor: Colors.grey,
                      )),
                  decoration: new BoxDecoration(color: Color(0xff104670)),
                ),
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
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
                onTap: () {},
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
                        onTap: () {},
                        child: ListTile(title: Text('My Cart')),
                      ),
                      InkWell(
                        onTap: () {},
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
                          //_signOut();
                          //name="hi";
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
        body: new ListView(

          children: <Widget>[
            new Container(
              padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
              child: new Text("SELLER LOGIN", textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.yellow, fontWeight: FontWeight.bold),),
            ),
            Divider(),

            Container(
                padding: EdgeInsets.all(20.0),
                child: new Form(
                  //key: formKey,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: buildInputs() + buildSubmitButtons(),
                  ),
                )
            ),
          ],
        )
    );
  }

  List<Widget> buildInputs() {
    return [

      new TextFormField(
        decoration: new InputDecoration(labelText: 'User Id',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white)),
            labelStyle: TextStyle(color: Colors.yellow),
            contentPadding: EdgeInsets.all(10.0)),
        validator: (value) => value.isEmpty ? 'User Id can\'t be empty' : null,
        //onSaved: (value) => _email = value,
        onChanged: (value) {
          setState(() {
            _email = value;
          });
        },
      ),

      SizedBox(height: 20.0),

      new TextFormField(
        decoration: new InputDecoration(
            labelText: 'password',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.white)),
            labelStyle: TextStyle(color: Colors.yellow)),
        obscureText: true,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        //onSaved: (value) => _password = value,
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
      ),


    ];
  }


  List<Widget> buildSubmitButtons() {
    if (true) {
      return [
        new OutlineButton(
          child: new Text('Login', textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.yellow, fontWeight: FontWeight.bold),),
          onPressed:() {
            FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).then((user){
              Fluttertoast.showToast(
                  msg: "Logged in",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                 // backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 8.0
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(null)),
              );
            }).catchError((e) {});
          },
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
        ),
      ];
    }
  }
  void add() async{

    String s;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    _firestore
        .collection("users").where("uid", isEqualTo: user.uid)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => s = '${f.data}');
      print(s.split(',')[2].split(': '));
      //print(s('isSeller'));
      /*if(s.split(',')[2].split(': ')[1]=='true'){
        print("true");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>new AddProduct()));
      }*/

    });

  }
}

