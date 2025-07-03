import 'package:get/get.dart';

import '../screens/auth/controller/auth_controller.dart';
import '../screens/dashboard_screen/controller/dashboard_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    // Get.lazyPut(() => UserController());
    // Get.lazyPut(() => SettingController());
    // Get.lazyPut(() => ProfileController());
    // Get.lazyPut(() => ChannelController());
    // Get.lazyPut(() => VideoController());
  }
}
