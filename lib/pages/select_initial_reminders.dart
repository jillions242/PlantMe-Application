import 'package:flutter/material.dart';
import 'package:plantme/data/allCategoryPlant.dart';
import 'package:plantme/data/categoryplant.dart';
import 'package:plantme/data/plant.dart';


class Select_Initial_Reminders extends StatefulWidget {
  final Plant plant;
  const Select_Initial_Reminders({Key key, this.plant}) : super(key: key);

  @override
  _Select_Initial_RemindersState createState() =>
      _Select_Initial_RemindersState();
}

class _Select_Initial_RemindersState extends State<Select_Initial_Reminders> {
  @override
  void initState() {
    super.initState();
    for (int index = 0; index < AllCategoryplant.allCategoryplants.length; index++) {
      List<Plantxtimetable> given = [];
      List<Plantxtimetable> toBeGiven = [];
     Categoryplant curr_category = AllCategoryplant.allCategoryplants[index];
      for (var tree in curr_category.timetable) {
        if (DateTime.now()
            .isAfter(widget.plant.dob.add(Duration(days: tree.week * 3)))) {
          given.add(tree);
        }
        if (DateTime.now()
            .isBefore(widget.plant.dob.add(Duration(days: tree.week * 3)))) {
          toBeGiven.add(tree);
        }
      }
      // widget.plant.categoryplants_date_gone.add(Categoryplant(
      //     curr_category.name,
      //     curr_category.code,
      //     curr_category.description,
      //     given,
      //     ));
      widget.plant.categoryplants_to_be_reminded.add( Categoryplant(
          curr_category.name,
          curr_category.code,
          curr_category.description,
          toBeGiven,
       ));
    }
  }

  Widget build(BuildContext context) {
    Map plantData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Color( 0xfffce8dd),
      floatingActionButton: FloatingActionButton(
           backgroundColor: Color(0xffe55d45),
          child: Text('Done'),
          
          onPressed: () {
            widget.plant.makeEvents(widget.plant.categoryplants_to_be_reminded);
            // Navigator.pop(context);
            //Navigator.pop(context);
            Navigator.pop(
              context,
              widget.plant,
            );
          }),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          //MainAxis columnMainAxisSize.min
          children: [
            Container(
              margin: EdgeInsets.only(top: 100.0),
              child: Text('Plant Catagory and Plan Reminders',
                  style: // GoogleFonts.lato(
                      //   textStyle:
                      TextStyle(
                    color: Color(0xff0d4037),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    //  ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffe55d45),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 20, top: 19.0, bottom: 10),
              margin: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: Text(
                  "Reminders for the watering of plant are set. ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xfffce8dd),
                  )),
            ),
            new ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.plant.categoryplants_to_be_reminded.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                     mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      for (var tree
                          in widget.plant.categoryplants_to_be_reminded[index].timetable)
                        new Card(
                          child: new Container(
                            padding: new EdgeInsets.all(10.0),
                            child: new CheckboxListTile(
                                activeColor: Color(  0xff315951),
                                dense: true,
                                //font change
                                title: new Text(
                                  widget.plant.categoryplants_to_be_reminded[index]
                                          .name +
                                      " Day " +
                                      "${tree.position}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5),
                                ),
                                value: tree.setReminder,
                                onChanged: (bool val) {
                                  setState(() {
                                    tree.setReminder = val;
                                  });
                                },
                                subtitle: Text((() {
                                  // your code here
                                  if (tree.isNormal)
                                    return widget.plant
                                        .categoryplants_to_be_reminded[index].code;
                                  else
                                    return widget
                                            .plant
                                            .categoryplants_to_be_reminded[index]
                                            .code +
                                        "\n" +
                                        "This tree is only for specific groups ";
                                }()))),
                          ),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
