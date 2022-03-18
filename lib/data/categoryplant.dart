class Plantxtimetable {
  int position;
  int week;
  bool isNormal;
  bool setReminder;

  Plantxtimetable(int position, int week, bool isNormal, bool setReminder) {
    this.isNormal = isNormal;
    this.week = week;
    this.setReminder = setReminder;
    this.position = position;
    
  }
}

class Categoryplant {
  String name;
  String code;
  String description;
  List<Plantxtimetable> timetable;


  Categoryplant(String name, String code, String description, List<Plantxtimetable>  timetable,
     ) {
    this.name = name;
    this.code = code;
    this.timetable = timetable;
    this.description = description;
   
  }
}
