import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_dialog.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import 'controller/sidemenu_controller.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final menuController = Get.put(SideMenuController());

  logoutDialog() {
    return CustomDialog(
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 61),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: SvgPicture.asset(
                  kLogoutIcon,
                  height: 55,
                  width: 55,
                  color: kWhiteColor,
                ),
              ),
            ),
            SizedBox(height: 26.h),
            Text(
              "Are you sure to logout this app?",
              style: AppStyles.blackTextStyle().copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 35.h),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    title: "Cancel",
                    onTap: () {
                      Get.back();
                    },
                    color: kGreyShade5Color.withOpacity(0.22),
                    borderColor: kGreyShade5Color.withOpacity(0.22),
                    textColor: kPrimaryColor,
                    textSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 56.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: CustomButton(
                    title: "Yes Logout",
                    onTap: () {
                      Get.offAllNamed(kAuthScreenRoute);
                    },
                    textSize: 16,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w700,
                    height: 56.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool isTablet = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    double width = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: kWhiteColor,
      shape: Border(
        right: BorderSide(
          color: kGrey100,
        )
      ),
      width: 212.w,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 180.h,
              child: DrawerHeader(
                child: Column(
                  children: [
                    SizedBox(height: 8.h,),
                    SizedBox(
                      height: 50.h,
                      width: 90.w,
                      child: Center(
                        child: Image.asset(
                          kLogo,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // SizedBox(height: 8.h,),
                    Text(kAppName,style: AppStyles.blackTextStyle().copyWith(fontSize: 18.sp,fontWeight: FontWeight.w600),),
                    SizedBox(height: 20.h,),
                    Divider(color: kBlackTextColor1,thickness: 2,)
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(0);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    0
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),

                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kDashboardIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                        .selectedIndex
                                                        .value ==
                                                    0
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              12.w,
                                        ),
                                        Text(
                                          kDashboard,
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                                color:
                                                    menuController
                                                                .selectedIndex
                                                                .value ==
                                                            0
                                                        ? kWhiteColor
                                                        : kBlackTextColor1,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(1);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    1
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 22.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kUserIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                1
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            kUsers,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                              color:
                                              menuController
                                                  .selectedIndex
                                                  .value ==
                                                  1
                                                  ? kWhiteColor
                                                  : kBlackTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(2);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    2
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kCurrierIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                2
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),

                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Expanded(
                                          child: Text(
                                            kCouriers,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                              color:
                                              menuController
                                                  .selectedIndex
                                                  .value ==
                                                  2
                                                  ? kWhiteColor
                                                  : kBlackTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(3);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    3
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kJobIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                3
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Text(
                                          kJobs,
                                          style: AppStyles.blackTextStyle()
                                              .copyWith(
                                            color:
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                3
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(4);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    4
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kStoreIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                4
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Flexible(
                                          child: Text(
                                            kStore,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                              color:
                                              menuController
                                                  .selectedIndex
                                                  .value ==
                                                  4
                                                  ? kWhiteColor
                                                  : kBlackTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(5);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    5
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kReturnIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                5
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Flexible(
                                          child: Text(
                                            kReturns,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                              color:
                                              menuController
                                                  .selectedIndex
                                                  .value ==
                                                  5
                                                  ? kWhiteColor
                                                  : kBlackTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(6);
                            },
                            child: Container(
                              width: width,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: menuController
                                    .selectedIndex
                                    .value ==
                                    6
                                    ? kPrimaryColor
                                    : kWhiteColor,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 4.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(6),
                                            color: kWhiteColor,
                                          ),
                                        ),
                                        SizedBox(width: 14.w,),
                                        SvgPicture.asset(
                                          kSettingIcon,
                                          height: 16,
                                          width: 16,
                                          colorFilter: ColorFilter.mode(
                                            menuController
                                                .selectedIndex
                                                .value ==
                                                6
                                                ? kWhiteColor
                                                : kBlackTextColor1,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                          12.w,
                                        ),
                                        Flexible(
                                          child: Text(
                                            kProfile,
                                            style: AppStyles.blackTextStyle()
                                                .copyWith(
                                              color:
                                              menuController
                                                  .selectedIndex
                                                  .value ==
                                                  6
                                                  ? kWhiteColor
                                                  : kBlackTextColor1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, right: 15),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Get.dialog(logoutDialog());
                  },
                  child: Container(
                    width: width,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kWhiteColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 16.h,
                                width: 4.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: kWhiteColor,
                                ),
                              ),
                              SizedBox(width: 14.w,),
                              SvgPicture.asset(
                                kLogoutIcon,
                                height: 16,
                                width: 16,
                                colorFilter: ColorFilter.mode(
                                  kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              SizedBox(
                                width:
                                12.w,
                              ),
                              Text(
                                kLogout,
                                style: AppStyles.blackTextStyle()
                                    .copyWith(
                                  color:
                                  kPrimaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
