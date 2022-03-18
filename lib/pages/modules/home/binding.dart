import 'package:get/get.dart';
import 'package:plantme/data/provider.dart';
import 'package:plantme/data/storage/repository.dart';
import 'package:plantme/pages/modules/home/controller.dart';


class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
