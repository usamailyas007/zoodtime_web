import 'package:get/get.dart';

class StoreController extends GetxController {
  var selectedStatus = ''.obs;
  final selectedUserStatus = RxnString();

  void selectStatus(String? courier) {
    selectedUserStatus.value = courier;
  }

  var stores = [
    {
      "id": "001",
      "name": "Ali Rahmon",
      "taxId": "0615611560",
      "phone": "03311610540",
      "email": "abc@gmail.com",
      "address": "Sherozi St. 88, Kulyab",
      "status": "Active"
    },
    {
      "id": "002",
      "name": "Zarif & Sons",
      "taxId": "0845123490",
      "phone": "03312670541",
      "email": "zarifsons@gmail.com",
      "address": "Somoni Ave. 12, Dushanbe",
      "status": "Paused"
    },
    {
      "id": "003",
      "name": "Rahim Traders",
      "taxId": "0978102234",
      "phone": "03319630422",
      "email": "rahimtraders@hotmail.com",
      "address": "Main Bazaar Road, Khujand",
      "status": "Active"
    },
    {
      "id": "004",
      "name": "Metro Market",
      "taxId": "0654321789",
      "phone": "03314520671",
      "email": "metro@gmail.com",
      "address": "Lenin Street, Bokhtar",
      "status": "Paused"
    },
    {
      "id": "005",
      "name": "Taj Superstore",
      "taxId": "0755219087",
      "phone": "03318561230",
      "email": "tajsuper@gmail.com",
      "address": "Victory Square 33, Dushanbe",
      "status": "Active"
    },
    {
      "id": "006",
      "name": "Barkat Mart",
      "taxId": "0623481956",
      "phone": "03311490478",
      "email": "barkatmart@outlook.com",
      "address": "Gafurov St. 14, Kulob",
      "status": "Paused"
    },
    {
      "id": "007",
      "name": "Sino Stores",
      "taxId": "0987123409",
      "phone": "03311780411",
      "email": "sino@company.com",
      "address": "Market Street 7, Hissor",
      "status": "Active"
    },
    {
      "id": "008",
      "name": "Imran Wholesales",
      "taxId": "0876532104",
      "phone": "03317770519",
      "email": "imranw@gmail.com",
      "address": "Commercial Block, Panjakent",
      "status": "Paused"
    },
    {
      "id": "009",
      "name": "Darvoz Depot",
      "taxId": "0612394875",
      "phone": "03312780945",
      "email": "darvoz@store.com",
      "address": "Chorbogh Lane, Darvoz",
      "status": "Paused"
    },
    {
      "id": "010",
      "name": "Nasar General Store",
      "taxId": "0701234890",
      "phone": "03319820345",
      "email": "nasarstore@gmail.com",
      "address": "Navoi Street, Tursunzoda",
      "status": "Active"
    },
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredStores {
    if (selectedStatus.value.isEmpty) return stores;
    return stores.where((user) {
      return user['status'] == selectedStatus.value;
    }).toList();
  }

  List get pagedStores {
    final filtered = filteredStores;
    if (filtered.isEmpty) return [];
    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredStores.isEmpty)
      ? 1
      : (filteredStores.length / itemsPerPage).ceil();

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