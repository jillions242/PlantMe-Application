import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:get/get.dart';

import 'package:plantme/constants/colors.dart';
import 'package:plantme/data/task.dart';
import 'package:plantme/pages/modules/home/controller.dart';
import 'package:plantme/pages/modules/home/widget/add_card.dart';
import 'package:plantme/pages/modules/home/widget/add_dialog.dart';
import 'package:plantme/pages/modules/home/widget/task_card.dart';
import 'package:plantme/pages/modules/report/view.dart';
import 'package:plantme/data/utils/extensions.dart';

class HomePage1 extends GetView<HomeController> {
  const HomePage1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Color( 0xfffce8dd),
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: [
            
            homePage(context),
            ReportPage(),
          ],
        ),
        floatingActionButton: 
        
        DragTarget<Task>(
          builder: (context, accepted, rejected) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor:  controller.deleting.value ?  Color(  0xff0d4037) : Color(0xffe55d45),
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo('Please create your task type');
                  }
                },
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                ),
              ),
            );
          },
          onAccept: (task) {
            controller.deleteTask(task);
            EasyLoading.showSuccess('Delete success');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) => controller.setTabIndex(index),
          currentIndex: controller.tabIndex.value,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Padding(
                padding: EdgeInsets.only(right: 15.0.wp),
                child: const Icon(
                  Icons.apps,
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: 'Report',
              icon: Padding(
                padding: EdgeInsets.only(left: 15.0.wp),
                child: const Icon(
                  Icons.data_usage,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget homePage(context) {
    return SafeArea(
      
      child: ListView(
        children: [
          Container(
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
              'My Lists',
              style: TextStyle(
                color: Color( 0xff0d4037),
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            crossAxisCount: 2,
            children: [
              ...controller.tasks
                  .map((e) => LongPressDraggable<Task>(
                      onDragStarted: () => controller.setDeleting(true),
                      onDraggableCanceled: (_, __) =>
                          controller.setDeleting(false),
                      onDragEnd: (_) => controller.setDeleting(false),
                      data: e,
                      feedback: Opacity(opacity: 0.8, child: TaskCard(task: e)),
                      child: TaskCard(task: e)))
                  .toList(),
              AddCard(),
            ],
          ),
        ],
      ),
    );
  }
}
