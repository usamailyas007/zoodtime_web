import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/loading.dart';
import '../../../services/user_services.dart';


class CurrierController extends GetxController {
  var selectedTransportType = ''.obs;
  UserServices userServices = UserServices();
  var nameController = TextEditingController();
  var cityNameController = TextEditingController();
  var salaryController = TextEditingController();
  var phNumberController = TextEditingController();
  final selectedCourierStatus = ''.obs;
  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  var isUpdateStatus = false.obs;

  void selectCourierStatus(String courier) {
    selectedCourierStatus.value = courier;
  }

  final selectedSalaryStatus = ''.obs;

  void selectSalaryStatus(String salary) {
    selectedSalaryStatus.value = salary;
  }

  final selectedType = RxnString();

  void selectTransportType(String? courier) {
    selectedType.value = courier;
  }

  var couriers = <Map<String, dynamic>>[].obs;

  var currentPage = 1.obs;

  var totalPages = 1.obs;

  final int itemsPerPage = 6;

  final int pagesPerGroup = 6;

  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredCouriers {
    final query = searchQuery.value.trim().toLowerCase();
    List<Map<String, dynamic>> list = couriers.toList();

    if (selectedTransportType.value.isNotEmpty &&
        selectedTransportType.value != 'All') {
      list = list
          .where((u) => (u['transportType'] ?? '')
          .toString()
          .trim()
          .toLowerCase() ==
          selectedTransportType.value.toLowerCase())
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

  List<Map<String, dynamic>> get pagedCouriers {
    final list = filteredCouriers;
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
      getAllCouriers(context, page: page);
    }
  }

  void goToNextPage(context) {
    if (currentPage.value < totalPages.value) {
      getAllCouriers(context, page: currentPage.value + 1);
    }
  }

  void goToPreviousPage(context) {
    if (currentPage.value > 1) {
      getAllCouriers(context, page: currentPage.value - 1);
    }
  }

  void clearFields() {
    nameController.clear();
    cityNameController.clear();
    salaryController.clear();
    phNumberController.clear();
  }

  addCourier(context) async {
    if (nameController.text.isEmpty ||
        cityNameController.text.isEmpty ||
        salaryController.text.isEmpty ||
        phNumberController.text.isEmpty) {
      showToast(Get.overlayContext!,
          msg: "Please Fill Required Fields", duration: 2);
      return false;
    }

    isLoading.value = true;
    try {
      var data = {
        "name": nameController.text.trim(),
        "phone": phNumberController.text.trim(),
        "city": cityNameController.text.trim(),
        "transportType": selectedType.value,
        "salary": salaryController.text.trim(),
      };

      var response = await userServices.addCourier(data);

      if (response != null &&
          response['message'] == "Courier added successfully") {
        showToast(Get.overlayContext!,
            msg: "Courier Added Successfully", duration: 3);
        clearFields();

        final newCourier = Map<String, dynamic>.from(response['courier']);

        couriers.insert(0, newCourier);

        totalPages.value = (filteredCouriers.length / itemsPerPage)
            .ceil()
            .clamp(1, double.infinity)
            .toInt();

        currentPage.value = 1;

        return true;
      } else {
        showToast(context,
            msg: response?['message'] ?? "addCourier failed", duration: 2);
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  resetSalaries(context) async {

    isLoading2.value = true;
    try {

      var response = await userServices.resetCourierSalaries();

      if (response != null
          // &&
          // response['message'] == "Courier added successfully"
      ) {
        showToast(Get.overlayContext!,
            msg: "Salary Statuses Updated Successfully", duration: 3);


        getAllCouriers(Get.context, page: 1);

      } else {
        showToast(context,
            msg: response?['message'] ?? "addCourier failed", duration: 2);
      }
    } catch (e) {
    } finally {
      isLoading2.value = false;
    }
  }

  getAllCouriers(context, {int page = 1}) async {
    isLoading1.value = true;
    try {
      var response = await userServices.getAllCouriers(page: page);

      if (response != null && response['couriers'] != null) {
        List<Map<String, dynamic>> fetched = List<Map<String, dynamic>>.from(response['couriers']);

        couriers.value = fetched.toList();
        currentPage.value = response['page'] ?? 1;
        totalPages.value = response['totalPages'] ?? 1;

      } else {
        showToast(context, msg: response?['message'] ?? "Failed to fetch AllCouriers", duration: 2);
      }
    } catch (e) {
      log("getAllCouriers error: $e");
      showToast(context, msg: "Error fetching getAllCouriers", duration: 2);
    } finally {
      isLoading1.value = false;
    }
  }

  updateStatus(
      context,
      String id,
      String status) async {
    isUpdateStatus.value = true;
    try {

      var data = {
        "entityType": "user",
        "id": id,
        "status": status
      };

      var response = await userServices.toggleStatus(data);

      if (response != null) {
        int index = couriers.indexWhere((item) => item['_id'].toString() == id.toString());

        if (index != -1) {
          couriers[index]['status'] = status;
          couriers.refresh();
        }

        Get.back();

        showToast(Get.overlayContext!, msg: "Status Updated Successfully", duration: 2);
        // return true;

      } else {
        showToast(context, msg: response?['message'] ?? "Status Updating failed", duration: 2);
        // return false;

      }
    } catch (e) {
      log("Status Updating error: $e");
      isUpdateStatus.value = false;
      // return false;
    } finally {
      isUpdateStatus.value = false;
    }
  }

  updateCourierStatus(
      context,
      String courierId,
      String status) async {
    isUpdateStatus.value = true;
    try {

      var data = {
        "courierId": courierId,
        "status": status
      };

      var response = await userServices.updateCourierSalaryStatus(data);

      if (response != null) {
        int index = couriers.indexWhere((item) => item['_id'].toString() == courierId.toString());

        if (index != -1) {
          couriers[index]['salaryStatus'] = status;
          couriers.refresh();
        }

        Get.back();

        showToast(Get.overlayContext!, msg: "Salary Status Updated Successfully", duration: 2);
        // return true;

      } else {
        showToast(context, msg: response?['message'] ?? "Salary Status Updating failed", duration: 2);
        // return false;

      }
    } catch (e) {
      isUpdateStatus.value = false;
      // return false;
    } finally {
      isUpdateStatus.value = false;
    }
  }



  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllCouriers(Get.context, page: 1);
    });
  }

}