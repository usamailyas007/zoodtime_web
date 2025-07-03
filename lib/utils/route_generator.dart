import 'package:get/get.dart';
import 'package:zoodtime_admin/utils/screen_bindings.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/dashboard_screen/dashboard_screen.dart';
import 'app_strings.dart';


class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kAuthScreenRoute, page: () => AuthScreen(), binding: ScreenBindings(),),
      GetPage(name: kDashboardScreenRoute, page: () => DashboardScreen(), binding: ScreenBindings(),),
      // GetPage(name: kUserManagementScreenRoute, page: () => UserManagementScreen(), binding: ScreenBindings(),),
      // GetPage(name: kSettingScreenRoute, page: () => SettingScreen(), binding: ScreenBindings(),),
      // GetPage(name: kProfileScreenRoute, page: () => ProfileScreen(), binding: ScreenBindings(),),
      // GetPage(name: kChannelManagementScreenRoute, page: () => ChannelManagementScreen(), binding: ScreenBindings(),),
      // GetPage(name: kVideoManagementScreenRoute, page: () => VideoManagementScreen(), binding: ScreenBindings(),),
    ];
  }
}

