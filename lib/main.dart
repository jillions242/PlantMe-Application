
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:plantme/data/allPlant.dart';
import 'package:plantme/data/storage/services.dart';
import 'package:plantme/pages/addPlant.dart';
import 'package:plantme/pages/calendar_view.dart';
import 'package:plantme/pages/localNotificatioin.dart';
import 'package:plantme/pages/login_screen.dart';
import 'package:plantme/pages/homepage.dart';
import 'package:plantme/pages/modules/home/binding.dart';
import 'package:plantme/pages/modules/home/view.dart';
import 'package:plantme/pages/signUp_screen.dart';
import 'package:plantme/pages/welcome_page.dart';

Future<void> main() async {
 
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'PlantME',
        initialRoute: '/Welcomepage',
        debugShowCheckedModeBanner: false,
        routes: {
          '/addChild': (context) => AddPlant(),
          '/allChildren': (context) => AllPlants(),
          '/calendar_view' : (context) => CalendarScreen(),
          '/login_screen': (context) => LoginScreen(),
          '/signUp_screen': (context) => SignUpScreen(),
         '/localNotif':(context) =>LocalNotification(),
          '/Welcomepage': (context) => Welcomepage(),
          '/home': (context) => HomePage(),
           '/page': (context) => HomePage1(),

        }, 
          initialBinding: HomeBinding(),
         builder: EasyLoading.init(),
        );
  }
}
