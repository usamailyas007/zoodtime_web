import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/loading.dart';
import '../../../services/user_services.dart';

class UserController extends GetxController {
  var selectedAccountType = 'All'.obs;
  final selectedStatus = RxnString();
  var nameController = TextEditingController();
  var companyNameController = TextEditingController();
  var taxIdController = TextEditingController();
  var phNumberController = TextEditingController();
  var isLoading = false.obs;
  var isEntityDelete = false.obs;
  var isUpdateStatue = false.obs;
  var isLoading1 = false.obs;
  UserServices userServices = UserServices();
  var users = <Map<String, dynamic>>[].obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  final int itemsPerPage = 6;

  void selectStatus(String? courier) {
    selectedStatus.value = courier;
  }

  final int pagesPerGroup = 6;

  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredUsers {
    final query = searchQuery.value.trim().toLowerCase();
    List<Map<String, dynamic>> list = users;

    switch (selectedAccountType.value.toLowerCase()) {
      case 'active':
        list = list.where((u) => (u['status'] ?? '').toString().toLowerCase() == 'active').toList();
        break;
      case 'suspended':
        list = list.where((u) => (u['status'] ?? '').toString().toLowerCase() == 'suspended').toList();
        break;
      case 'all':
      default:
      // keep all users
        break;
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

  List<Map<String, dynamic>> get pagedUsers {
    final list = filteredUsers;
    if (list.isEmpty) return [];

    int start = (currentPage.value - 1) * itemsPerPage;
    if (start >= list.length) return [];

    int end = start + itemsPerPage;
    return list.sublist(start, end > list.length ? list.length : end);
  }

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  void clearFields() {
    nameController.clear();
    companyNameController.clear();
    taxIdController.clear();
    phNumberController.clear();
  }

  void goToPage(int page, context) {
    if (page >= 1 && page <= totalPages.value) {
      getUsers(context, page: page);
    }
  }

  void goToNextPage(context) {
    if (currentPage.value < totalPages.value) {
      getUsers(context, page: currentPage.value + 1);
    }
  }

  void goToPreviousPage(context) {
    if (currentPage.value > 1) {
      getUsers(context, page: currentPage.value - 1);
    }
  }

  addBusiness(context) async {
    if (nameController.text.isEmpty ||
        companyNameController.text.isEmpty ||
        taxIdController.text.isEmpty ||
        phNumberController.text.isEmpty) {
      showToast(Get.overlayContext!, msg: "Please Fill Required Fields", duration: 2);
      return false;
    }

    isLoading.value = true;
    try {
      var data = {
        "name": nameController.text.trim(),
        "companyName": companyNameController.text.trim(),
        "taxId": taxIdController.text.trim(),
        "phone": phNumberController.text.trim(),
      };


      var response = await userServices.addCompany(data);

      if (response != null && response['message'] == "Company registered successfully") {
        showToast(Get.overlayContext!, msg: "Business Added Successfully", duration: 3);
        clearFields();

        final newCompany = Map<String, dynamic>.from(response['company']);

        if (currentPage.value == 1) {
          users.insert(0, newCompany);

          if (users.length > itemsPerPage) {
            users.removeLast();
          }
        }
        return true;

      } else {
        showToast(context, msg: response?['message'] ?? "addBusiness failed", duration: 2);
        return false;

      }
    } catch (e) {
      log("addBusiness error: $e");
      return false;

    } finally {
      isLoading.value = false;

    }
  }

  deleteEntity(context, String id, String entityType, List<Map<String, dynamic>> list) async {
    isEntityDelete.value = true;
    try {
      var data = {
        "entityType": entityType,
        "id": id,
      };

      var response = await userServices.deleteEntity(data);

      if (response != null) {
        list.removeWhere((item) => item['_id'].toString() == id.toString());
        showToast(Get.overlayContext!, msg: "Item Deleted Successfully", duration: 2);
        return true;

      } else {
        showToast(context, msg: response?['message'] ?? "deletion failed", duration: 2);
        return false;

      }
    } catch (e) {
      return false;
    } finally {
      isEntityDelete.value = false;
    }
  }

  updateStatus(context, String id, String entityType, RxList<Map<String, dynamic>> list, String status) async {
    isUpdateStatue.value = true;
    try {
      var data = {
        "entityType": entityType,
        "id": id,
        "status": status
      };

      var response = await userServices.toggleStatus(data);

      if (response != null) {
        int index = list.indexWhere((item) => item['_id'].toString() == id.toString());

        if (index != -1) {
          list[index]['status'] = status;
          list.refresh();
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
      isUpdateStatue.value = false;
      // return false;
    } finally {
      isUpdateStatue.value = false;
    }
  }

  getUsers(context, {int page = 1}) async {
    isLoading1.value = true;
    try {
      var response = await userServices.getCompanies(page: page);

      if (response != null && response['users'] != null) {
        users.value = List<Map<String, dynamic>>.from(response['users']);

        log("users.value=====================${users.value}");

        currentPage.value = response['page'] ?? 1;
        totalPages.value = response['totalPages'] ?? 1;

      } else {
        showToast(context, msg: response?['message'] ?? "Failed to fetch Users", duration: 2);
      }
    } catch (e) {
      showToast(context, msg: "Error fetching businesses", duration: 2);
    } finally {
      isLoading1.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUsers(Get.context, page: 1);
    });
  }

}