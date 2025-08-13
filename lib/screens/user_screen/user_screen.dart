import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:zoodtime_admin/custom_widgets/delete_dialog.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../custom_widgets/field_container.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/user_controller.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  updateStatus(RxList<Map<String, dynamic>> list, String id){
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
              Text("Update Status",style: AppStyles.blackTextStyle()),
              SizedBox(height: 5.h,),
              SizedBox(
                height: 40.h,
                child: Obx(() {
                  return DropdownButtonFormField<String>(
                    value: controller.selectedStatus.value,
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
                      controller.selectStatus(value!);
                    },
                  );
                }),
              ),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){
                    Get.back();
                  },width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  Obx(() => CustomButton(title: "Update Now", onTap: ()async{

                    bool success = await controller.updateStatus(Get.context, id, "user", list, controller.selectedStatus.value ?? '');
                    if (success) {
                      Future.delayed(Duration(milliseconds: 50), () {
                        // if (Get.isDialogOpen ?? false) {
                        //   Get.back();
                        // }
                        // Get.back();
                      });
                    }
                  },width: 134.w,height: 40.h,textSize: 14.sp,isLoading: controller.isUpdateStatue.value,),)
                ],
              ),
            ],
          ),
        )
    );
  }

  // addBusiness(context){
  //   return CustomDialog(
  //       width: 450.w,
  //       content: Padding(
  //         padding: const EdgeInsets.all(24),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 MouseRegion(
  //                   cursor: SystemMouseCursors.click,
  //                   child: GestureDetector(
  //                       onTap: (){
  //                         Get.back();
  //                       },
  //                       child: Icon(Icons.close,color: kSecondaryColor,size: 20,)),
  //                 )
  //               ],
  //             ),
  //             SizedBox(height: 32.h,),
  //             Text("Name",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
  //             SizedBox(height: 6.h,),
  //             SizedBox(
  //               height: 40,
  //               child: CustomTextField(
  //                 hintText: "ABC",
  //                 controller: controller.nameController,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
  //               ),
  //             ),
  //             SizedBox(height: 14.h,),
  //             Text("Company Name",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
  //             SizedBox(height: 6.h,),
  //             SizedBox(
  //               height: 40,
  //               child: CustomTextField(
  //                 hintText: "ABC Delta",
  //                 controller: controller.companyNameController,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
  //               ),
  //             ),
  //             SizedBox(height: 14.h,),
  //             Text("Tax ID",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
  //             SizedBox(height: 6.h,),
  //             SizedBox(
  //               height: 40,
  //               child: CustomTextField(
  //                 hintText: "00000",
  //                 controller: controller.taxIdController,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
  //               ),
  //             ),
  //             SizedBox(height: 14.h,),
  //             Text("Phone Number",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
  //             SizedBox(height: 6.h,),
  //             SizedBox(
  //               height: 40,
  //               child: CustomTextField(
  //                 hintText: "00000",
  //                 controller: controller.phNumberController,
  //                 contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
  //               ),
  //             ),
  //             SizedBox(height: 32.h,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 CustomButton(title: "Cancel", onTap: (){
  //                   Get.back();
  //                   controller.clearFields();
  //                 },width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
  //                 Obx(() => CustomButton(title: "Add Business", onTap: ()async{
  //
  //                   bool success = await controller.addBusiness(Get.context);
  //                   if (success) {
  //                     Future.delayed(Duration(milliseconds: 50), () {
  //                       if (Get.isDialogOpen ?? false) {
  //                         Get.back();
  //                       }
  //                       Get.back();
  //                       // Get.toNamed(kUserScreenRoute);
  //                     });
  //                   }
  //                 },width: 130.w,height: 40.h,textSize: 14.sp,isLoading: controller.isLoading.value,),)
  //               ],
  //             ),
  //           ],
  //         ),
  //       )
  //   );
  // }

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
                            CustomHeader(title: kWelcomeAdmin,),
                            SizedBox(height: 32.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                controller.selectedAccountType.value = value;
                                                controller.currentPage.value = 1;
                                                // controller.getBusinesses(context, page: 1);
                                                },
                                              offset: Offset(0, 40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              color: kWhiteColor,
                                              itemBuilder: (context) => [
                                                PopupMenuItem(value: 'active', child: Text('Active',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'suspended', child: Text('Suspended',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                                PopupMenuItem(value: 'All', child: Text('All',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              ],
                                              child: Row(
                                                children: [
                                                  Text(
                                                    controller.selectedAccountType.value,
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
                                // CustomButton(title: "+ Add Business", onTap: (){
                                //   Get.dialog(addBusiness(context));
                                // },height: 40.h,width: 150.w,textSize: 14.sp,)
                              ],
                            ),

                            SizedBox(height: 32.h),
                            Stack(
                              children: [
                                Obx(() {
                                  if (controller.isLoading1.value) {
                                    return Center(child: CircularProgressIndicator()); // Loader
                                  }

                                  if (controller.filteredUsers.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text("No User Found"),
                                      ),
                                    );
                                  }

                                  return Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color: kBorderColor1),
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
                                        // DataColumn(
                                        //   label: Flexible(
                                        //     child: Text(
                                        //       "Company Name",
                                        //       overflow: TextOverflow.ellipsis,
                                        //       maxLines: 1,
                                        //       style:
                                        //       AppStyles.blackTextStyle()
                                        //           .copyWith(
                                        //           fontSize: 14.sp,
                                        //           fontWeight: FontWeight.w600,
                                        //           color: kBlueColor
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // DataColumn(
                                        //   label: Flexible(
                                        //     child: Text(
                                        //       "Tax ID",
                                        //       overflow: TextOverflow.ellipsis,
                                        //       maxLines: 1,
                                        //       style:
                                        //       AppStyles.blackTextStyle()
                                        //           .copyWith(
                                        //           fontSize: 14.sp,
                                        //           fontWeight: FontWeight.w600,
                                        //           color: kBlueColor
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              "Role",
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
                                      rows: controller.users.asMap().entries.map((entry) {
                                        final i = entry.key;
                                        final user = entry.value;

                                        // log("user Data ===========================$user");

                                        return _buildDataRow(
                                          i,
                                          ((controller.currentPage.value - 1) * controller.itemsPerPage + i + 1).toString(),
                                          user['name'] ?? '--',
                                          user['phone'] ?? '',
                                          // user['companyName'] ?? '--',
                                          // user['taxId'] ?? '--',
                                          user['role'],
                                          user['status'] ?? 'Active',
                                          user,
                                          context,
                                        );
                                      }).toList(),
                                      dataRowMaxHeight: 70,
                                    ),
                                  );
                                }),
                              ],
                            ),
                            SizedBox(height: 35.h,),
                            Obx(() {
                              if (controller.filteredUsers.isEmpty) {
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

  DataRow _buildDataRow(int i,String id, String name, String phone ,String acType, String status, Map<String, dynamic> user,context) {
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
        // DataCell(Text(
        //   cName,
        //   textAlign: TextAlign.center,
        //   style: AppStyles.blackTextStyle()
        //       .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        // )),
        // DataCell(Text(
        //   taxId,
        //   textAlign: TextAlign.center,
        //   style: AppStyles.blackTextStyle()
        //       .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        // )),
        DataCell(Text(
          acType,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 14.sp, ),
        )),
        DataCell(
          Center(child: CustomButton(title: status,onTap: (){},height: 30.h,width: 85.w,textSize: 11.sp,borderRadius: 8,color: status == "Suspended" ? kOrangeColor : kPrimaryColor,))
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(updateStatus(controller.users, user['_id']));
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
                      bool success = await controller.deleteEntity(context, user['_id'], "company", controller.users);
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
