import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantme/data/utils/extensions.dart';
import 'package:plantme/pages/modules/home/controller.dart';




class TodoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  TodoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
          ? Column(
              children: [
                // Image.asset(
                //   'assets/images/task.jpg',
                //   fit: BoxFit.cover,
                //   width: 65.0.wp,
                // ),
                Text(
                  'Add Task',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0.sp,
                  ),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCtrl.doingTodos.map(
                  (e) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 9.0.wp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (_) => Colors.grey),
                              value: e['done'],
                              onChanged: (value) {
                                homeCtrl.doneTodo(e['title']);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: Text(
                              e['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
                if (homeCtrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  ),
              ],
            ),
    );
  }
}
