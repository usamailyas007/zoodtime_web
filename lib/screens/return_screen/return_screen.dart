import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoodtime_admin/custom_widgets/custom_dialog.dart';
import 'package:zoodtime_admin/custom_widgets/delete_dialog.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/return_controller.dart';

class ReturnScreen extends GetView<ReturnController> {
  const ReturnScreen({super.key});

  assignCurrier(){
    return CustomDialog(
      width: 900.w,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Assign Courier",style: AppStyles.blackTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w600),),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.close,color: kSecondaryColor,size: 20,)),
                  )
                ],
              ),
              SizedBox(height: 32.h,),
              Text("Couriers",style: AppStyles.blackTextStyle()),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 40.h,
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedCourier.value,
                    dropdownColor: kWhiteColor,
                    hint: Text("Select couriers here",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                    decoration: InputDecoration(
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: kBorderColor1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: kBorderColor1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: kBorderColor1
                        ),
                      ),
                    ),
                    items: ["Courier 1", "Courier 2"]
                        .map((courier) => DropdownMenuItem<String>(
                      value: courier,
                      child: Text(courier,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectCourier(value!);
                    },
                  );
                }),
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){},width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  CustomButton(title: "Assign Courier", onTap: (){},width: 134.w,height: 40.h,textSize: 14.sp,),
                ],
              ),
            ],
          ),
        )
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
                                  kManageReturns,
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
                                Container(
                                  height: 70.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 0.6,
                                        color: kBorderColor1
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                                        child: SvgPicture.asset(kFilterIcon,height: 20,width: 20,),
                                      ),
                                      Container(
                                        height: 70.h,
                                        width: 0.3,
                                        color: kBorderColor2,

                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                                        child: Text(
                                          "Filter By",
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 70.h,
                                        width: 0.3,
                                        color: kBorderColor2,

                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                                        child: Row(
                                          children: [
                                            Obx(() => PopupMenuButton<String>(
                                              onSelected: (value) {
                                                controller.selectedStatus.value = value;
                                                controller.currentPage.value = 1;                                              },
                                              offset: Offset(0, 40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              color: kWhiteColor,
                                              itemBuilder: (context) => [
                                                PopupMenuItem(value: 'Delivered', child: Text('Delivered',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'Pending', child: Text('Pending',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'In Progress', child: Text('In Progress',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              ],
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.selectedStatus.value.isEmpty
                                                        ? 'Status'
                                                        : controller.selectedStatus.value,
                                                    style: AppStyles.blackTextStyle().copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  ),
                                                  Icon(Icons.keyboard_arrow_down, size: 15),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 32.h),
                            Obx(() => Stack(
                              children: [
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: kBorderColor1
                                      )
                                  ),
                                  child: DataTable(
                                    columnSpacing: 0,
                                    headingRowHeight: 70,
                                    dividerThickness: 0,
                                    columns: [
                                      DataColumn(
                                        label: Flexible(
                                          child: Text(
                                            "Order ID",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text(
                                            "Client Name",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text(
                                            "From → To",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Flexible(
                                          child: Text(
                                            "Weight",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        headingRowAlignment:
                                        MainAxisAlignment.center,
                                        label: Flexible(
                                          child: Text(
                                            "Status",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        headingRowAlignment:
                                        MainAxisAlignment.center,
                                        label: Flexible(
                                          child: Text(
                                            "Actions",
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style:
                                            AppStyles.blackTextStyle()
                                                .copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: kBlueColor
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: controller.pagedReturns.asMap().entries.map((entry) {
                                      final i = entry.key;
                                      final user = entry.value;
                                      return _buildDataRow(
                                          i,
                                          user['id']!,
                                          user['clientName']!,
                                          user['fromTo']!,
                                          user['weight']!,
                                          user['status']!,
                                          context
                                      );
                                    }).toList(),
                                    dataRowMaxHeight: 70,
                                  ),
                                ),
                              ],
                            ),),
                            SizedBox(height: 35.h,),
                            Obx(() {
                              if (controller.filteredReturns.isEmpty) {
                                return const SizedBox();
                              }

                              return CustomPagination(
                                currentPage: controller.currentPage.value,
                                visiblePages: controller.visiblePageNumbers,
                                onPrevious: controller.goToPreviousPage,
                                onNext: controller.goToNextPage,
                                onPageSelected: controller.goToPage,
                              );
                            }),
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

  DataRow _buildDataRow(int i,String id, String name, String fromTo ,String weight,String status, context) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.transparent),
      cells: [
        DataCell(
            Text(
              id,
              textAlign: TextAlign.center,
              style: AppStyles.blackTextStyle()
                  .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
            )),
        DataCell(Text(
          name,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          fromTo,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          weight,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(
            Center(child: CustomButton(
              title: status,
              onTap: (){},
              height: 30.h,
              width: 130.w,
              textSize: 12.sp,
              borderRadius: 8,
              fontWeight: FontWeight.w600,
              color: status == "Delivered" ?
              kPrimaryColor :
              status == "Pending" ? kOrangeColor :
              kLightBlueColor,))
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(assignCurrier());
                  },
                  child: CircleAvatar(
                    backgroundColor: kPurpleColor.withOpacity(0.1),
                    radius: 15,
                    child: Center(child: SvgPicture.asset(kEditIcon,height: 12,width: 12,)),
                  ),
                ),
              ),
              SizedBox(width: 12.w,),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(DeleteDialog());
                  },
                  child: CircleAvatar(
                    backgroundColor: kRedColor.withOpacity(0.1),
                    radius: 15,
                    child: Center(child: SvgPicture.asset(kDeleteIcon,height: 12,width: 12,)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
