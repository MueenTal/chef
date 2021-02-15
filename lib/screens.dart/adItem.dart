import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  var _value = "1";

// القائمة التي تحتوي على القسم
  DropdownButton hintDown() => DropdownButton<String>(
        dropdownColor: Colors.blue[700],
        iconEnabledColor: Colors.blue,
        style: TextStyle(
            color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
        elevation: 10,
        underline: Container(
          height: 1,
          color: Colors.blue,
        ),
        items: [
          DropdownMenuItem<String>(
            value: "1",
            child: Text(
              "الأطباق الرئيسية",
              style: TextStyle(fontSize: 20),
            ),
          ),
          DropdownMenuItem<String>(
            value: "2",
            child: Text(
              "سناك",
              style: TextStyle(fontSize: 20),
            ),
          ),
          DropdownMenuItem<String>(
            value: "3",
            child: Text(
              "حلويات",
              style: TextStyle(fontSize: 20),
            ),
          ),
          DropdownMenuItem<String>(
            value: "4",
            child: Text(
              "مقبلات",
              style: TextStyle(fontSize: 20),
            ),
          ),
          DropdownMenuItem<String>(
            value: "5",
            child: Text(
              "الأطباق الصحية",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
        onChanged: (value) {
          setState(() {
            _value = value;
          });
        },
        value: _value,
      );

  TextEditingController _nameContoller = TextEditingController();
  TextEditingController _compuContoller = TextEditingController();
  TextEditingController _priceContoller = TextEditingController();

  bool _uploading = false;
  File _image;
  String type = "";

// دالة عرض الصورة المختارة من معرض الصور
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _uploading = true;
    });
    setState(() {
      _image = image;
      _uploading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wdth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.lightBlue[800],
            title: Text(
              "إضافة عامل توصيل",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.grey[200],
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_a_photo),
                      onPressed: () {
                        getImage();
                      },
                    ),
                    Text("اختار الصورة"),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: (_image != null)
                    ? Image.file(
                        _image,
                        height: wdth / 2.5,
                        width: wdth / 2.5,
                        fit: BoxFit.cover,
                      )
                    : Container(),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      controller: _nameContoller,
                      decoration: InputDecoration(
                        hintText: 'الرجاء ادخال اسم الطبق ',
                        labelText: 'اسم الطبق',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 3),
                        ),
                      )),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      maxLines: 8,
                      controller: _compuContoller,
                      decoration: InputDecoration(
                        hintText: 'الرجاء ادخال مكونات الطبق  ',
                        labelText: 'مكونات الطبق',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 3),
                        ),
                      )),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                      controller: _priceContoller,
                      decoration: InputDecoration(
                        hintText: 'الرجاء ادخال سعر الطبق ',
                        labelText: 'السعر',
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.lightBlue, width: 3),
                        ),
                      )),
                ),
              ),
              hintDown(),
              (_uploading)
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: 0,
                    ),
              Center(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 50,
                          width: wdth / 1.5,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.red,
                                    Colors.red,
                                  ])),
                          child: FlatButton(
                            splashColor: Colors.blueAccent,
                            child: Text(
                              " اضافة الطبق",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              // لمعرفة نوع القسم الذي تم اختياره
                              if (_value == "1") {
                                setState(() {
                                  type = "main";
                                });
                              } else if (_value == "2") {
                                setState(() {
                                  type = "snak";
                                });
                              } else if (_value == "3") {
                                setState(() {
                                  type = "hlweat";
                                });
                              } else if (_value == "4") {
                                setState(() {
                                  type = "mokblat";
                                });
                              } else if (_value == "5") {
                                setState(() {
                                  type = "shy";
                                });
                              }
                              // التحقق من جميع المدخلات
                              if (_nameContoller.text.isEmpty ||
                                  _compuContoller.text.isEmpty ||
                                  _priceContoller.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "يجب عليك ادخال جميع البيانات   ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              } else {
                                try {
                                  setState(() {
                                    _uploading = true;
                                  });
                                } catch (e) {
                                  print(e);
                                } finally {
                                  var fileName = "";

                                  String imageLink = "";
                                  // دالة رفع الصورة على الفير بيز
                                  if (_image != null) {
                                    fileName = basename(_image.path);
                                    setState(() {
                                      _uploading = true;
                                    });
                                    StorageReference firebaseStorage =
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(fileName);
                                    StorageUploadTask uploadTask =
                                        firebaseStorage.putFile(_image);
                                    StorageTaskSnapshot snapshot =
                                        await uploadTask.onComplete;
                                    final StorageReference storageReference =
                                        FirebaseStorage().ref().child(
                                            snapshot.storageMetadata.name);
                                    imageLink =
                                        await storageReference.getDownloadURL();
                                  } else {
                                    imageLink =
                                        "https://ilhyh.com/wp-content/uploads/2019/01/%D8%B5%D9%88%D8%B1-%D8%B3%D9%81%D8%B1-%D9%88-%D8%B9%D8%B2%D8%A7%D9%8A%D9%85.jpg";
                                  }
                                  // اضافة صف جديد يحتوي على بيانات الوجبة في جدول الوجبات
                                  await FirebaseFirestore.instance
                                      .collection("items")
                                      .doc()
                                      .set({
                                    'name': _nameContoller.text,
                                    'image': imageLink,
                                    'comp': _compuContoller.text,
                                    "price": _priceContoller.text,
                                    "tyep": type
                                  });
                                  Fluttertoast.showToast(
                                      msg: "تم اضافة الوجبة بنجاح  ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  Navigator.pop(context);

                                  setState(() {
                                    _uploading = false;
                                  });
                                }
                              }
                            },
                          )))),
            ],
          )),
        ),
      ),
    );
  }
}
