import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:plantme/data/plant.dart';
import 'package:plantme/pages/select_initial_reminders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';


String name = "";
String category = "";
File photo; // Image
DateTime dob;
String formattedDate;
bool isLoading = false;
var pic = Firestore.instance.collection('images');
List<Plant> plants;

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showError = false;

  // Widget for Plant Name
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          key: Key("PlantName"),
          cursorColor: Colors.black,
          decoration: InputDecoration(labelText: "Plant Name"),
          onSaved: (String value) {
            name = value;
          }),
    );
  }

  List<String> listOfValue = ['Monstera', 'ZZ Plant', 'Rubber plant'];
  Widget _buildCategory() {
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField(
        value: null,
        hint: Text(
          'choose category',
        ),
        isExpanded: true,
        onChanged: (value) {
          setState(() {
            category = value;
          });
        },
        onSaved: (value) {
          setState(() {
            category = value;
          });
        },
        items: listOfValue.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(
              val,
            ),
          );
        }).toList(),
      ),
    );
  }

  void _goToSelectReminders(BuildContext context, Plant newPlant) async {
    Plant result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Select_Initial_Reminders(
          plant: newPlant,
        ),
      ),
    );
    Navigator.pop(context, result);
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      photo = image;
      print('Image Path $photo');
    });
  }

  // var pic = Firestore.instance.collection('images');
  // Future<void> getImagesFromDatabase() async {
  //   QuerySnapshot querySnapshot = await pic.getDocuments();
  //   // for (int i = 0; i < querySnapshot.documents.length; i++) {
  //   //  Plant cutie =
  //   //   //    new Plant(querySnapshot.documents[i].data['name'], dob, null,photo);

  //   //   setState(() {
  //   //     plants.add(cutie);
  //   //   });
  // }

  Future uploadPic(BuildContext context) async {
    String fileName = basename(photo.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child("images/$fileName");
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(photo);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    await pic.add({"url": downloadUrl, "name": fileName});

    //final snackBar = SnackBar(content: Text('Yay! Success'));
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    name = "";
    category = "";
    photo = null; // Image
    dob = null;
    formattedDate = "";
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xfffce8dd),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 0),
              child: Form(
                key: _formKey,
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppBar(
                        backgroundColor: Color(0xfffce8dd),
                        elevation: 0,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Image(
                            width: 24,
                            color: Color(0xFF0D4037),
                            image: Svg('assets/back_arrow.svg'),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Add Plant ',
                        style: TextStyle(
                          color: Color(0xff0d4037),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  // Add an option to add Image
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.black,
                        child: photo != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  photo,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffffb179),
                                    borderRadius: BorderRadius.circular(100)),
                                width: 200,
                                height: 200,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                  ),

                  // Add Name
                  Container(
                    width: 370,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffe55d45), width: 2),
                      color: Color(0xffe55d45),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: <Widget>[
                        _buildName(),
                        _buildCategory(),
                        // Add date of birth through scrollable sat picker
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Date Of Birth'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(dob == null ? "" : formattedDate),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff0d4037), // background
                                ),
                                child: Text('Pick a date'),
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: dob == null
                                              ? DateTime.now()
                                              : dob,
                                          firstDate: DateTime(1990),
                                          lastDate: DateTime(2101))
                                      .then((date) {
                                    setState(() {
                                      dob = date;
                                      formattedDate =
                                          "${date.day} - ${date.month} - ${date.year}";
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Next button - transfer the information
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff0d4037), // background
                        //onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        _formKey.currentState.save();
                        if (dob == null ||
                            //gender == -1 ||
                            name == "" ||
                            photo == null ||
                            category == "") {
                          setState(() {
                            showError = true;
                          });
                          return;
                        }
                        showError = false;
                        Plant newPlant = Plant(name, dob, photo, category);
                        _goToSelectReminders(context, newPlant);
                        uploadPic(context);
                      },
                      icon: Icon(Icons.arrow_forward_sharp),
                      label: Text(""),
                    ),
                  ),
                  showError == true
                      ? Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                              " Fill in all the details before moving forward "))
                      : Container(),
                ]),
              ),
            ),
          )),
    );
  }
}

mixin FirebaseFirestore {
  static var instance;
}
