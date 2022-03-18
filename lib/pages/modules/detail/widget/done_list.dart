import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantme/pages/modules/home/controller.dart';
import 'package:plantme/data/utils/extensions.dart';





class UndoList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  UndoList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCtrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2.0.wp, horizontal: 5.0.wp),
                    child: Text(
                      'Completed(${homeCtrl.doneTodos.length})',
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Colors.grey,
                      ),
                    )),
                ...homeCtrl.doneTodos.map(
                  (e) {
                    return Dismissible(
                      key: ObjectKey(e),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => homeCtrl.deleteDoneTodo(e['title']),
                      background: Container(
                        color: Colors.red.withOpacity(0.8),
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5.0.wp),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 9.0.wp),
                        child: Row(
                          children: [
                            const SizedBox(
                                width: 20, height: 20, child: Icon(Icons.done)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                              child: Text(
                                e['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList()
              ],
            )
          : Container(),
    );
  }
}
