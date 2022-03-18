import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:plantme/data/plant.dart';
import 'package:plantme/pages/homepage.dart';

class AllPlants extends StatefulWidget {
  final List<Plant> plants;

  // In the constructor, require a Todo.
  AllPlants({Key key, @required this.plants}) : super(key: key);

  @override
  _AllPlantsState createState() => _AllPlantsState();
}

class _AllPlantsState extends State<AllPlants> {
  Widget childTemplate(ch) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.black,
          child: ch.photo != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    ch.photo,
                    width: 60,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(100)),
                  width: 60,
                  height: 200,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                ),
        ),
        title: Text(
          ch.name,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xff315951),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "DOB: ${(ch.dob.toString()).substring(0, 10)}",
          style: TextStyle(
            fontSize: 15.0,
            color: Color(0xff315951),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar:
                // AppBar(
                //   title: Text('List of Plants'),
                //   centerTitle: true,
                //   backgroundColor: Color(0xff0d4037),
                // ),
                AppBar(
              title: Text('List of Plants'),
              centerTitle: true,
              backgroundColor: Color(0xff0d4037),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image(
                  width: 24,
                  color: Color(0xfffce8dd),
                  image: Svg('assets/back_arrow.svg'),
                ),
              ),
            ),
            body: Column(
              children: plants.map((ch) => childTemplate(ch)).toList(),
            )));
  }
}
