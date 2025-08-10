import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_strings.dart';
import 'controller/auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Row(
          children: [
            Expanded(child: SizedBox(
              height: Get.height,
                child: Image.asset(kAuthImage,fit: BoxFit.cover,))),
            Expanded(
              child: SizedBox(
                height: Get.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h,horizontal: 68.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 73.h,width: 75.w,
                          child: Image.asset(kLogo,fit: BoxFit.cover,)),
                      SizedBox(height: 98.h,),
                      Text(kLoginWithEmail,style: AppStyles.blackTextStyle().copyWith(fontSize: 32, fontWeight: FontWeight.w500),),
                      SizedBox(height: 30.h,),
                      Text(kEmail,style: AppStyles.greyTextStyle().copyWith(fontSize: 16.sp,),),
                      SizedBox(height: 4,),
                      CustomTextField(
                          hintText: kEmailHint,
                        controller: controller.emailController,
                      ),
                      SizedBox(height: 20.h),
                      Text(kPassword,style: AppStyles.greyTextStyle().copyWith(fontSize: 16.sp,),),
                      SizedBox(height: 4,),
                      Obx(() => CustomTextField(
                        hintText: kPassword,
                        isObscure: controller.isPasswordHidden.value,
                        controller: controller.passController,
                        suffix: IconButton(
                          icon: Icon(
                            controller.isPasswordHidden.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            controller.togglePasswordVisibility();
                          },
                        ),
                      )),
                      SizedBox(height: 60.h),
                      Obx(() => CustomButton(
                        title: kLogin,
                        isLoading: controller.isLoading.value,
                        onTap: () {
                          controller.login();
                        },
                      )),
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

}