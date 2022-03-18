import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantme/constants/colors.dart';
import 'package:plantme/constants/custonPainer.dart';
import 'package:plantme/controllers/authentication.dart';
import 'package:plantme/data/allPlant.dart';
import 'package:plantme/data/plant.dart';
import 'package:plantme/pages/addPlant.dart';
import 'package:plantme/pages/calendar_view.dart';
import 'package:plantme/pages/listpage.dart';
import 'package:plantme/pages/login_screen.dart';
import 'package:plantme/pages/modules/home/view.dart';
import 'package:plantme/widget/myplant_home.dart';

List<Plant> plants;

class HomePage extends StatefulWidget {
  final String uid;
  HomePage({Key key, @required this.uid}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final String uid;
  int numCards = 1;
  int _index = 0;

  _HomePageState(this.uid);
  var user = Firestore.instance.collection('users');

  _addPlant(Plant newPlant) async {
    setState(() {
      plants.add(newPlant);
    });
    user
        .document(uid)
        .collection('plants')
        .add(newPlant.toJson())
        .then((docRef) =>
            {print("Document written with ID: " + docRef.documentID)})
        .catchError((error) => {print("Error adding document: ")});
  }

  Future<void> getPlantsFromDatabase() async {
    QuerySnapshot querySnapshot =
        await user.document(uid).collection('plants').getDocuments();
    for (int i = 0; i < querySnapshot.documents.length; i++) {
      var time = querySnapshot.documents[i].data['dob'];
      var dob =
          DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
      Plant cutie = new Plant(querySnapshot.documents[i].data['name'], dob,
          null, querySnapshot.documents[i].data['category']);
      cutie.events = cutie
          .getEventsfromdatabase(querySnapshot.documents[i].data['events']);
      setState(() {
        plants.add(cutie);
      });
    }

    numCards = plants.length == 0 ? 1 : plants.length;
    if (plants != null) {
      for (Plant plant in plants) plant.getNextDuecategoryplants();
    }
  }

  @override
  void initState() {
    super.initState();
    if (plants == null) {
      plants = [];
      getPlantsFromDatabase();
    }
  }

  void _goToAddPlantPage(BuildContext context) async {
    Plant result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddPlant(),
        ));
    if (result != null) {
      _addPlant(result);
    }
    numCards = plants.length == 0 ? 1 : plants.length;
    if (plants != null) {
      for (Plant plant in plants) plant.getNextDuecategoryplants();
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xfffce8dd),
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'Plant me.',
          style: TextStyle(
              color: kFontLight, fontWeight: FontWeight.w400, fontSize: 20),
        ),
      ),
      actions: <Widget>[
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 30, top: 10),
              padding: EdgeInsets.all(8),
            ),
          ],
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    //final dailyRef = dbRef.child('/info');
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffce8dd),
        appBar: _buildAppBar(),
        body: ListView(
          //reverse: true,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    // color: Colors.red,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'how do you\nfeel to day ? ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: korange),
                      ),
                    ),
                  ),

                  // Myplant_home('My garden'),
                  Positioned(
                    top: 10,
                    right: 25,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Color(0xffe55d45),
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        icon: Icon(
                          Icons.logout_outlined,
                          color: Colors.white,
                        ),
                        iconSize: 20,
                        onPressed: () => signOutUser().then(
                          (value) {
                            //children = null;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Divider(
                    color: kFontLight,
                    indent: 20,
                    endIndent: 20,
                    height: 30,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    // color: Colors.red,
                  ),
                  Myplant_home('My garden'),
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: SizedBox(
                      height: 160, // card height
                      child: PageView.builder(
                        itemCount: numCards,
                        controller: PageController(viewportFraction: 0.8),
                        onPageChanged: (int index) =>
                            setState(() => _index = index),
                        itemBuilder: (_, i) {
                          return Transform.scale(
                            scale: i == _index ? 1 : 0.9,
                            child: Card(
                                elevation: 6,
                                color: Color(0xff0d4037),
                                // color: Color.fromRGBO(
                                //     226,90,21,.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: (plants != null &&
                                        plants.length != 0 &&
                                        i == _index)
                                    ? Column(children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Center(
                                              child: Text(plants[_index].name,
                                                  style: // GoogleFonts.lato(textStyle:
                                                      TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.w900,
                                                    //     ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "Watering Plant on - ${plants[_index].nextDue.keys.first.day} - ${plants[_index].nextDue.keys.first.month} - ${plants[_index].nextDue.keys.first.year}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w700,
                                            )),
                                        Text(
                                            "Category of Plant : ${plants[_index].category}",
                                            style: // GoogleFonts.lato(textStyle:
                                                TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                              //     ),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // ClipRRect(
                                            //   borderRadius: BorderRadius.only(
                                            //     topLeft: Radius.circular(20),
                                            //     topRight: Radius.circular(20),
                                            //   ),
                                            //   child:Image.file(
                                            //         plants[_index].photo,
                                            //         width: 65,
                                            //         height: 65,
                                            //         fit: BoxFit.fill,
                                            //       ),),

                                            CircleAvatar(
                                                radius: 35,
                                                backgroundColor: Color.fromRGBO(
                                                    255, 255, 255, 1),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Image.file(
                                                    plants[_index].photo,
                                                    width: 65,
                                                    height: 65,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (var next in plants[_index]
                                                    .nextDue
                                                    .values
                                                    .first)
                                                  Text(
                                                    next,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.teal[50],
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ])
                                    : Center(
                                        child: Text("No Plant Added"),
                                      )),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [ListPage()],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(children: [
                  Container(
                    width: size.width,
                    height: 80,
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        CustomPaint(
                          size: Size(size.width, 80),
                          painter: BNBCustomPainter(),
                        ),
                        Center(
                          heightFactor: 0.6,
                          child: FloatingActionButton(
                              backgroundColor: Colors.orange,
                              child: Icon(Icons.add),
                              elevation: 0.1,
                              onPressed: () {
                                setBottomBarIndex(5);
                                _goToAddPlantPage(context);
                                setState(() {});
                              }),
                        ),
                        Container(
                          width: size.width,
                          height: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_task_rounded,
                                  color: currentIndex == 0
                                      ? Colors.orange
                                      : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  setBottomBarIndex(4);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomePage1(),
                                    ),
                                  );
                                },
                                splashColor: Colors.white,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.notification_add,
                                    color: currentIndex == 1
                                        ? Colors.orange
                                        : Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    setBottomBarIndex(1);
                                    Navigator.pushNamed(context, '/localNotif');
                                    
                                  }),
                              Container(
                                width: size.width * 0.20,
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.calendar_today_rounded,
                                    color: currentIndex == 2
                                        ? Colors.orange
                                        : Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    setBottomBarIndex(2);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CalendarScreen(
                                          plants: plants,
                                        ),
                                      ),
                                    );
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.collections_bookmark,
                                    color: currentIndex == 3
                                        ? Colors.orange
                                        : Colors.grey.shade400,
                                  ),
                                  onPressed: () {
                                    setBottomBarIndex(3);
                                    setState(() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AllPlants(plants: plants),
                                        ),
                                      );
                                    });
                                  }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
        //        bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[

        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.business),
        //       label: 'Business',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.school),
        //       label: 'School',
        //     ),
        //   ],
        //   // currentIndex: _selectedIndex,
        //   // selectedItemColor: Colors.amber[800],
        //   // onTap: _onItemTapped,
        // ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
