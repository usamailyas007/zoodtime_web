import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/loading.dart';
import '../../../services/user_services.dart';

class StoreController extends GetxController {
  var selectedStatus = 'All'.obs;
  final selectedUserStatus = RxnString();
  UserServices userServices = UserServices();
  var storeNameController = TextEditingController();
  var addressController = TextEditingController();
  var taxIdController = TextEditingController();
  var emailController = TextEditingController();
  var phNumberController = TextEditingController();
  var isLoading = false.obs;
  var isLoading1 = false.obs;

  void selectStatus(String? courier) {
    selectedUserStatus.value = courier;
  }

  var stores = <Map<String, dynamic>>[].obs;

  var currentPage = 1.obs;

  var totalPages = 1.obs;

  final int itemsPerPage = 6;

  final int pagesPerGroup = 6;

  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredStores {
    final query = searchQuery.value.trim().toLowerCase();
    List<Map<String, dynamic>> list = stores.toList();

    if (selectedStatus.value.isNotEmpty &&
        selectedStatus.value != 'All') {
      list = list
          .where((u) => (u['status'] ?? '')
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

  List<Map<String, dynamic>> get pagedStores {
    final list = filteredStores;
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
      getAllStore(context, page: page);
    }
  }

  void goToNextPage(context) {
    if (currentPage.value < totalPages.value) {
      getAllStore(context, page: currentPage.value + 1);
    }
  }

  void goToPreviousPage(context) {
    if (currentPage.value > 1) {
      getAllStore(context, page: currentPage.value - 1);
    }
  }

  void clearFields() {
    storeNameController.clear();
    addressController.clear();
    emailController.clear();
    taxIdController.clear();
    phNumberController.clear();
  }

  addStore(context) async {

    if (storeNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        emailController.text.isEmpty ||
        taxIdController.text.isEmpty ||
        phNumberController.text.isEmpty) {
      showToast(Get.overlayContext!,
          msg: "Please Fill Required Fields", duration: 2);
      return false;
    }

    isLoading.value = true;

    try {
      var data = {
        "storeName": storeNameController.text.trim(),
        "phone": phNumberController.text.trim(),
        "address": addressController.text.trim(),
        "taxId": taxIdController.text.trim(),
        "email": emailController.text.trim(),
      };

      var response = await userServices.addStore(data);

      if (response != null
          // &&
          // response['message'] == "Courier added successfully"
      ) {
        showToast(Get.overlayContext!,
            msg: "Store Added Successfully", duration: 3);
        clearFields();

        final newCourier = Map<String, dynamic>.from(response['store']);

        stores.insert(0, newCourier);

        totalPages.value = (filteredStores.length / itemsPerPage)
            .ceil()
            .clamp(1, double.infinity)
            .toInt();

        currentPage.value = 1;

        return true;
      } else {
        showToast(context,
            msg: response?['message'] ?? "store failed", duration: 2);
        return false;
      }
    } catch (e) {
      log("store error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  getAllStore(context, {int page = 1}) async {
    isLoading1.value = true;
    try {
      var response = await userServices.getAllStore(page: page);
      // log("getAllStore response================>>>>>>>: $response");

      if (response != null) {
        List<Map<String, dynamic>> fetched = List<Map<String, dynamic>>.from(response['stores']);

        stores.value = fetched.toList();
        currentPage.value = response['page'] ?? 1;
        totalPages.value = response['totalPages'] ?? 1;

      } else {
        showToast(context, msg: response?['message'] ?? "Failed to fetch getAllStore", duration: 2);
      }
    } catch (e) {
      log("getAllStore error: $e");
      showToast(context, msg: "Error fetching getAllStore", duration: 2);
    } finally {
      isLoading1.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllStore(Get.context, page: 1);
    });
  }

}