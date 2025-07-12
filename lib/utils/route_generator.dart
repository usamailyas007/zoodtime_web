import 'package:get/get.dart';
import 'package:zoodtime_admin/utils/screen_bindings.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/curier_screen/currier_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import '../screens/job_screen/job_screen.dart';
import '../screens/profile_screen/profile_screen.dart';
import '../screens/return_screen/return_screen.dart';
import '../screens/store_screen/store_screen.dart';
import '../screens/user_screen/user_screen.dart';
import 'app_strings.dart';


class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kAuthScreenRoute, page: () => AuthScreen(), binding: ScreenBindings(),),
      GetPage(name: kDashboardScreenRoute, page: () => DashboardScreen(), binding: ScreenBindings(),),
      GetPage(name: kUserScreenRoute, page: () => UserScreen(), binding: ScreenBindings(),),
      GetPage(name: kCurrierScreenRoute, page: () => CurrierScreen(), binding: ScreenBindings(),),
      GetPage(name: kReturnScreenRoute, page: () => ReturnScreen(), binding: ScreenBindings(),),
      GetPage(name: kProfileScreenRoute, page: () => ProfileScreen(), binding: ScreenBindings(),),
      GetPage(name: kStoreScreenRoute, page: () => StoreScreen(), binding: ScreenBindings(),),
      GetPage(name: kJobScreenRoute, page: () => JobScreen(), binding: ScreenBindings(),),
    ];
  }
}

