import 'package:get/get.dart';

import '../controllers/edit_warung_controller.dart';

class EditWarungBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditWarungController>(
      () => EditWarungController(),
    );
  }
}
