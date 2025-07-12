import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/field_container.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});


  Widget insightContainer(title, detail, icon,{bool isDonation = false}) {
    return Container(
      width: 296.w,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: kGrey100
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 20.w
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18.h,
              children: [
                Text(
                  detail,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  title,
                  style: AppStyles.blackTextStyle().copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: kGreyShade11Color.withOpacity(0.12),
                    blurRadius: 10,
                    spreadRadius: 0
                  )
                ]
              ),
              child: Center(child: SvgPicture.asset(icon,height: 24,width: 24,)),
            )
          ],
        ),
      ),
    );
  }

  approvalDialog() {
    return CustomDialog(
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 69),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: kPrimaryColor, width: 0.5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            size: 16,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Text(
                    "Application Details",
                    style: AppStyles.blackTextStyle().copyWith(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 34.h),
              Text(
                "Contact Information",
                style: AppStyles.blackTextStyle().copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
              Column(
                spacing: 16.h,
                children: [
                  fieldContainer("Tayyaba"),
                  fieldContainer("tayyaba@gmail.com"),
                  fieldContainer("+92123456789"),
                ],
              ),
              SizedBox(height: 40.h),

            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SideMenu(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(36.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  kWelcomeAdmin,
                                  style: AppStyles.blackTextStyle()
                                      .copyWith(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                Spacer(),
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: kBorderColor,
                                      width: 0.6
                                    )
                                  ),
                                  child: Center(child: SvgPicture.asset(kNotiIcon,height: 15,width: 15,)),
                                ),
                                SizedBox(width: 12.w,),
                                SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(kPersonImage,fit: BoxFit.cover,)),
                                )
                              ],
                            ),
                            SizedBox(height: 32.h),
                            Row(
                              children: [
                                insightContainer(
                                  "Total Revenue",
                                  "23 TJS",
                                  kCurrencyIcon,
                                ),
                                SizedBox(width: 24.w,),
                                insightContainer(
                                  "Total Users",
                                  "89,935",
                                  kDoubleUserIcon,
                                ),
                                SizedBox(width: 24.w,),
                                insightContainer(
                                  "Total Couriers",
                                  "89,935",
                                  kUserIcon1,
                                ),
                              ],
                            ),
                            SizedBox(height: 47.h),
                            Container(
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Text(
                                        "Revenue",
                                        style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                  fontSize: 24.sp,
                                                  fontWeight:
                                                      FontWeight.w600,
                                                ),
                                      ),
                                      Row(
                                        children: [
                                          Obx(() => PopupMenuButton<String>(
                                            onSelected: (value) {
                                              controller.updateBarChartByDayRange(value);
                                            },
                                            offset: Offset(0, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            color: kWhiteColor,
                                            itemBuilder: (context) => [
                                              PopupMenuItem(value: 'Last 7 Days', child: Text('Last 7 Days',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'Last 14 Days', child: Text('Last 14 Days',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'Last 30 Days', child: Text('Last 30 Days',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                            ],
                                            child: Row(
                                              children: [
                                                Text(
                                                  controller.selectedDayRange.value,
                                                  style: AppStyles.blackTextStyle().copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Icon(Icons.keyboard_arrow_down, size: 15),
                                              ],
                                            ),
                                          )),                                              ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 56.h),
                                  Obx(
                                        () => SizedBox(
                                      height: 350.h,
                                      child: BarChart(
                                        BarChartData(
                                          alignment: BarChartAlignment.spaceAround,
                                          barTouchData: BarTouchData(enabled: false),
                                          titlesData: FlTitlesData(
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 45.w,
                                                interval: 20,
                                                getTitlesWidget: (value, meta) {
                                                  return Text(
                                                    '${value.toInt()}k',
                                                    style: AppStyles.blackTextStyle().copyWith(
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w400,
                                                      color: kGreyShade11Color,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                interval: 1,
                                                getTitlesWidget: (value, meta) {
                                                  final int index = value.toInt();
                                                  final data = controller.barChartData;
                                                  if (index < data.length) {
                                                    return Text(
                                                      data[index].label,
                                                      style: AppStyles.blackTextStyle().copyWith(
                                                        fontSize: 13.sp,
                                                        color: kGreyShade11Color,
                                                      ),
                                                    );
                                                  }
                                                  return const SizedBox.shrink();
                                                },
                                              ),
                                            ),
                                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          ),
                                          gridData: FlGridData(show: false),
                                          borderData: FlBorderData(show: false),
                                          barGroups: List.generate(controller.barChartData.length, (index) {
                                            final data = controller.barChartData[index];
                                            return BarChartGroupData(
                                              x: index,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: data.value,
                                                  color: kPrimaryColor,
                                                  width: 14,
                                                  borderRadius: BorderRadius.circular(20),
                                                  backDrawRodData: BackgroundBarChartRodData(
                                                    show: true,
                                                    toY: data.max,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                                          maxY: controller.barChartData.map((e) => e.max).reduce((a, b) => a > b ? a : b),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
