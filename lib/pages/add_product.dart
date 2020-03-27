import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:seller/main.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

FirebaseUser user;
class _AddProductState extends State<AddProduct> {
  ProgressDialog pr;
  double percentage = 0.0;
  String _name,_description,_quantity,_price,_radio;
  File file2;
  String path;
   StorageReference firebaseStorageRef;
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
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller1 = new TextEditingController();
  int selectradio;


  @override
  void initState() {
    super.initState();
    getuser();
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
          _radio='Groceries';
        }
      else if(selectradio==2)
        {
          _radio='Fashion';
        }
      else if(selectradio==3)
      {
        _radio='Electronics';
      }
      else if(selectradio==4)
      {
        _radio='Sports';
      }
      else if(selectradio==5)
      {
        _radio='Books';
      }
      else if(selectradio==6)
      {
        _radio='Home & Furniture';
      }
      else if(selectradio==7)
      {
        _radio='Beauty & Personal Care';
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
                                child: Text("Add products",style: new TextStyle(fontSize: 15.0, color: Colors.white),))),
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
        validator: (value) => value.isEmpty ? 'Product Name can\'t be empty' : null,
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
          new Text('Groceries')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 2, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Fashion')
        ],
      ),

      Row(
        children: <Widget>[
          new Radio(value: 3, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Electronics')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 4, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Sports')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 5, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Books')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 6, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Home & Furniture')
        ],
      ),
      Row(
        children: <Widget>[
          new Radio(value: 7, groupValue: selectradio, activeColor: Colors.green,onChanged: (val){
            print(val);
            setselectedRadio(val);
          },),
          new Text('Beauty & Personal Care')
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
          )),

    ];
  }


  List<Widget> buildSubmitButtons() {
    if (true) {
      return [
        new OutlineButton(
            child: new Text('Add Product', textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
            onPressed: (){
              FirebaseDatabase.instance.reference().child('Products').child(badd).child(_radio).push().set(
{
  'description':_description,
  'imgurl':url,
  'name':_name,
  'price':_price,
  'quantity':_quantity,
  'seller':user.uid
}



              );
              Navigator.pop(context);
            },
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
      ];
    }
  }

  void getuser() async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
     user = await _auth.currentUser();
  }
}
