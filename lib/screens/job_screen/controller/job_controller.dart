import 'package:get/get.dart';

class JobController extends GetxController {
  var selectedStatus = ''.obs;
  final selectedCourier = RxnString();

  void selectCourier(String? courier) {
    selectedCourier.value = courier;
  }
  var jobs = [
    {
      "id": "001",
      "clientName": "Zeba Solutions",
      "courierName": "Mustafa Karimov",
      "deliveryType": "Store-to-Door",
      "fromTo": "Dushanbe → Dushanbe",
      "weight": "2.5kg",
      "type": "Express",
      "status": "Delivered"
    },
    {
      "id": "002",
      "clientName": "Tajik Motors",
      "courierName": "Farid Ahmad",
      "deliveryType": "Door-to-Door",
      "fromTo": "Khujand → Dushanbe",
      "weight": "3.0kg",
      "type": "Standard",
      "status": "Pending"
    },
    {
      "id": "003",
      "clientName": "GreenTech Pvt Ltd",
      "courierName": "Suhrob Aliyev",
      "deliveryType": "Store-to-Store",
      "fromTo": "Kulob → Dushanbe",
      "weight": "1.9kg",
      "type": "Express",
      "status": "In Progress"
    },
    {
      "id": "004",
      "clientName": "Himmat Logistics",
      "courierName": "Zarif Davlatov",
      "deliveryType": "Door-to-Store",
      "fromTo": "Dushanbe → Bokhtar",
      "weight": "4.1kg",
      "type": "Standard",
      "status": "Delivered"
    },
    {
      "id": "005",
      "clientName": "Smart Bazaar",
      "courierName": "Alisher Murodov",
      "deliveryType": "Store-to-Door",
      "fromTo": "Gissar → Dushanbe",
      "weight": "2.3kg",
      "type": "Express",
      "status": "Pending"
    },
    {
      "id": "006",
      "clientName": "Barkat Traders",
      "courierName": "Ravshan Rahimov",
      "deliveryType": "Door-to-Door",
      "fromTo": "Dushanbe → Kulob",
      "weight": "5.0kg",
      "type": "Standard",
      "status": "Delivered"
    },
    {
      "id": "007",
      "clientName": "MetroMart",
      "courierName": "Jamshid Karimov",
      "deliveryType": "Store-to-Store",
      "fromTo": "Khujand → Khujand",
      "weight": "3.7kg",
      "type": "Express",
      "status": "In Progress"
    },
    {
      "id": "008",
      "clientName": "Quick Courier",
      "courierName": "Shavkat Usmonov",
      "deliveryType": "Door-to-Door",
      "fromTo": "Dushanbe → Istaravshan",
      "weight": "2.8kg",
      "type": "Standard",
      "status": "Pending"
    },
    {
      "id": "009",
      "clientName": "Asia Electronics",
      "courierName": "Bekzod Hamidov",
      "deliveryType": "Store-to-Door",
      "fromTo": "Tursunzoda → Dushanbe",
      "weight": "4.5kg",
      "type": "Express",
      "status": "Delivered"
    },
    {
      "id": "010",
      "clientName": "Universal Textiles",
      "courierName": "Ismoil Nazarov",
      "deliveryType": "Door-to-Store",
      "fromTo": "Dushanbe → Gissar",
      "weight": "3.3kg",
      "type": "Standard",
      "status": "In Progress"
    },
  ].obs;


  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredJobs {
    if (selectedStatus.value.isEmpty) return jobs;
    return jobs.where((user) {
      return user['status'] == selectedStatus.value;
    }).toList();
  }

  List get pagedJobs {
    final filtered = filteredJobs;
    if (filtered.isEmpty) return [];
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredJobs.isEmpty)
      ? 1
      : (filteredJobs.length / itemsPerPage).ceil();

  int get currentGroup => ((currentPage.value - 1) / pagesPerGroup).floor();

  List<int> get visiblePageNumbers {
    int startPage = currentGroup * pagesPerGroup + 1;
    int endPage = (startPage + pagesPerGroup - 1).clamp(1, totalPages);
    return List.generate(endPage - startPage + 1, (index) => startPage + index);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) currentPage.value = page;
  }

  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value++;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
    }
  }

}