import 'package:get/get.dart';

class ReturnController extends GetxController {
  var selectedStatus = ''.obs;
  final selectedCourier = RxnString();

  void selectCourier(String? courier) {
    selectedCourier.value = courier;
  }
  var returns = [
    {
      "id": "001",
      "clientName": "Zeba Solutions",
      "fromTo": "Dushanbe → Dushanbe",
      "weight": "2.5kg",
      "status": "Delivered"
    },
    {
      "id": "002",
      "clientName": "TechPoint Ltd",
      "fromTo": "Khorog → Dushanbe",
      "weight": "1.8kg",
      "status": "Pending"
    },
    {
      "id": "003",
      "clientName": "Green Valley",
      "fromTo": "Dushanbe → Bokhtar",
      "weight": "3.2kg",
      "status": "In Progress"
    },
    {
      "id": "004",
      "clientName": "LogiCore Pvt",
      "fromTo": "Khujand → Dushanbe",
      "weight": "2.0kg",
      "status": "Delivered"
    },
    {
      "id": "005",
      "clientName": "SkyNet Express",
      "fromTo": "Dushanbe → Kulob",
      "weight": "2.7kg",
      "status": "Pending"
    },
    {
      "id": "006",
      "clientName": "FastTrack Logistics",
      "fromTo": "Panjakent → Dushanbe",
      "weight": "3.9kg",
      "status": "In Progress"
    },
    {
      "id": "007",
      "clientName": "EcoTrans Co",
      "fromTo": "Dushanbe → Istaravshan",
      "weight": "1.5kg",
      "status": "Delivered"
    },
    {
      "id": "008",
      "clientName": "NextGen Movers",
      "fromTo": "Dushanbe → Khujand",
      "weight": "2.8kg",
      "status": "Pending"
    },
    {
      "id": "009",
      "clientName": "Unity Cargo",
      "fromTo": "Tursunzoda → Dushanbe",
      "weight": "3.0kg",
      "status": "In Progress"
    },
    {
      "id": "010",
      "clientName": "PrimeShip LLC",
      "fromTo": "Dushanbe → Gissar",
      "weight": "2.2kg",
      "status": "Delivered"
    },
  ].obs;


  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredReturns {
    if (selectedStatus.value.isEmpty) return returns;
    return returns.where((user) {
      return user['status'] == selectedStatus.value;
    }).toList();
  }

  List get pagedReturns {
    final filtered = filteredReturns;
    if (filtered.isEmpty) return [];
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredReturns.isEmpty)
      ? 1
      : (filteredReturns.length / itemsPerPage).ceil();

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