import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:seller/main.dart';
import 'package:seller/pages/location.dart';
import 'package:seller/pages/register.dart';

class AddProduct extends StatefulWidget {
  final add;
  AddProduct(this.add);
  @override
  _AddProductState createState() => _AddProductState();
}
String scity;
FirebaseUser user;
List u=[];
class _AddProductState extends State<AddProduct> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress ;
  ProgressDialog pr;
  double percentage = 0.0;
  String _name,_description,_quantity,_price,_radio,badd;
  File file1;
  File file11,file12,file13,file14,file15,file16;
  String path;
  StorageReference firebaseStorageRef,firebaseStorageRef1,firebaseStorageRef2,firebaseStorageRef3,firebaseStorageRef4,firebaseStorageRef5;
  String url;


  String _email;
  String _password;
  String _fileName;
  String _path = 'No File Choosen';
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

  String _fileName2;
  String _path2 = 'No File Choosen';
  Map<String, String> _paths2;
  String _extension2;
  bool _multiPick2 = false;
  bool _hasValidMime2 = true;
  FileType _pickingType2=FileType.IMAGE;

  String _fileName3;
  String _path3 = 'No File Choosen';
  Map<String, String> _paths3;
  String _extension3;
  bool _multiPick3 = false;
  bool _hasValidMime3 = true;
  FileType _pickingType3=FileType.IMAGE;

  String _fileName4;
  String _path4 = 'No File Choosen';
  Map<String, String> _paths4;
  String _extension4;
  bool _multiPick4 = false;
  bool _hasValidMime4 = true;
  FileType _pickingType4=FileType.IMAGE;

  String _fileName5;
  String _path5 = 'No File Choosen';
  Map<String, String> _paths5;
  String _extension5;
  bool _multiPick5 = false;
  bool _hasValidMime5 = true;
  FileType _pickingType5=FileType.IMAGE;

  String _fileName6;
  String _path6 = 'No File Choosen';
  Map<String, String> _paths6;
  String _extension6;
  bool _multiPick6 = false;
  bool _hasValidMime6 = true;
  FileType _pickingType6=FileType.IMAGE;
  String loc;

  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int selectradio;


  @override
  void initState() {
    super.initState();
    getuser();
    _getCurrentLocation();
    _controller.addListener(() => _extension = _controller.text);
    _controller1.addListener(() => _extension1 = _controller1.text);
    selectradio=0;
  }

  setselectedRadio(val)
  {
    setState(() {
      selectradio=val;
      if(selectradio==1)
      {
        _radio='Electronics';
      }
      else if(selectradio==2)
      {
        _radio='Grocery';
      }
      else if(selectradio==3)
      {
        _radio='Vegetables';
      }
      else if(selectradio==4)
      {
        _radio='Non Veg';
      }
      else if(selectradio==5)
      {
        _radio='TV Home & Furniture';
      }
      else if(selectradio==6)
      {
        _radio='Clothing';
      }
      else if(selectradio==7)
      {
        _radio='Books and Study Materials';
      }
      else if(selectradio==8)
      {
        _radio='Wine';
      }

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
  void _openFileExplorer2() async {
    if (_pickingType2 != FileType.CUSTOM || _hasValidMime2) {
      try {
        if (_multiPick2) {
          _path2 = null;
          _paths2 = await FilePicker.getMultiFilePath(type: _pickingType2, fileExtension: _extension2);
        } else {
          _paths2 = null;
          _path2 = await FilePicker.getFilePath(type: _pickingType2, fileExtension: _extension2);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName2 = _path2 != null ? _path2.split('/').last : _paths2 != null ? _paths2.keys.toString() : '...';
      });
    }
  }
  void _openFileExplorer3() async {
    if (_pickingType3 != FileType.CUSTOM || _hasValidMime3) {
      try {
        if (_multiPick3) {
          _path1 = null;
          _paths1 = await FilePicker.getMultiFilePath(type: _pickingType3, fileExtension: _extension3);
        } else {
          _paths3 = null;
          _path3 = await FilePicker.getFilePath(type: _pickingType3, fileExtension: _extension3);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName3 = _path3 != null ? _path3.split('/').last : _paths3 != null ? _paths3.keys.toString() : '...';
      });
    }
  }
  void _openFileExplorer4() async {
    if (_pickingType4 != FileType.CUSTOM || _hasValidMime4) {
      try {
        if (_multiPick4) {
          _path4 = null;
          _paths4 = await FilePicker.getMultiFilePath(type: _pickingType4, fileExtension: _extension4);
        } else {
          _paths4 = null;
          _path4 = await FilePicker.getFilePath(type: _pickingType4, fileExtension: _extension4);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName4 = _path4 != null ? _path4.split('/').last : _paths4 != null ? _paths4.keys.toString() : '...';
      });
    }
  }
  void _openFileExplorer5() async {
    if (_pickingType5 != FileType.CUSTOM || _hasValidMime5) {
      try {
        if (_multiPick5) {
          _path5 = null;
          _paths5 = await FilePicker.getMultiFilePath(type: _pickingType5, fileExtension: _extension5);
        } else {
          _paths5 = null;
          _path5 = await FilePicker.getFilePath(type: _pickingType5, fileExtension: _extension5);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName5 = _path5 != null ? _path5.split('/').last : _paths5 != null ? _paths5.keys.toString() : '...';
      });
    }
  }
  void _openFileExplorer6() async {
    if (_pickingType6 != FileType.CUSTOM || _hasValidMime6) {
      try {
        if (_multiPick6) {
          _path6 = null;
          _paths6 = await FilePicker.getMultiFilePath(type: _pickingType6, fileExtension: _extension6);
        } else {
          _paths6 = null;
          _path6 = await FilePicker.getFilePath(type: _pickingType6, fileExtension: _extension6);
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return;

      setState(() {
        _fileName6 = _path6 != null ? _path6.split('/').last : _paths6 != null ? _paths6.keys.toString() : '...';
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
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                            _getCurrentLocation();
                            currentUser();
                          },
                        ),
                        SingleChildScrollView(
                          child: Container(
                              child: new FlatButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                              }, child: Text(widget.add==null?badd:"${widget.add}",style: new TextStyle(fontSize: 15.0, color: Colors.white),))),)
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
      new Row(
        children: <Widget>[
          /*new Flexible(child: new Column(
            children: <Widget>[
              new Image.asset('images/16x9@2x.png')
            ],
          )),*/
          new Flexible(child: new Column(
            children: <Widget>[
              new Padding(padding: EdgeInsets.fromLTRB(10.0,0.0,0.0,0.0)),
              //new Text('Ekanta Pattnaik\nShop Name',style: TextStyle(fontSize: 22.0),)

            ],
          ))
        ],
      ),
      Divider(
        color: Colors.grey,
        height: 10.0,
      ),
      new Text('Add Product',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),),
      SizedBox(height: 20.0),
      new Text('Name Of Product'),

      new TextFormField(
        decoration: new InputDecoration(hintText: 'Product Name',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },

        onChanged: (value) {
          setState(() {
            _name = value;
          });
        },

      ),

      SizedBox(height: 20.0),

      new Text('Description'),
      new TextFormField(
        maxLines: 10,
        scrollPadding: EdgeInsets.all(10.0),
        decoration: new InputDecoration(hintText: '',border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.grey)),),

        validator: (value) => value.isEmpty ? 'Description can\'t be empty' : null,
        onChanged: (value) {
          setState(() {
            _description = value;
          });
        },

      ),

      SizedBox(height: 20.0),


      SizedBox(height: 20.0),
      new Text('Categories'),
      Row(
        children: <Widget>[
          new Radio(value: 1, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Electronics')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 2, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Grocery')
        ],
      ),

      Row(
        children: <Widget>[
          new Radio(value: 3, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Vegetables')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 4, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Non Veg')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 5, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Furnitures')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 6, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Clothing')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 7, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Study Materials')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 8, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Wine')
        ],
      ),
      /*Row(
        children: <Widget>[
          new Radio(value: 8, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Books')
        ],
      ),*/

      new Row(
        children: <Widget>[
          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Quantity'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Quantity',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),
                keyboardType: TextInputType.number,

                validator: (value) => value.isEmpty ? 'Quantity can\'t be empty' : null,
                onChanged: (value) {
                  setState(() {
                    _quantity = value;
                  });
                },

              ),
            ],
          ),
          ),

          new Padding(padding: EdgeInsets.fromLTRB(5.0,0.0,0.0,0.0)),

          new Flexible(child: new Column(
            children: <Widget>[
              new Text('Price'),

              new TextFormField(
                scrollPadding: EdgeInsets.all(10.0),
                decoration: new InputDecoration(hintText: 'Price',border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.grey))),
                keyboardType: TextInputType.number,

                validator: (value) => value.isEmpty ? 'Price can\'t be empty' : null,
                onChanged: (value) {
                  setState(() {
                    _price = value;
                  });
                },

              ),
            ],
          ),
          ),

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
                  new Text('Image of the product'),

                  Row(
                    children: <Widget>[
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer1(),
                                child: new Text("Choose Image 1"),
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
                                    final String name = 'File:- ' + (isMultiPath ? _paths1.keys.toList()[index] : _fileName1 ?? 'No file Choosen');
                                    final path = isMultiPath ? _paths1.values.toList()[index].toString() : _path1;
                                    file11=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(10.0)),
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer2(),
                                child: new Text("Choose Image 2"),
                              ),
                            ),new Builder(
                              builder: (BuildContext context) => _path2 != null || _paths2 != null
                                  ? new Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                height: MediaQuery.of(context).size.height * 0.10,
                                child: new ListView.separated(
                                  itemCount: _paths2 != null && _paths2.isNotEmpty ? _paths2.length : 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    final bool isMultiPath = _paths2 != null && _paths2.isNotEmpty;
                                    final String name = 'File:- ' + (isMultiPath ? _paths2.keys.toList()[index] : _fileName2 ?? 'No File Choosen');
                                    final path = isMultiPath ? _paths2.values.toList()[index].toString() : _path2;
                                    file12=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(10.0)),
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer3(),
                                child: new Text("Choose Image 3"),
                              ),
                            ),new Builder(
                              builder: (BuildContext context) => _path3 != null || _paths3 != null
                                  ? new Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                height: MediaQuery.of(context).size.height * 0.10,
                                child: new ListView.separated(
                                  itemCount: _paths3 != null && _paths2.isNotEmpty ? _paths3.length : 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    final bool isMultiPath = _paths3 != null && _paths3.isNotEmpty;
                                    final String name = 'File:- ' + (isMultiPath ? _paths3.keys.toList()[index] : _fileName3 ?? 'No File Choosen');
                                    final path = isMultiPath ? _paths3.values.toList()[index].toString() : _path3;
                                    file13=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer4(),
                                child: new Text("Choose Image 4"),
                              ),
                            ),new Builder(
                              builder: (BuildContext context) => _path4 != null || _paths4 != null
                                  ? new Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                height: MediaQuery.of(context).size.height * 0.10,
                                child: new ListView.separated(
                                  itemCount: _paths4 != null && _paths4.isNotEmpty ? _paths4.length : 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    final bool isMultiPath = _paths4 != null && _paths4.isNotEmpty;
                                    final String name = 'File:- ' + (isMultiPath ? _paths4.keys.toList()[index] : _fileName4 ?? 'No File Choosen');
                                    final path = isMultiPath ? _paths4.values.toList()[index].toString() : _path4;
                                    file14=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(10.0)),
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer5(),
                                child: new Text("Choose Image 5"),
                              ),
                            ),new Builder(
                              builder: (BuildContext context) => _path5 != null || _paths5 != null
                                  ? new Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                height: MediaQuery.of(context).size.height * 0.10,
                                child: new ListView.separated(
                                  itemCount: _paths5 != null && _paths5.isNotEmpty ? _paths5.length : 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    final bool isMultiPath = _paths5 != null && _paths5.isNotEmpty;
                                    final String name = 'File:- ' + (isMultiPath ? _paths5.keys.toList()[index] : _fileName5 ?? 'No File Choosen');
                                    final path = isMultiPath ? _paths5.values.toList()[index].toString() : _path5;
                                    file15=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(10.0)),
                      new Flexible(
                        child: Column(
                          children: <Widget>[
                            new Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                              child: new RaisedButton(
                                onPressed: () => _openFileExplorer6(),
                                child: new Text("Choose Image 6"),
                              ),
                            ),new Builder(
                              builder: (BuildContext context) => _path6 != null || _paths6 != null
                                  ? new Container(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                height: MediaQuery.of(context).size.height * 0.10,
                                child: new ListView.separated(
                                  itemCount: _paths6 != null && _paths6.isNotEmpty ? _paths6.length : 1,
                                  itemBuilder: (BuildContext context, int index) {
                                    final bool isMultiPath = _paths6 != null && _paths6.isNotEmpty;
                                    final String name = 'File:- ' + (isMultiPath ? _paths6.keys.toList()[index] : _fileName6 ?? 'No File Choosen');
                                    final path = isMultiPath ? _paths6.values.toList()[index].toString() : _path6;
                                    file16=new File(path);

                                    return new ListTile(
                                      title: new Text(
                                        name,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) => new Divider(),
                                ),
                              )
                                  : new Container(),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),

                  new Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: new RaisedButton(
                      onPressed: () async{

                        pr.show();
                        firebaseStorageRef=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+"a");
                        final StorageUploadTask task=firebaseStorageRef.putFile(file11);
                        StorageTaskSnapshot s=await task.onComplete;
                        url=await s.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        firebaseStorageRef1=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+"b");
                        final StorageUploadTask task1=firebaseStorageRef1.putFile(file12);
                        StorageTaskSnapshot s1=await task1.onComplete;
                        url=await s1.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        firebaseStorageRef2=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+"c");
                        final StorageUploadTask task2=firebaseStorageRef2.putFile(file13);
                        StorageTaskSnapshot s2=await task2.onComplete;
                        url=await s2.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        firebaseStorageRef3=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+"d");
                        final StorageUploadTask task3=firebaseStorageRef3.putFile(file14);
                        StorageTaskSnapshot s3=await task3.onComplete;
                        url=await s3.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        firebaseStorageRef4=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+"e");
                        final StorageUploadTask task4=firebaseStorageRef4.putFile(file15);
                        StorageTaskSnapshot s4=await task4.onComplete;
                        url=await s4.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        firebaseStorageRef5=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+"f");
                        final StorageUploadTask task5=firebaseStorageRef5.putFile(file16);
                        StorageTaskSnapshot s5=await task5.onComplete;
                        url=await s5.ref.getDownloadURL();
                        print("url is "+url);
                        u.add(url);
                        pr.hide();
                        print(u[0]);
                        Fluttertoast.showToast(
                            msg: "Product Images Uploaded",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            fontSize: 8.0
                        );





                      },
                      child: new Text("Upload"),
                    ),
                  ),
                ],
              ),
            ),
          )),

      /*new Container(
          child:
          new Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('Image of the product'),
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
                          file2=new File(path);

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
                        firebaseStorageRef=FirebaseStorage.instance.ref().child(user.uid+"_"+_radio+" "+path);
                        final StorageUploadTask task=firebaseStorageRef.putFile(file2);
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
          )),*/

    ];
  }


  List<Widget> buildSubmitButtons() {
    if (true) {
      return [
        new OutlineButton(
            child: new Text('Add Product', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
            onPressed: () {
              //https://duckhawk-1699a.firebaseio.com/ApplicationForSeller.json


              FirebaseDatabase.instance.reference().child('Products').child(scity).child(_radio).push()
                  .set(
                  {
                    'ProductDesc': _description,
                    'Product_Image': u[0].toString(),
                    'name': _name,
                    'price': _price,
                    'stock': _quantity,
                    'seller': user.uid
                  }


              );
              Fluttertoast.showToast(
                  msg: "Products Added !!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  fontSize: 8.0
              );
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage(null)),
              );


            },

            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
      ];
    }
  }


  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

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
      curlat=_currentPosition.latitude.toString();
      curlon=_currentPosition.longitude.toString();

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });
      badd=_currentAddress;
    } catch (e) {
      print(e);
    }
  }



}
void getuser() async{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  user = await _auth.currentUser();
  String link="https://duckhawk-1699a.firebaseio.com/ApplicationForSeller/"+user.uid+".json";
  final resource = await http.get(link);
  if(resource.statusCode == 200)
    {
      LinkedHashMap<String,dynamic>data=jsonDecode(resource.body);
      print("city is:");
      print(data["City"]);
      scity=data["City"];

    }
}
