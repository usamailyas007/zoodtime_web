import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../custom_widgets/custom_header.dart';
import '../../custom_widgets/custom_pagination.dart';
import '../../custom_widgets/delete_dialog.dart';
import '../../utils/app_strings.dart';
import '../sidemenu/sidemenu.dart';
import '../user_screen/controller/user_controller.dart';
import 'controller/job_controller.dart';


class JobScreen extends StatefulWidget {
  const JobScreen({super.key});

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final JobController controller = Get.find<JobController>();

  customRow(title,detail){
    return Row(
      spacing: 10,
      children: [
        Text(title,style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp,fontWeight: FontWeight.w700)),
        Text(detail,style: AppStyles.blackTextStyle().copyWith(fontSize: 16.sp,fontWeight: FontWeight.w400)),
      ],
    );
  }

  courierDetails(Map<String, dynamic> job){
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
                  Text("Courier Details",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w600)),
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
              SizedBox(height: 24.h,),
              Divider(
                endIndent: 0,
                indent: 0,
                color: kBorderColor2,
                thickness: 0.5,
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20.w,
                children: [
                  Text("Status:",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 12.sp,color: kGreyColor)),
                  CustomButton(title: job['status'], onTap: (){},width: 90.w,height: 27.h,textSize: 11.sp,fontWeight: FontWeight.w500,color: kGreyShade16Color.withOpacity(0.25),borderColor: kGreyShade16Color,borderRadius: 10,textColor: kBlackTextColor,)
                ],
              ),
              SizedBox(height: 24.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  customRow("Order ID:", job['orderNumber'] ?? "--"),
                  customRow("Client Name:", job['userId']?['name'] ?? "--", ),
                  customRow("Courier Name:", job['courier']?['name'] ?? "--",),
                  customRow("Order Type:", job['orderType']),
                  customRow(
                      "Pick up Address:",
                      ((job['pickupAddress']?['city'] != "" && job['pickupAddress']?['housingNo'] != "")
                          ? "${job['pickupAddress']?['city'] ?? ''} ${job['pickupAddress']?['housingNo'] ?? ''}".trim()
                          : job['storeAddress']?['address'] ?? "--")
                  ),
                  customRow("Drop off Address:", job['deliveryAddress']?['city'] ?? "--",),
                  customRow("Weight:", "${(job['weightKg'] ?? '').toString()} kg"),
                  customRow("Delivery Type:", job['deliveryType']),
                ],
              ),
              SizedBox(height: 24.h,),
              Divider(
                endIndent: 0,
                indent: 0,
                color: kBorderColor2,
                thickness: 0.5,
              ),
              SizedBox(height: 24.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){
                    Get.back();
                  },width: 145.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  CustomButton(title: "Assign Courier", onTap: (){
                    Get.dialog(assignCurrier(job['_id']));

                  },width: 134.w,height: 40.h,textSize: 14.sp,),
                ],
              ),
            ],
          ),
        )
    );
  }

  assignCurrier(String id){
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
                  return DropdownButtonFormField2<String>(
                    value: controller.selectedCourier.value.isEmpty
                        ? null
                        : controller.selectedCourier.value,
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 230,
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    hint: Text(
                      "Select couriers here",
                      style: AppStyles.blackTextStyle().copyWith(
                          fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kBorderColor1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kBorderColor1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: kBorderColor1),
                      ),
                    ),
                    items: controller.couriersName
                        .map((name) => DropdownMenuItem<String>(
                      value: name,
                      child: Text(
                        name,
                        style: AppStyles.blackTextStyle().copyWith(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectCourier(value ?? '');
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
                 Obx(() =>  CustomButton(title: "Assign Courier", onTap: ()async{
                   bool success = await controller.assignCourier(Get.context, id);
                   if (success) {
                     Future.delayed(Duration(milliseconds: 50), () {
                       if (Get.isDialogOpen ?? false) {
                         Get.back();
                       }
                       Get.back();
                       Get.back();
                     });
                   }


                 },width: 134.w,height: 40.h,textSize: 14.sp,isLoading: controller.isLoading1.value,),)
                ],
              ),
            ],
          ),
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getAllCouriersName(Get.context,);
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
                          CustomHeader(title: kManageJobs,),
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
                                              controller.currentPage.value = 1;},
                                            offset: Offset(0, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            color: kWhiteColor,
                                            itemBuilder: (context) => [
                                              PopupMenuItem(value: 'All', child: Text('All',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'Delivered', child: Text('Delivered',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'Pending', child: Text('Pending',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
                                              PopupMenuItem(value: 'In transit', child: Text('In transit',style: AppStyles.blackTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),)),
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
                          Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: CircularProgressIndicator()); // Loader
                            }

                            if (controller.filteredJobs.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text("No Jobs Found"),
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
                                        "Courier Name",
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
                                        "Courier Status",
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
                                        "Delivery Type",
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
                                    label: Flexible(
                                      child: Text(
                                        "Type",
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
                                rows: controller.filteredJobs.asMap().entries.map((entry) {
                                  final i = entry.key;
                                  final jobs = entry.value;
                                  return _buildDataRow(
                                    i,
                                    ((controller.currentPage.value - 1) * controller.itemsPerPage + i + 1).toString(),
                                    jobs['userId']?['name'] ?? "__",
                                    jobs['courier']?['name'] ?? "__",
                                    (jobs['courier'] != null && jobs['courierStatus'] != null)
                                        ? jobs['courierStatus']
                                        : "__",
                                    jobs['orderType'] ?? "__",
                                    (jobs['weightKg'] ?? '').toString(),
                                    jobs['deliveryType'] ?? "__",
                                    jobs['status'] ?? "__",
                                    jobs,
                                    context,
                                  );
                                }).toList(),
                                dataRowMaxHeight: 70,
                              ),
                            );
                          }),
                          SizedBox(height: 35.h,),

                          Obx(() {

                            if (controller.filteredJobs.isEmpty) {
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


  DataRow _buildDataRow(
      int i,
      String id,
      String clientName,
      String courierName,
      String deliveryType,
      String courierStatus,
      String weight,
      String type,
      String status,
      Map<String, dynamic> job,
      context) {
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
          clientName,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          courierName,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          deliveryType,
          textAlign: TextAlign.center,
          style: AppStyles.blackTextStyle()
              .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400),
        )),
        DataCell(Text(
          courierStatus,
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
        DataCell(Text(
          type,
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
              borderColor: status == "Delivered" ?
              kPrimaryColor :
              status == "Pending" ? kOrangeColor :
              kLightBlueColor,
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
                    Get.dialog(courierDetails(job));
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
                      bool success = await userController.deleteEntity(context, job['_id'], "order", controller.jobs);
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
