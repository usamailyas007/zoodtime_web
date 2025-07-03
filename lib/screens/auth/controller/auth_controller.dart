import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isPasswordHidden = true.obs;
  var emailController = TextEditingController();
  var passController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}