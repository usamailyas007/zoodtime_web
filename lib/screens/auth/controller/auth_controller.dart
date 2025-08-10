import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../custom_widgets/loading.dart';
import '../../../services/auth_Services.dart';
import '../../../services/storage.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/helpers/global.dart';

class AuthController extends GetxController {
  var isPasswordHidden = true.obs;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  AuthServices authServices = AuthServices();
  var isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  login() async {
    if (emailController.text.isEmpty || passController.text.isEmpty ) {
      showToast(Get.overlayContext!, msg: "Please fill all the fields", duration: 2);
      return;
    }

    isLoading.value = true;

    try {

      var data = {
        "email": emailController.text.trim(),
        "password": passController.text.trim(),
      };

      var response = await authServices.login(data);

      if (response != null && response['message'] == "Admin logged in successfully") {

        userSD = response;
        String token = response['token'];

        await Storage.setToken(token);
        await Storage.setLogin(userSD);

        Get.offAllNamed(kDashboardScreenRoute);
        showToast(Get.overlayContext!, msg: "Welcome to your account", duration: 2,backColor: kPrimaryColor);

      } else {
        showToast(Get.overlayContext!, msg: response['error'], duration: 2);

      }

    } catch (e) {
      showToast(Get.overlayContext!, msg: "$e", duration: 2);
    } finally {
      isLoading.value = false;
    }
  }


  goNext() async {
    var val = await Storage.getLogin();
    if (kDebugMode) {
      print("val=======$val");
    }

    if (val == false) {
      Get.offNamed(kAuthScreenRoute);
    } else {
      userSD = val;
      Get.offNamed(kDashboardScreenRoute);
    }
  }

  @override
  void onInit() {
    super.onInit();
    goNext();
  }

}