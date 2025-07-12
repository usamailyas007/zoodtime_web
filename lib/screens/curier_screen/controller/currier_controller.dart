import 'package:get/get.dart';

class CurrierController extends GetxController {
  var selectedTransportType = ''.obs;

  final selectedCourierStatus = RxnString();

  void selectCourierStatus(String? courier) {
    selectedCourierStatus.value = courier;
  }

  final selectedSalaryStatus = RxnString();

  void selectSalaryStatus(String? salary) {
    selectedSalaryStatus.value = salary;
  }

  final selectedType = RxnString();

  void selectTransportType(String? courier) {
    selectedType.value = courier;
  }


  var curriers = [
    {
      "id": "001",
      "name": "Ali Rahmon",
      "number": "+992 92 111 2233",
      "city": "Dushanbe",
      "transportName": "Motorcycle",
      "salary": "2500 TJS",
      "salaryStatus": "Credited",
      "status": "Active"
    },
    {
      "id": "002",
      "name": "Sara Iqbal",
      "number": "+992 93 555 7788",
      "city": "Khujand",
      "transportName": "Bicycle",
      "salary": "2000 TJS",
      "salaryStatus": "Pending",
      "status": "Suspended"
    },
    {
      "id": "003",
      "name": "Usmon Kamilov",
      "number": "+992 91 987 6543",
      "city": "Kulob",
      "transportName": "Car",
      "salary": "3200 TJS",
      "salaryStatus": "Credited",
      "status": "Active"
    },
    {
      "id": "004",
      "name": "Malika Sadat",
      "number": "+992 93 111 2233",
      "city": "Istaravshan",
      "transportName": "Motorcycle",
      "salary": "2600 TJS",
      "salaryStatus": "Credited",
      "status": "Suspended"
    },
    {
      "id": "005",
      "name": "Rahim Gul",
      "number": "+992 90 333 2211",
      "city": "Bokhtar",
      "transportName": "Van",
      "salary": "3500 TJS",
      "salaryStatus": "Pending",
      "status": "Active"
    },
    {
      "id": "006",
      "name": "Nargis Latif",
      "number": "+992 92 777 8899",
      "city": "Dushanbe",
      "transportName": "Bicycle",
      "salary": "2100 TJS",
      "salaryStatus": "Credited",
      "status": "Active"
    },
    {
      "id": "007",
      "name": "Kamran Shoev",
      "number": "+992 91 444 5566",
      "city": "Tursunzoda",
      "transportName": "Car",
      "salary": "3000 TJS",
      "salaryStatus": "Pending",
      "status": "Suspended"
    },
    {
      "id": "008",
      "name": "Lola Rahimi",
      "number": "+992 93 333 1122",
      "city": "Khujand",
      "transportName": "Scooter",
      "salary": "2400 TJS",
      "salaryStatus": "Credited",
      "status": "Active"
    },
    {
      "id": "009",
      "name": "Asad Umar",
      "number": "+992 92 666 7788",
      "city": "Kulob",
      "transportName": "Truck",
      "salary": "4000 TJS",
      "salaryStatus": "Pending",
      "status": "Suspended"
    },
    {
      "id": "010",
      "name": "Dilshod Hakim",
      "number": "+992 91 111 3344",
      "city": "Dushanbe",
      "transportName": "Motorcycle",
      "salary": "2700 TJS",
      "salaryStatus": "Credited",
      "status": "Active"
    },
    {
      "id": "011",
      "name": "Marzia Jafar",
      "number": "+992 90 888 3344",
      "city": "Panjakent",
      "transportName": "Bicycle",
      "salary": "1900 TJS",
      "salaryStatus": "Pending",
      "status": "Active"
    },
  ].obs;

  var currentPage = 1.obs;
  final int itemsPerPage = 4;
  final int pagesPerGroup = 4;

  var searchQuery = ''.obs;

  List get filteredCurrier {
    if (selectedTransportType.value.isEmpty) return curriers;
    return curriers.where((user) {
      return user['transportName'] == selectedTransportType.value;
    }).toList();
  }

  List get pagedCurrier {
    final filtered = filteredCurrier;

    if (filtered.isEmpty) return [];

    int start = (currentPage.value - 1) * itemsPerPage;
    int end = start + itemsPerPage;
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  int get totalPages => (filteredCurrier.isEmpty)
      ? 1
      : (filteredCurrier.length / itemsPerPage).ceil();

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