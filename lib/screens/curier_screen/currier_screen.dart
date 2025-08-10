import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoodtime_admin/custom_widgets/delete_dialog.dart';
import 'package:zoodtime_admin/screens/user_screen/controller/user_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/field_container.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/currier_controller.dart';

class CurrierScreen extends GetView<CurrierController> {
  const CurrierScreen({super.key});

  updateCourierSalaryStatus(Map<String, dynamic> user){
    return CustomDialog(
        width: 450.w,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
              Text("Courier Status",style: AppStyles.blackTextStyle()),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 40.h,
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedCourierStatus.value.isEmpty
                        ? null
                        : controller.selectedCourierStatus.value,
                    dropdownColor: kWhiteColor,
                    hint: Text("Status",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
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
                    items: ["suspended", "active"]
                        .map((courier) => DropdownMenuItem<String>(
                      value: courier,
                      child: Text(courier,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectCourierStatus(value!);
                    },
                  );
                }),
              ),
              SizedBox(height: 16.h,),
              Text("Salary Status",style: AppStyles.blackTextStyle()),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 40.h,
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedSalaryStatus.value.isEmpty
                        ? null
                        : controller.selectedSalaryStatus.value,
                    dropdownColor: kWhiteColor,
                    hint: Text("Status",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
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
                    items: ["credited", "pending"]
                        .map((courier) => DropdownMenuItem<String>(
                      value: courier,
                      child: Text(courier,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectSalaryStatus(value!);
                    },
                  );
                }),
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  CustomButton(
                    title: "Cancel",
                    onTap: (){
                    Get.back();
                  },
                    width: 78.w,
                    height: 40.h,
                    color: kWhiteColor,
                    borderColor: kBorderColor3,
                    textSize: 14.sp,
                    textColor: kSecondaryColor,),

                  Obx(() => CustomButton(
                    title: "Update Now",
                    onTap: () async{

                      if(controller.selectedCourierStatus.value.isNotEmpty &&
                          controller.selectedSalaryStatus.value.isEmpty){

                        await controller.updateStatus(Get.context, user['_id'], controller.selectedCourierStatus.value);

                      } else if(controller.selectedCourierStatus.value.isEmpty &&
                          controller.selectedSalaryStatus.value.isNotEmpty) {

                        await controller.updateCourierStatus(Get.context, user['_id'], controller.selectedSalaryStatus.value);

                      } else if(controller.selectedCourierStatus.value.isNotEmpty &&
                          controller.selectedSalaryStatus.value.isNotEmpty) {

                        await controller.updateStatus(Get.context, user['_id'], controller.selectedCourierStatus.value);
                        await controller.updateCourierStatus(Get.context, user['_id'], controller.selectedSalaryStatus.value);

                      }


                    },
                    width: 134.w,
                    height: 40.h,
                    textSize: 14.sp,
                    isLoading: controller.isUpdateStatus.value,
                  ),),

                ],
              ),
            ],
          ),
        )
    );
  }

  addCourier(){
    return CustomDialog(
        width: 450.w,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
              Text("Name",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "ABC",
                  controller: controller.nameController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Phone Number",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "00000",
                  controller: controller.phNumberController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("City",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "ABC Delta",
                  controller: controller.cityNameController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Transport Type",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40.h,
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedType.value,
                    dropdownColor: kWhiteColor,
                    hint: Text("Type",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
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
                    items: ["Car", "Truck", "Motorcycle"]
                        .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(type,style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 14),),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectTransportType(value!);
                    },
                  );
                }),
              ),
              SizedBox(height: 14.h,),
              Text("Salary",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "ABC Delta",
                  controller: controller.salaryController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 32.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){
                    Get.back();
                    controller.clearFields();
                    },width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  Obx(() => CustomButton(title: "Add Courier",
                    onTap: ()async{
                      bool success = await controller.addCourier(Get.context);
                      if (success) {
                        Future.delayed(Duration(milliseconds: 50), () {
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                          Get.back();
                        });
                      }
                    },
                    width: 120.w,
                    height: 40.h,
                    textSize: 14.sp,
                    isLoading: controller.isLoading.value,),)
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
                                                controller.selectedTransportType.value = value;
                                                controller.currentPage.value = 1;
                                                // controller.totalPages.value = (controller.filteredCouriers.length / controller.itemsPerPage)
                                                //     .ceil()
                                                //     .clamp(1, double.infinity)
                                                //     .toInt();
                                                },
                                              offset: Offset(0, 40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              color: kWhiteColor,
                                              itemBuilder: (context) => [
                                                PopupMenuItem(value: 'All', child: Text('All',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'Motorcycle', child: Text('Motorcycle',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'Car', child: Text('Car',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'Truck', child: Text('Truck',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              ],
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.selectedTransportType.value.isEmpty
                                                        ? 'Transport Type'
                                                        : controller.selectedTransportType.value,                                                    style: AppStyles.blackTextStyle().copyWith(
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
                                Spacer(),
                                Obx(() => CustomButton(
                                  title: "Reset Salaries",
                                  onTap: (){
                                    controller.resetSalaries(context);
                                  },
                                  height: 40.h,
                                  width: 150.w,
                                  textSize: 14.sp,
                                  isLoading: controller.isLoading2.value,
                                ),),
                                SizedBox(width: 20.w,),
                                CustomButton(title: "+ Add Courier", onTap: (){
                                  Get.dialog(addCourier());
                                },height: 40.h,width: 150.w,textSize: 14.sp,)
                              ],
                            ),

                            SizedBox(height: 32.h),

                            Obx((){

                              if (controller.isLoading1.value) {
                                return Center(child: CircularProgressIndicator()); // Loader
                              }

                              if (controller.filteredCouriers.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Text("No Couriers Found"),
                                  ),
                                );
                              }

                              return Container(
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
                                          "ID",
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
                                          "Name",
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
                                          "Phone",
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
                                          "City",
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
                                          "Transport Type",
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
                                          "Salary",
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
                                          "Salary Status",
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
                                  rows: controller.filteredCouriers.asMap().entries.map((entry) {
                                    final i = entry.key;
                                    final user = entry.value;
                                    return _buildDataRow(
                                      i,
                                      ((controller.currentPage.value - 1) * controller.itemsPerPage + i + 1).toString(),
                                      user['name'] ?? '',
                                      user['phone'] ?? '',
                                      user['city'] ?? '',
                                      user['transportType'].toString() ?? '',
                                      user['salary'].toString() ?? '',
                                      user['salaryStatus'] ?? 'Pending',
                                      user['status'] ?? 'Active',
                                      user,
                                      context,
                                    );
                                  }).toList(),
                                  dataRowMaxHeight: 70,
                                ),
                              );
                            }),
                            SizedBox(height: 35.h,),
                            Obx(() {

                              if (controller.filteredCouriers.isEmpty) {
                                return const SizedBox();
                              }

                              return CustomPagination(
                                currentPage: controller.currentPage.value,
                                visiblePages: List.generate(controller.totalPages.value, (i) => i + 1),
                                onPageSelected: (page) {
                                  controller.goToPage(page, context);
                                },
                                onNext: () {
                                  controller.goToNextPage(context);
                                },
                                onPrevious: () {
                                  controller.goToPreviousPage(context);
                                },
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

  DataRow _buildDataRow(int i,String id, String name, String phone ,String cName,String transportType,String salary, String salaryStatus, String status,Map<String, dynamic> user, context) {
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
          phone,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          cName,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          transportType,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          salary,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 14.sp, ),
        )),
        DataCell(
          Center(
              child: CustomButton(
                title: salaryStatus,
                onTap: (){},
                height: 30.h,
                width: 85.w,
                textSize: 11.sp,
                borderRadius: 8,
                color: salaryStatus == "pending" ? kLightBlueColor : kPrimaryColor,
            borderColor: salaryStatus == "pending" ? kLightBlueColor : kPrimaryColor,
              ))
        ),
        DataCell(
          Center(child: CustomButton(title: status,onTap: (){},height: 30.h,width: 85.w,textSize: 11.sp,borderRadius: 8,color: status == "suspended" ? kOrangeColor : kPrimaryColor,))
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(updateCourierSalaryStatus(user));
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
                    Get.dialog(DeleteDialog(onTap: ()async{
                      UserController userController = Get.put(UserController());
                      bool success = await userController.deleteEntity(context, user['_id'], "courier", controller.couriers);
                      if (success) {
                        Future.delayed(Duration(milliseconds: 50), () {
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                          Get.back();
                        });
                      }
                    },));

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
