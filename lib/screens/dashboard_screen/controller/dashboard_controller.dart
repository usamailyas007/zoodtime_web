import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../../../services/user_services.dart';

class DashboardController extends GetxController {
  var isMonthly = true.obs;
  var isMonthly1 = true.obs;
  var selectedStatus = 'Submitted'.obs;
  var selectedDayRange = 'Last 7 Days'.obs;
  UserServices userServices = UserServices();
  var totalUsers = '--'.obs;
  var totalRevenue = '--'.obs;
  var totalCouriers = '--'.obs;

  void updateStatus(String status) {
    selectedStatus.value = status;
  }

  final List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ];

  final List<String> weekDays = [
    "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"
  ];

  var barChartData = <BarChartModel>[].obs;

  List<BarChartModel> _getWeeklyBarData() {
    return [
      BarChartModel(label: 'Mon', value: 70, max: 100),
      BarChartModel(label: 'Tue', value: 80, max: 100),
      BarChartModel(label: 'Wed', value: 50, max: 100),
      BarChartModel(label: 'Thu', value: 30, max: 100),
      BarChartModel(label: 'Fri', value: 90, max: 100),
      BarChartModel(label: 'Sat', value: 60, max: 100),
      BarChartModel(label: 'Sun', value: 40, max: 100),
    ];
  }

  void updateBarChartByDayRange(String range) {
    selectedDayRange.value = range;

    switch (range) {
      case 'Last 7 Days':
        barChartData.value = _getWeeklyBarData();
        break;
      case 'Last 14 Days':
        barChartData.value = _get14DayBarData();
        break;
      case 'Last 30 Days':
        barChartData.value = _get30DayBarData();
        break;
    }
  }

  List<BarChartModel> _get14DayBarData() {
    return List.generate(7, (i) {
      return BarChartModel(
        label: weekDays[i],
        value: ((i + 1) * 10 + 20) % 100.toDouble(),
        max: 100,
      );
    });
  }

  List<BarChartModel> _get30DayBarData() {
    return List.generate(7, (i) {
      return BarChartModel(
        label: weekDays[i],
        value: ((i + 1) * 15 + 10) % 100.toDouble(),
        max: 100,
      );
    });
  }


  getUserStats() async {
    try {
      var response = await userServices.getUserStats();

      if (response != null) {

        totalUsers.value = response['totalUsers'].toString();
        totalCouriers.value = response['totalCouriers'].toString();
        // totalRevenue.value = response['totalRevenue'].toString();

        update();
      } else {
        log("User is Null============");
      }

    } catch (e) {
      log("App settings error: $e");
    }
  }


  @override
  void onInit() {
    super.onInit();
    barChartData.value = _getWeeklyBarData();
    getUserStats();
    // selectMonthly1();
  }
}


class BarChartModel {
  final String label;
  final double value;
  final double max;

  BarChartModel({required this.label, required this.value, required this.max});
}