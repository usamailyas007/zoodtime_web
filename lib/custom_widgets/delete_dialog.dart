import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoodtime_admin/utils/app_images.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import 'custom_button.dart';
import 'custom_dialog.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
        width: 450.w,
        content: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
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
              SizedBox(
                height: 110.h,
                width: 110.w,
                child: SvgPicture.asset(kDeleteIcon1,fit: BoxFit.cover,),
              ),
              SizedBox(height: 32.h,),
              Text("Confirm Deletion",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w700,fontSize: 18.sp)),
              SizedBox(height: 7.h,),
              Text("Are you sure you want to delete this record? This action is permanent and cannot be undone. Please double-check before proceeding.",style: AppStyles.blackTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 15.sp,color: kBlackTextColor2),textAlign: TextAlign.center,),
              SizedBox(height: 32.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(title: "Cancel", onTap: (){
                    Get.back();
                  },width: 78.w,height: 40.h,color: kWhiteColor,borderColor: kBorderColor3,textSize: 14.sp,textColor: kSecondaryColor,),
                  CustomButton(title: "Confirm Delete", onTap: (){},width: 140.w,height: 40.h,textSize: 14.sp,),
                ],
              ),
            ],
          ),
        )
    );
  }
}
