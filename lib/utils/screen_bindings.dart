import 'package:get/get.dart';
import 'package:zoodtime_admin/screens/curier_screen/controller/currier_controller.dart';
import 'package:zoodtime_admin/screens/return_screen/controller/return_controller.dart';
import 'package:zoodtime_admin/screens/store_screen/controller/store_controller.dart';

import '../screens/auth/controller/auth_controller.dart';
import '../screens/dashboard_screen/controller/dashboard_controller.dart';
import '../screens/job_screen/controller/job_controller.dart';
import '../screens/profile_screen/controller/profile_controller.dart';
import '../screens/user_screen/controller/user_controller.dart';

class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => CurrierController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ReturnController());
    Get.lazyPut(() => StoreController());
    Get.lazyPut(() => JobController());
  }
}
