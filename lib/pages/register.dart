import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:seller/src/loginPage.dart';

import 'location.dart';


class SellerRegister extends StatefulWidget {
  final add;
  var lat,lon;
  SellerRegister(this.add, this.lat,this.lon);


  @override
  _SellerRegisterState createState() => _SellerRegisterState();
}
String badd="Loading";
String x;
String curlat,curlon;
final Geolocator geolocator = Geolocator()
  ..forceAndroidLocationManager;
Position _currentPosition;
String _currentAddress;
FirebaseUser user;
FirebaseAuth _auth=FirebaseAuth.instance;
class _SellerRegisterState extends State<SellerRegister> {
  ProgressDialog pr;
  double percentage = 0.0;
  bool _isSeller=true;
  String path;
  String url,url1;
  //File file=new File(path);
  File file,file1;

  String _emailid;
  String _password;
  String _fileName;
  String _path = 'No File Choosen';
  String _shopname='';
  String _ownername='';
  String _phone;
  String _mname;
  String _mphone;
  String _gst;
  String _add1;
  String _add2;
  String _city;
  String _state;
  String _zip;
  String _radio;
  String _cat;
  Map<String, String> _paths;
  String _extension='pdf';
  bool _multiPick = false;
  bool _hasValidMime = true;
  FileType _pickingType=FileType.CUSTOM;

  String _fileName1;
  String _path1 = 'No File Choosen';
  Map<String, String> _paths1;
  String _extension1;
  bool _multiPick1 = false;
  bool _hasValidMime1 = true;
  FileType _pickingType1=FileType.IMAGE;
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int selectradio;



  @override
  void initState() {
    super.initState();
    getcurrentuser();
    //_getCurrentLocation();

    _controller.addListener(() => _extension = _controller.text);
    _controller1.addListener(() => _extension1 = _controller1.text);
    selectradio=0;
  }
  setselectedRadio(val)
  {
    setState(() {

      selectradio=val;
      if(selectradio==1){
        _radio='true';
      }
      else
        _radio='false';
    });
  }


  void _openFileExplorer() async {
    if (_pickingType != FileType.CUSTOM || _hasValidMime) {
      try {
        if (_multiPick) {
          _path = null;
          _paths = await FilePicker.getMultiFilePath(type: _pickingType, fileExtension: _extension);
        } else {
          _paths = null;
          _path = await FilePicker.getFilePath(type: _pickingType, fileExtension: _extension);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName = _path != null ? _path.split('/').last : _paths != null ? _paths.keys.toString() : '...';
      });
    }
  }

  void _openFileExplorer1() async {
    if (_pickingType1 != FileType.CUSTOM || _hasValidMime1) {
      try {
        if (_multiPick1) {
          _path1 = null;
          _paths1 = await FilePicker.getMultiFilePath(type: _pickingType1, fileExtension: _extension1);
        } else {
          _paths1 = null;
          _path1 = await FilePicker.getFilePath(type: _pickingType1, fileExtension: _extension1);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName1 = _path1 != null ? _path1.split('/').last : _paths1 != null ? _paths1.keys.toString() : '...';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, showLogs: true);
    pr.style(message: 'Please wait...');
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff104670),
          title: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: <Widget>[
                    Row(
                      children:
                      <Widget>[

                        SingleChildScrollView(
                            child: Container(
                                width: 200,
                                child: Text("Seller Registration",style: new TextStyle(fontSize: 15.0, color: Colors.white),))),
                        //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),

                      ],
                    ),
                  ],

                ),
              )
          ),
          //leading:new Text("hi"),
        ),



        body: new ListView(

          children: <Widget>[
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
      SizedBox(height: 20.0),
      new Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: new RaisedButton(
          onPressed: () async{
            pr.show();
            var loc=await _getCurrentLocation();
            print("Current Location is : "+loc.toString());
            pr.hide();
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => new MyLocation()));


          },
          child: new Text("Choose Your Location"),

        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child:  new InkWell(
          onTap: () async{
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => new MyLocation()));
          },
          child: ListTile(title: Text(widget.add==null?" ":'${widget.add}')),
        ),
      ),
      SizedBox(height: 20.0),
      new Text('Shop Name'),

      new TextFormField(
        decoration: new InputDecoration(hintText: 'Shop Name',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),
        validator: (value) => value.isEmpty ? 'Shop Name can\'t be empty' : null,
        onChanged: (val){
          setState(()=>_shopname=val);
        },

      ),
      new DropdownButton<String>(
        hint: Text(_cat==null?"Category":_cat),
        items: [
          DropdownMenuItem<String>(
            value:"Electronics",
            child: Center(
              child:Text("Electronics"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Grocery",
            child: Center(
              child:Text("Grocery"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Vegetables",
            child: Center(
              child:Text("Vegetables"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Non Veg",
            child: Center(
              child:Text("Non Veg"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Furnitures",
            child: Center(
              child:Text("Furnitures"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Clothing",
            child: Center(
              child:Text("Clothing"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Study Materials",
            child: Center(
              child:Text("Study Materials"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Wine",
            child: Center(
              child:Text("Wine"),
            ),
          ),
        ],
        onChanged: (val){
          setState(() {
            _cat=val;
          });
        },
      ),

      SizedBox(height: 20.0),

      new Text('E Mail'),
      new TextFormField(
        scrollPadding: EdgeInsets.all(10.0),
        decoration: new InputDecoration(hintText: 'E Mail',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),

        validator: (value) => value.isEmpty ? 'E Mail can\'t be empty' : null,
        onSaved: (value) => _emailid = value,
      ),
      SizedBox(height: 20.0),

      new Row(
        children: <Widget>[
          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Owner Name'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Owner Name',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),

                validator: (value) => value.isEmpty ? 'Owner Name can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_ownername=val);
                },
              ),
            ],
          ),
          ),

          new Padding(padding: EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0)),

          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Phone'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Phone Number',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),
                keyboardType: TextInputType.number,

                validator: (value) => value.isEmpty ? 'Phone Number can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_phone=val);
                },


              ),
            ],
          ),
          )


        ],
      ),

      SizedBox(height: 20.0),

      new Row(
        children: <Widget>[
          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Manager Name'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Manager Name',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),

                validator: (value) => value.isEmpty ? 'Manager Name can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_mname=val);
                },

              ),
            ],
          ),
          ),

          new Padding(padding: EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0)),

          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Phone'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Phone Number',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),
                keyboardType: TextInputType.number,
                validator: (value) => value.isEmpty ? 'Phone Number can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_mphone=val);
                },



              ),
            ],
          ),
          )


        ],
      ),

      SizedBox(height: 20.0),
      new Text('Aadhar Number'),

      new TextFormField(
        decoration: new InputDecoration(hintText: 'Enter Aadhar Number',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),
        validator: (value) => value.isEmpty ? 'Aadhar Number can\'t be empty' : null,
        onChanged: (val){
          setState(() =>_gst=val);
        },

      ),

      SizedBox(height: 20.0),

      new Container(
          child:
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Upload your Aadhar certificate'),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () => _openFileExplorer(),
                      child: new Text("Choose File"),
                    ),
                  ),
                  new Builder(
                    builder: (BuildContext context) => _path != null || _paths != null
                        ? new Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: new ListView.separated(
                        itemCount: _paths != null && _paths.isNotEmpty ? _paths.length : 1,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = _paths != null && _paths.isNotEmpty;
                          final String name = 'File: ' + (isMultiPath ? _paths.keys.toList()[index] : _fileName ?? '...');
                          path = isMultiPath ? _paths.values.toList()[index].toString() : _path;
                          file1=new File(path);

                          return new ListTile(
                            title: new Text(
                              name,
                            ),
                            subtitle: new Text(path),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => new Divider(),
                      ),
                    )
                        : new Container(),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () async{
                        pr.show();
                        final StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(user.uid+'Aadhar_certificate');
                        final StorageUploadTask task=firebaseStorageRef.putFile(file1);
                        StorageTaskSnapshot s=await task.onComplete;
                        url1=await s.ref.getDownloadURL();
                        print("url is "+url1);
                        pr.hide();
                      },
                      child: new Text("Upload"),
                    ),
                  ),
                ],
              ),
            ),
          )),

      SizedBox(height: 20.0),


      /*new FlatButton(
        child: Text('Choose your location'),
        onPressed: () async{
          //await _getCurrentLocation();
         await Navigator.push(context, MaterialPageRoute(
              builder: (context) => new MyLocation()));
          print("location is");
          print(widget.add);
        },
      ),*/
      /* new Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
        child: new RaisedButton(
          onPressed: () async{
            pr.show();
             var loc=await _getCurrentLocation();
             print("Current Location is : "+loc.toString());
             pr.hide();
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => new MyLocation()));
          },
          child: new Text("Choose Your Location"),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(8.0),
        child:  new InkWell(
          onTap: () async{
            await Navigator.push(context, MaterialPageRoute(
                builder: (context) => new MyLocation()));
          },
          child: ListTile(title: Text(widget.add==null?" ":'${widget.add}')),
        ),
      ),*/
      /* Padding(
        padding: EdgeInsets.all(8.0),
        child: new TextFormField(
          decoration: new InputDecoration(hintText: 'Enter more details',border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey))),
          validator: (value) => value.isEmpty ? 'Address can\'t be empty' : null,
          onChanged: (val){
            setState(() =>_add1=val);
          },
        ),
      ),*/

      //new Text(widget.add==null?" ":'${widget.add}'),


      /* new TextFormField(
        decoration: new InputDecoration(hintText: 'Address',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),
        validator: (value) => value.isEmpty ? 'Address can\'t be empty' : null,
        onChanged: (val){
          setState(() =>_add1=val);
        },
      ),*/

      SizedBox(height: 20.0),
      new Text('Address'),

      new TextFormField(
        decoration: new InputDecoration(hintText: 'Address',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),
        validator: (value) => value.isEmpty ? 'Address can\'t be empty' : null,
        onChanged: (val){
          setState(() =>_add2=val);
        },

      ),
     /* new DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
            value:"Bhubaneswar",
            child: Center(
              child:Text("Bhubaneswar"),
            ),
          ),
          DropdownMenuItem<String>(
            value:"Cuttack",
            child: Center(
              child:Text("Cuttack"),
            ),
          )
        ],
        onChanged: (val){
          setState(() {
            _city=val;
          });
        },
      ),*/


      SizedBox(height: 20.0),
      new Row(
        children: <Widget>[
          new DropdownButton<String>(
            hint: Text(_city==null?"Select your City":_city),
            items: [
              DropdownMenuItem<String>(
                value:"Bhubaneswar",
                child: Center(
                  child:Text("Bhubaneswar"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Cuttack",
                child: Center(
                  child:Text("Cuttack"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Sambalpur",
                child: Center(
                  child:Text("Sambalpur"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Bargarh",
                child: Center(
                  child:Text("Bargarh"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Puri",
                child: Center(
                  child:Text("Puri"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Rourkela",
                child: Center(
                  child:Text("Rourkela"),
                ),
              ),
              DropdownMenuItem<String>(
                value:"Jagatsinghpur",
                child: Center(
                  child:Text("Jagatsinghpur"),
                ),
              ),
            ],
            onChanged: (val){
              setState(() {
                _city=val;
              });
            },
          ),
          /*new Flexible(child: new Column(
            children: <Widget>[
              new Text('City'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'City',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),

                validator: (value) => value.isEmpty ? 'City can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_city=val);
                },

              ),
            ],
          ),
          ),*/

          new Padding(padding: EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0)),

          new Flexible(child: new Column(
            children: <Widget>[
              new Text('State'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'State',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),

                validator: (value) => value.isEmpty ? 'State can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_state=val);
                },

              ),
            ],
          ),
          ),

          new Padding(padding: EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0)),

          new Flexible(child: new Column(
            children: <Widget>[
              new Text('ZIP'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'ZIP',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),
                keyboardType: TextInputType.number,

                validator: (value) => value.isEmpty ? 'ZIP can\'t be empty' : null,
                onChanged: (val){
                  setState(() =>_zip=val);
                },

              ),
            ],
          ),
          )

        ],
      ),

      SizedBox(height: 20.0),
      new Row(
        children: <Widget>[
          new Expanded(child: new Column(
            children: <Widget>[
              new Text('More than one shop?'),
            ],
          ),
          ),

          new Padding(padding: EdgeInsets.fromLTRB(50.0,0.0,0.0,0.0)),


          new Flexible(child: new Column(
            children: <Widget>[
              new Radio(value: 1, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
                print(val);
                setselectedRadio(val);

              },)


            ],
          ),
          ),
          new Flexible(child: new Text("Yes")),


          new Flexible(child: new Column(
            children: <Widget>[
              new Radio(value: 2, groupValue: selectradio,activeColor: Colors.red,onChanged: (val){
                print(val);
                setselectedRadio(val);
              },)
            ],
          ),
          ),

          new Flexible(child: new Text("No"))

        ],
      ),


      SizedBox(height: 20.0),

      new Container(
          child:
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Share Your Shop Photo'),
                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () => _openFileExplorer1(),
                      child: new Text("Choose File"),
                    ),

                  ),

                  new Builder(
                    builder: (BuildContext context) => _path1 != null || _paths1 != null
                        ? new Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery.of(context).size.height * 0.10,
                      child: new ListView.separated(
                        itemCount: _paths1 != null && _paths1.isNotEmpty ? _paths1.length : 1,
                        itemBuilder: (BuildContext context, int index) {
                          final bool isMultiPath = _paths1 != null && _paths1.isNotEmpty;
                          final String name = 'File: ' + (isMultiPath ? _paths1.keys.toList()[index] : _fileName1 ?? '...');
                          path = isMultiPath ? _paths1.values.toList()[index].toString() : _path1;
                          file=new File(path);

                          return new ListTile(
                            title: new Text(
                              name,
                            ),
                            subtitle: new Text(path),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) => new Divider(),
                      ),
                    )
                        : new Container(),
                  ),
                  new Padding(

                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () async{
                        pr.show();
                        final StorageReference firebaseStorageRef=FirebaseStorage.instance.ref().child(user.uid+"shop");
                        final StorageUploadTask task=firebaseStorageRef.putFile(file);
                        StorageTaskSnapshot s=await task.onComplete;
                        url=await s.ref.getDownloadURL();
                        print("url is "+url);
                        pr.hide();
                      },
                      child: new Text("Upload"),
                    ),
                  ),
                ],
              ),
            ),
          )),

    ];
  }

  List<Widget> buildSubmitButtons() {
    if (true) {
      return [
        new OutlineButton(
            child: new Text('Submit For Verification', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
            onPressed:
                ()async{/*
            Firestore.instance.collection('Application for sellers').document(user.uid).setData({
              'GST_Certificate':url,
              'Email_id':user.email,
              'Shop_Name':_shopname,
              'Owner_Nmae':_ownername,
              'Phone':_phone,
              'Manager_Name':_mname,
              'Manager_Phone':_mphone,
              'GST Number':_gst,
              'Address1':_add1,
              'Address2':_add2,
              'City':_city,
              'State':_state,
              'Zip':_zip,
              'More_than_one shops?':_radio,
              'Shop_Image':url1
            });
            _updateData();*/
              pr.show();
              await FirebaseDatabase.instance.reference()
                  .child('ApplicationForSeller').child(user.uid).update({
                //'GST_Certificate':url,
                'Email_id':user.email,
                'Shop_Name':_shopname,
                'Owner_Name':_ownername,
                'Owner_Number':_phone,
                'Manager_Name':_mname,
                'Manager_Phone':_mphone,
                'Category':_cat,
                'Aadhar_Number':_gst,
                'Address1':"${widget.add}",
                'Address2':_add2,
                'City':_city,
                'State':_state,
                'Zip':_zip,
                'Latitude':'${widget.lat}',
                'Longitude':'${widget.lon}',
                'HaveMulShop':_radio,
                'Shop_Image':url1
              });
              pr.hide();
              Fluttertoast.showToast(
                  msg: "Application Submitted !!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,

                  textColor: Colors.white,
                  fontSize: 8.0
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => lp()),
              );

            },

            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
      ];
    }
  }

  getcurrentuser() async {
    user=await _auth.currentUser();
  }

  _updateData() async{
    await Firestore.instance.collection('users')
        .document(user.uid)
        .updateData({'isSeller': _isSeller});
    print(_isSeller);
    print("Ahoy");
    print(user.uid);

  }
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