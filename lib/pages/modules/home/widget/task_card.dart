import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantme/data/task.dart';
import 'package:plantme/pages/modules/detail/view.dart';
import 'package:plantme/pages/modules/home/controller.dart';
import 'package:plantme/data/utils/extensions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TaskCard extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  TaskCard({Key key,  this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.selectTask(task);
        homeCtrl.selectTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              blurRadius: 7,
              offset: const Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps:
                  homeCtrl.isTodosEmpty(task) ? 1 : (task.todos.length),
              currentStep:
                  homeCtrl.isTodosEmpty(task) ? 0 : homeCtrl.getDoneTodo(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffe55d45).withOpacity(0.5), Color(0xffe55d45)],
              ),
              unselectedGradientColor: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.white],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'FontAwesomeSolid',fontPackage: 'font_awesome_flutter'),
                color:  Color(0xffe55d45),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.0.wp),
                  Text(
                    '${task.todos?.length ?? 0} Task',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color( 0xff0d4037),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
