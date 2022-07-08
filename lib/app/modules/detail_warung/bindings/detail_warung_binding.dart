import 'package:get/get.dart';

import '../controllers/detail_warung_controller.dart';

class DetailWarungBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWarungController>(
      () => DetailWarungController(),
    );
  }
}
