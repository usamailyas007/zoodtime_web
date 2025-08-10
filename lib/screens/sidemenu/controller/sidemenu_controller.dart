import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoodtime_admin/utils/app_strings.dart';

import '../../../utils/session_storage.dart';
import '../../../utils/session_storage_stub.dart';

class SideMenuController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final SessionStorage _storage = getSessionStorage();
  final String _storageKey = 'side_menu_selected_index';

  final List<String> routes = [
    kDashboardScreenRoute,
    kUserScreenRoute,
    kCurrierScreenRoute,
    kJobScreenRoute,
    kStoreScreenRoute,
    kReturnScreenRoute,
    kProfileScreenRoute,
  ];

  @override
  void onInit() {
    super.onInit();
    final saved = _storage.getItem(_storageKey);
    final idx = saved != null ? int.tryParse(saved) ?? 0 : 0;
    selectedIndex.value = idx;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final current = Get.currentRoute;
      if (idx != 0 && current != routes[idx]) {
        _navigateToIndex(idx, push: false);
      }
    });
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    _storage.setItem(_storageKey, index.toString());

    Future.microtask(() {
      final current = Get.currentRoute;
      final target = (index >= 0 && index < routes.length) ? routes[index] : null;
      if (target != null && current != target) {
        if (Scaffold.of(Get.context!).isDrawerOpen) {
          Get.back(); // close drawer first
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _navigateToIndex(index);
          });
        } else {
          _navigateToIndex(index);
        }
      }
    });
  }

  void _navigateToIndex(int index, {bool push = true}) {
    if (index < 0 || index >= routes.length) return;
    final route = routes[index];
    if (push) {
      Get.toNamed(route);
    } else {
      Get.offAllNamed(route);
    }
  }

  Future<void> resetSelection() async {
    selectedIndex.value = 0;
    await _storage.removeItem(_storageKey);
  }
}
