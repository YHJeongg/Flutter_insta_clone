import 'package:get/instance_manager.dart';
import 'package:insta_clone_app/src/controller/bottom_nav_controller.dart';

import '../controller/auth_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
