import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:plantme/constants/custonPainer.dart';
import 'package:plantme/data/allPlant.dart';
import 'package:plantme/data/plant.dart';
import 'package:plantme/pages/addPlant.dart';
import 'package:plantme/data/utils/extensions.dart';

import 'package:table_calendar/table_calendar.dart';

int userChoice = 0;

class Mapping {
  Plant plant;
  int index;
  Mapping(int index, Plant child) {
    this.index = index;
    this.plant = child;
  }
}

class CalendarScreen extends StatefulWidget {
  final List<Plant> plants;
  const CalendarScreen({Key key, @required this.plants}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState(plants);
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  final List<Plant> plants;
  _CalendarScreenState(this.plants);
   int currentIndex = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = widget.plants == null ? {} : widget.plants[0].events;
    _selectedEvents = [];
  }

  @override
  Widget build(BuildContext context) {
    
    _showAddDialog() async {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Select Plant',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          ShowPlants(plants),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: FloatingActionButton.extended(
                                backgroundColor: Color(0xff0d4037),
                                key: Key('Submit'),
                                label: Text('Go'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _events = widget.plants == null
                                        ? {}
                                        : widget.plants[userChoice].events;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
    }
final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffe55d45),
      floatingActionButton: Container(
        height: 50.0,
        width: 200.0,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xff0d4037),
          //icon: Icon(Icons.child_care),
          label: Text("Select Plant"),
          onPressed: _showAddDialog,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBar(
                  backgroundColor: Color(0xffe55d45),
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
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'Calendar',
              style: TextStyle(
                color: Color( 0xfffce8dd),
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
            // Container(
            //   padding: EdgeInsets.all(10),
            //   margin: EdgeInsets.all(50),
            //   child: Text('Calendar',
            //       style: TextStyle(
            //         color: Color(0xfffce8dd),
            //         fontSize: 30.0,
            //         fontWeight: FontWeight.bold,
            //       )),
            // ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xfffce8dd),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  TableCalendar(
                    events: _events,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                        todayColor: Color(0xff315951),
                        selectedColor: Colors.greenAccent,
                        todayStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    onDaySelected: (date, events, _) {
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders(
                      // Selected Date
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xffffb179),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      // Today date
                      todayDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xff315951),
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    calendarController: _controller,
                  ),
          
                ],
              ),
            ),
            ..._selectedEvents.map(
              (event) => ListTile(
                tileColor: Color(0xfffce8dd),
                //leading: Icon(Icons.add_alarm),
                trailing: Text('For ' + widget.plants[userChoice].name),
                title: Text(
                  event,
                  style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),
    ));
  }
}

// This class is used to display a list of structures in dialogue box  preceded by the radio buttons
class ShowPlants extends StatefulWidget {
  final List<Plant> plants;
  const ShowPlants(this.plants);

  @override
  _ShowPlantsState createState() => _ShowPlantsState();
}

class _ShowPlantsState extends State<ShowPlants> {
  int choosenIndex = 0;
  List<Mapping> choices = new List<Mapping>();

  @override
  void initState() {
    super.initState();
    userChoice =
        0; // By default the first structure will be displayed as selected  .
    for (int i = 0; i < widget.plants.length; i++) {
      choices.add(new Mapping(i, widget.plants[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      // Wraping ListView inside Container to assign scrollable screen a height and width
      width: screenWidth / 2,
      height: screenHeight / 3,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: choices
            .map((entry) => RadioListTile(
                  key: Key('Child ${entry.index}'),
                  title: Text('${entry.plant.name}'),
                  groupValue: choosenIndex,
                  activeColor: Colors.blue[500],
                  value: entry.index,
                  onChanged: (value) {
                    // A radio button gets selected only when groupValue is equal to value of the respective radio button
                    setState(() {
                      userChoice = value;
                      choosenIndex = value;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
