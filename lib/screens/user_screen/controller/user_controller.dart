import 'package:get/get.dart';

class UserController extends GetxController {
  var selectedAccountType = 'Individual'.obs;
  final selectedStatus = RxnString();

  void selectStatus(String? courier) {
    selectedStatus.value = courier;
  }

  var users = [
    {
      "id": "001",
      "name": "Ali Rahmon",
      "number": "+992 92 111 2233",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Active"
    },
    {
      "id": "002",
      "name": "Sara Khan",
      "number": "+92 300 4567890",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Suspended"
    },
    {
      "id": "003",
      "name": "Ahmad Raza",
      "number": "+92 333 1234567",
      "companyName": "TechSoft Ltd.",
      "taxId": "TX-90871",
      "accountType": "Business",
      "status": "Active"
    },
    {
      "id": "004",
      "name": "Mehreen Fatima",
      "number": "+92 301 7896543",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Suspended"
    },
    {
      "id": "005",
      "name": "Tariq Bashir",
      "number": "+92 322 4567890",
      "companyName": "Alpha Traders",
      "taxId": "TX-55521",
      "accountType": "Business",
      "status": "Active"
    },
    {
      "id": "006",
      "name": "Nadia Yusuf",
      "number": "+92 345 2223344",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Suspended"
    },
    {
      "id": "007",
      "name": "Zain Ul Abideen",
      "number": "+92 306 9876543",
      "companyName": "Zain Logistics",
      "taxId": "TX-77890",
      "accountType": "Business",
      "status": "Active"
    },
    {
      "id": "008",
      "name": "Faiza Mehmood",
      "number": "+92 300 4433221",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Suspended"
    },
    {
      "id": "009",
      "name": "Rashid Qamar",
      "number": "+92 321 9988776",
      "companyName": "Qamar Enterprises",
      "taxId": "TX-44123",
      "accountType": "Business",
      "status": "Suspended"
    },
    {
      "id": "010",
      "name": "Lubna Ali",
      "number": "+92 345 1122334",
      "companyName": "—",
      "taxId": "—",
      "accountType": "Individual",
      "status": "Active"
    },
    {
      "id": "011",
      "name": "Hamza Iqbal",
      "number": "+92 336 8877665",
      "companyName": "H-Tech Solutions",
      "taxId": "TX-12089",
      "accountType": "Business",
      "status": "Active"
    },
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredUsers {
    return users
        .where((user) =>
    (selectedAccountType.value == 'All' ||
        user['accountType'] == selectedAccountType.value))
        .toList();
  }

  List get pagedUsers {
    final filtered = filteredUsers;

    if (filtered.isEmpty) return [];

    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredUsers.isEmpty)
      ? 1
      : (filteredUsers.length / itemsPerPage).ceil();

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