import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:plantme/data/utils/extensions.dart';



class LocalNotification extends StatefulWidget {
  LocalNotification({Key key}) : super(key: key);

  @override
  State<LocalNotification> createState() => _LocalNotificationState();
}

String _selectedParam;
String task;
int val;

class _LocalNotificationState extends State<LocalNotification> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('asset_1');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    // await fltrNotification.show(
    //     0, "Task", "You created a Task", generalNotificationDetails,
    //     payload: "Task");

    // var scheduledTime = DateTime.now().add(Duration(seconds: 5));
    // fltrNotification.schedule(
    //     1, "Times Uppp", task, scheduledTime, generalNotificationDetails);
    var scheduledTime;
    if (_selectedParam == "Hour") {
      scheduledTime = DateTime.now().add(Duration(hours: val));
    } else if (_selectedParam == "Minute") {
      scheduledTime = DateTime.now().add(Duration(minutes: val));
    } else {
      scheduledTime = DateTime.now().add(Duration(seconds: val));
    }

    fltrNotification.schedule(
        1, "PlantMe Reminder", task, scheduledTime, generalNotificationDetails);
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xfffce8dd),
        body: ListView(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 0),
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
                padding: EdgeInsets.all(4.0.wp),
                child: Text(
                  'Reminder ',
                  style: TextStyle(
                    color: Color(0xff0d4037),
                    fontSize: 24.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Text('Reminder ',
              //       style: TextStyle(
              //         color: Color(0xff0d4037),
              //         fontSize: 30.0,
              //         fontWeight: FontWeight.bold,
              //       )),
              // ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onChanged: (_val) {
                    task = _val;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton(
                    value: _selectedParam,
                    items: [
                      DropdownMenuItem(
                        child: Text("Seconds"),
                        value: "Seconds",
                      ),
                      DropdownMenuItem(
                        child: Text("Minutes"),
                        value: "Minutes",
                      ),
                      DropdownMenuItem(
                        child: Text("Hour"),
                        value: "Hour",
                      ),
                    ],
                    hint: Text(
                      "Select Time.",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (_val) {
                      setState(() {
                        _selectedParam = _val;
                      });
                    },
                  ),
                  DropdownButton(
                    value: val,
                    items: [
                      DropdownMenuItem(
                        child: Text("1"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("2"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text("3"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("4"),
                        value: 4,
                      ),
                    ],
                    hint: Text(
                      "Select Value",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onChanged: (_val) {
                      setState(() {
                        val = _val;
                      });
                    },
                  ),
                ],
              ),
              RaisedButton(
                color: Color(0xff0d4037),
                onPressed: _showNotification,
                child: new Text(
                  'Set Reminder',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
           //   LocalNoti2()
            ],
          ),
        ]),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }
}
