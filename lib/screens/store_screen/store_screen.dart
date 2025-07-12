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
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/store_controller.dart';

class StoreScreen extends GetView<StoreController> {
  const StoreScreen({super.key});

  updateStatus(){
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
                    items: ["Suspend", "Active"]
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
                  CustomButton(title: "Cancel", onTap: (){},width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  CustomButton(title: "Update Now", onTap: (){},width: 134.w,height: 40.h,textSize: 14.sp,),
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 14.h,),
              Text("Tax ID / Company Registration Number",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400)),
              SizedBox(height: 6.h,),
              SizedBox(
                height: 40,
                child: CustomTextField(
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
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
                ),
              ),
              SizedBox(height: 32.h,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){},width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  CustomButton(title: "Add Store", onTap: (){},width: 105.w,height: 40.h,textSize: 14.sp,),
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
                                              controller.currentPage.value = 1;                                              },
                                            offset: Offset(0, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            color: kWhiteColor,
                                            itemBuilder: (context) => [
                                              PopupMenuItem(value: 'Active', child: Text('Active',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'Paused', child: Text('Paused',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
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
                                  rows: controller.pagedStores.asMap().entries.map((entry) {
                                    final i = entry.key;
                                    final user = entry.value;
                                    return _buildDataRow(
                                        i,
                                        user['id']!,
                                        user['name']!,
                                        user['taxId']!,
                                        user['phone']!,
                                        user['email']!,
                                        user['address']!,
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
                            if (controller.filteredStores.isEmpty) {
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
    );
  }

  DataRow _buildDataRow(int i,String id, String name, String taxId, String phone ,String email,String address, String status, context) {
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
            Center(child: CustomButton(title: status,onTap: (){},height: 30.h,width: 129.w,textSize: 11.sp,borderRadius: 8,color: status == "Paused" ? kOrangeColor : kPrimaryColor,fontWeight: FontWeight.w600,))
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    Get.dialog(updateStatus());
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
