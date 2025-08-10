import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_styles.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_textfield.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/helpers/configs.dart';
import '../sidemenu/sidemenu.dart';
import 'controller/profile_controller.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  Widget customField(
    title,
    hintText,
    Widget prefix,
    double widget,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: kGreyShade2Color,
          ),
        ),
        SizedBox(height: 6.h),
        CustomTextField(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          prefix: prefix,
          width: widget,
          controller: controller,
        ),
      ],
    );
  }

  Widget profileImageWidget(String? imageUrl) {
    if (kIsWeb) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl ?? '',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            debugPrint('Image load error (web): $error');
            return _uploadPlaceholder();
          },
        ),
      );
    } else {
      return CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        cacheManager: Configs.customCacheManager,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator(color: kPrimaryColor)),
        errorWidget: (context, url, error) {
          debugPrint("Image load error: $error");
          return _uploadPlaceholder();
        },
      );
    }
  }

  Widget _uploadPlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(kuploadIcon, height: 24, width: 24),
        const SizedBox(height: 28),
        Text(
          "Upload Picture",
          style: AppStyles.blackTextStyle().copyWith(
            fontSize: 14.sp,
            color: kGreyShade8Color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenu(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: 59.w,
                          left: 20.w,
                          bottom: 32.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Configure Profile",
                                        style: AppStyles.blackTextStyle()
                                            .copyWith(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 62.h),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          customField(
                                            "First Name",
                                            "Usman",
                                            SvgPicture.asset(kUserIcon1),
                                            400.w,
                                            controller.fullNameController,
                                          ),
                                          SizedBox(height: 40.h),
                                          customField(
                                            "Email",
                                            "usmanndako@gmail.com",
                                            Icon(
                                              Icons.email_outlined,
                                              color: kGreyColor,
                                            ),
                                            400.w,
                                            controller.emailController,
                                          ),
                                          SizedBox(height: 40.h),
                                          customField(
                                            "Price per kg",
                                            "eg 10TJK",
                                            Icon(
                                              Icons.currency_exchange_outlined,
                                              color: kGreyColor,
                                            ),
                                            400.w,
                                            controller.priceController,
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 77.w),
                                      GestureDetector(
                                        onTap:
                                            () => controller.pickImageFromWeb(),
                                        child: Obx(() {
                                          final imageBytes =
                                              controller.pickedImageBytes.value;

                                          final imageUrl =
                                              controller.appLogoUrl.value;

                                          return DottedBorder(
                                            borderType: BorderType.RRect,
                                            radius: Radius.circular(12),
                                            dashPattern: [12, 8],
                                            color: kGreyShade8Color,
                                            strokeWidth: 0.8,
                                            child: Container(
                                              height: 170,
                                              width: 170,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child:
                                                  imageBytes != null
                                                      ? Stack(
                                                        children: [
                                                          Image.memory(
                                                            imageBytes,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  top: 14,
                                                                  right: 14,
                                                                ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                MouseRegion(
                                                                  cursor:
                                                                      SystemMouseCursors
                                                                          .click,
                                                                  child: GestureDetector(
                                                                    onTap: () {
                                                                      controller
                                                                          .pickedImageBytes
                                                                          .value = null;
                                                                    },
                                                                    child: const Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color:
                                                                          kRedColor,
                                                                      size: 30,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      : imageUrl != null
                                                      ? profileImageWidget(imageUrl)
                                                      : _uploadPlaceholder(),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 162.h),
                                  Obx(() => Padding(
                                    padding: const EdgeInsets.only(left: 100.0),
                                    child: CustomButton(
                                      title: "Update",
                                      isLoading: controller.isLoading.value,
                                      onTap: () {
                                        controller.updateProfile();
                                      },
                                      width: 400.w,
                                    ),
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
