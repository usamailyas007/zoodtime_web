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
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import '../user_screen/controller/user_controller.dart';
import 'controller/store_controller.dart';

class StoreScreen extends GetView<StoreController> {
  const StoreScreen({super.key});

  updateStatus(RxList<Map<String, dynamic>> list, String id){
    UserController userController = Get.put(UserController());

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
                    value: controller.selectedUserStatus.value,
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

                    bool success = await userController.updateStatus(Get.context, id, "store", list, controller.selectedUserStatus.value ?? '');
                    if (success) {
                      Future.delayed(Duration(milliseconds: 50), () {
                        // if (Get.isDialogOpen ?? false) {
                        //   Get.back();
                        // }
                        // Get.back();
                      });
                    }
                  },width: 134.w,height: 40.h,textSize: 14.sp,isLoading: userController.isUpdateStatue.value,),)

                ],
              ),
            ],
          ),
        )
    );
  }

  addStore(){
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
              Text("Store name",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "Store name",
                  controller: controller.storeNameController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Tax ID / Company Registration Number",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  controller: controller.taxIdController,
                  hintText: "Tax ID / Company Registration Number",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Address",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "ABC Delta",
                  controller: controller.addressController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Phone",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "Phone",
                  controller: controller.phNumberController,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Email",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
                  hintText: "Email",
                  controller: controller.emailController,
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
                  Obx(() => CustomButton(title: "Add Store",
                    onTap: ()async{
                      bool success = await controller.addStore(Get.context);
                      if (success) {
                        Future.delayed(Duration(milliseconds: 50), () {
                          if (Get.isDialogOpen ?? false) {
                            Get.back();
                          }
                          Get.back();
                        });
                      }
                    },width: 105.w,height: 40.h,textSize: 14.sp,isLoading: controller.isLoading.value,),)
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

    return Scaffold(
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
                          CustomHeader(title: kManageStore,),
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
                                              controller.selectedStatus.value = value;
                                              controller.currentPage.value = 1;                                  },
                                            offset: Offset(0, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            color: kWhiteColor,
                                            itemBuilder: (context) => [
                                              PopupMenuItem(value: 'All', child: Text('All',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'active', child: Text('active',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'suspended', child: Text('suspended',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
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
                              CustomButton(title: "+ Add Store", onTap: (){
                                Get.dialog(addStore());
                              },height: 40.h,width: 118.w,textSize: 14.sp,)
                            ],
                          ),
                          SizedBox(height: 32.h),
                          Obx(() {

                            if (controller.isLoading1.value) {
                              return Center(child: CircularProgressIndicator()); // Loader
                            }

                            if (controller.filteredStores.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("No Stores Found"),
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
                                        "Store ID",
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
                                        "Store Name",
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
                                        "Tax ID",
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
                                        "Email",
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
                                        "Address",
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
                                rows: controller.filteredStores.asMap().entries.map((entry) {
                                  final i = entry.key;
                                  final store = entry.value;
                                  return _buildDataRow(
                                    i,
                                    ((controller.currentPage.value - 1) * controller.itemsPerPage + i + 1).toString(),
                                    store['storeName'] ?? '',
                                    store['taxId'] ?? '',
                                    store['phone'] ?? '',
                                    store['email'] ?? '',
                                    store['address'] ?? '',
                                    store['status'] ?? 'active',
                                    store,
                                    context,
                                  );
                                }).toList(),
                                dataRowMaxHeight: 70,
                              ),
                            );
                          },),
                          SizedBox(height: 35.h,),
                          Obx(() {

                            if (controller.filteredStores.isEmpty) {
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
    );
  }

  DataRow _buildDataRow(int i,String id, String name, String taxId, String phone ,String email,String address, String status, Map<String, dynamic> store, context) {
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
          taxId,
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
          email,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          address,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 14.sp, ),
        )),
        DataCell(
            Center(child: CustomButton(title: status,onTap: (){},height: 30,width: 129.w,textSize: 11.sp,borderRadius: 8,color: status == "suspended" ? kOrangeColor : kPrimaryColor,fontWeight: FontWeight.w600,))
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(updateStatus(controller.stores, store['_id']));
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
                      bool success = await userController.deleteEntity(context, store['_id'], "store", controller.stores);
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
