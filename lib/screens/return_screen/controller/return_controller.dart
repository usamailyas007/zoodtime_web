import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../custom_widgets/loading.dart';
import '../../../services/user_services.dart';

class ReturnController extends GetxController {
  var selectedStatus = ''.obs;
  final selectedCourier = ''.obs;
  UserServices userServices = UserServices();
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var couriersName = <String>[].obs;

  void selectCourier(String courier) {
    selectedCourier.value = courier;
  }
  
  var returns = <Map<String, dynamic>>[].obs;

  var currentPage = 1.obs;

  var totalPages = 1.obs;

  final int itemsPerPage = 6;

  final int pagesPerGroup = 6;

  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredReturns {
    final query = searchQuery.value.trim().toLowerCase();
    List<Map<String, dynamic>> list = returns.toList();

    if (selectedStatus.value.isNotEmpty &&
        selectedStatus.value != 'All') {
      list = list
          .where((u) => (u['originalOrder']?['courierStatus'] ?? '')
          .toString()
          .trim()
          .toLowerCase() ==
          selectedStatus.value.toLowerCase())
          .toList();
    }

    if (query.isNotEmpty) {
      list = list
          .where((u) =>
      (u['name'] ?? '').toString().toLowerCase().contains(query) ||
          (u['phone'] ?? '').toString().toLowerCase().contains(query))
          .toList();
    }

    return list;
  }

  List<Map<String, dynamic>> get pagedReturns {
    final list = filteredReturns;
    if (list.isEmpty) return [];

    int start = (currentPage.value - 1) * itemsPerPage;
    if (start >= list.length) return [];

    int end = start + itemsPerPage;
    return list.sublist(start, end > list.length ? list.length : end);
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  void goToPage(int page, context) {
    if (page >= 1 && page <= totalPages.value) {
      currentPage.value = page;
      getAllReturns(context, page: page);
    }
  }

  void goToNextPage(context) {
    if (currentPage.value < totalPages.value) {
      getAllReturns(context, page: currentPage.value + 1);
    }
  }

  void goToPreviousPage(context) {
    if (currentPage.value > 1) {
      getAllReturns(context, page: currentPage.value - 1);
    }
  }

  getAllReturns(context, {int page = 1}) async {
    isLoading.value = true;
    try {
      var response = await userServices.getReturnOrders(page: page);
      // log("getAllStore response================>>>>>>>: $response");

      if (response != null) {
        List<Map<String, dynamic>> fetched = List<Map<String, dynamic>>.from(response['returnOrders']);

        returns.value = fetched.toList();
        currentPage.value = response['page'] ?? 1;
        totalPages.value = response['totalPages'] ?? 1;

      } else {
        showToast(context, msg: response?['message'] ?? "Failed to fetch Returns", duration: 2);
      }
    } catch (e) {
      showToast(context, msg: "Error fetching Returns", duration: 2);
    } finally {
      isLoading.value = false;
    }
  }

  getAllCouriersName(context) async {

    try {
      var response = await userServices.getAllCouriersName();

      if (response != null) {
        List fetched = response['couriers'];

        couriersName.value = fetched.map((e) => e['name'].toString()).toList();

        couriersName.value = fetched
            .map((e) => e['name'].toString())
            .toSet()
            .toList();

      } else {
        showToast(context, msg: response?['message'] ?? "Failed to fetch getAllJobs", duration: 2);
      }

    } catch (e) {
      log("getAllJobs error: $e");
      showToast(context, msg: "Error fetching getAllJobs", duration: 2);
    }
  }


  assignCourier(context,String orderId) async {
    if (selectedCourier.value.isEmpty) {
      showToast(Get.overlayContext!,
          msg: "Please Select Courier", duration: 2);
      return false;
    }

    isLoading1.value = true;

    try {
      var data = {
        "orderId": orderId,
        "courierName": selectedCourier.value,
      };

      var response = await userServices.assignCourier(data);

      if (response != null && response['message'] == "Courier assigned successfully,") {

        int index = returns.indexWhere((job) => job['_id'] == orderId);
        if (index != -1) {
          final updatedJob = Map<String, dynamic>.from(returns[index]);
          updatedJob['originalOrder'] = {'courierStatus': selectedCourier.value};
          returns[index] = updatedJob;
        }

        returns.refresh();


      } else {
        showToast(context, msg: response?['message'] ?? "Failed to assignCourier", duration: 2);
      }

    } catch (e) {
      showToast(context, msg: "Error while assignCourier", duration: 2);
    } finally {
      isLoading1.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllReturns(Get.context, page: 1);
      getAllCouriersName(Get.context,);

    });
  }
}