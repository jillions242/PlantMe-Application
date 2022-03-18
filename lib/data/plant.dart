import 'dart:io';

import 'package:plantme/data/categoryplant.dart';

File plantImage = new File('assets/child.jpg');

class customMaps {
  DateTime date;
  List<dynamic> arr;
  customMaps(DateTime date, List<dynamic> arr) {
    this.date = date;
    this.arr = arr;
  }
  Map<String, dynamic> toJson() => {
        'date': date,
        'arr': arr,
      };
}

class Plant {
  File photo;
  String name;
  String category;
  DateTime dob;
  List<Categoryplant> categoryplants_to_be_reminded = [];
  Map<DateTime, List<dynamic>> events = {};
  Map<DateTime, List<dynamic>> nextDue = {};


  Plant(String name, DateTime dob, File image,String category) {
    this.dob = dob;
    print(image==null);
    this.photo = image != null?image :plantImage;
    this.name = name;
    this.category = category;
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> arr = [];
    events.forEach((k, v) {
      customMaps obj = customMaps(k, v);
      arr.add(obj.toJson());
    });

    return {
      "dob": dob,
      'name': name,
      'events': arr,
      'category': category,
    };
  }


  Map<DateTime, List<dynamic>> getEventsfromdatabase(List<dynamic> arr ){
    if(arr==null || arr == [])
      return {};
    Map<DateTime, List<dynamic>> events = {} ;
    for(int it = 0;it<arr.length;it++){
      var time = arr[it]['date'];
      var dob = DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
      // print(dob);
      events[dob] = arr[it]['arr'];
    }
    return events ;
  }


  void makeEvents(List<Categoryplant> categoryplants_to_be_reminded) {
    for (int i = 0; i < categoryplants_to_be_reminded.length; i++) {
      for (int j = 0; j < categoryplants_to_be_reminded[i].timetable.length; j++) {
        if (this.events[this.dob.add(Duration(
                days: categoryplants_to_be_reminded[i].timetable[j].week * 3))] ==
            null)
          this.events[this.dob.add(
              Duration(days: categoryplants_to_be_reminded[i].timetable[j].week * 3))] = [
            categoryplants_to_be_reminded[i].code +
                " - watering Day " +
                "${categoryplants_to_be_reminded[i].timetable[j].position}"
          ];
        else {
          this
              .events[this.dob.add(
                  Duration(days: categoryplants_to_be_reminded[i].timetable[j].week * 3))]
              .add(categoryplants_to_be_reminded[i].code +
                  " - watering Day " +
                  "${categoryplants_to_be_reminded[i].timetable[j].position}");
        }
      }
    }
  }

  void getNextDuecategoryplants() {
    List sortedKeys = this.events.keys.toList()
      ..sort((a, b) {
        return (a.compareTo(b));
      });
    DateTime nearest = sortedKeys[0];
    for (var key in events.keys) {
      if (key == nearest) {
        this.nextDue = {nearest: events[nearest]};
        print(nextDue);
      }
    }
  }

 


}
