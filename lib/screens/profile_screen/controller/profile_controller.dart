import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../custom_widgets/loading.dart';
import '../../../services/storage.dart';
import '../../../services/user_services.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/helpers/global.dart';

class ProfileController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rxn<Uint8List> pickedImageBytes = Rxn<Uint8List>();
  Rxn<String> appLogoUrl = Rxn<String>();
  TextEditingController emailController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  var isLoading = false.obs;
  UserServices userServices = UserServices();

  Future<void> pickImageFromWeb() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      pickedImageBytes.value = bytes;
    }
  }

  updateProfile() async {
    if (emailController.text.isEmpty || fullNameController.text.isEmpty) {
      showToast(Get.overlayContext!, msg: "Please fill the required fields", duration: 2);
      return;
    }

    isLoading.value = true;

    try {
      final data = {
        "email": emailController.text.trim(),
        "name": fullNameController.text.trim(),
        "price": priceController.text.trim(),
      };

      print(data);

      final response = await userServices.editProfile(data, pickedImageBytes.value);

      print(response);

      final message = response['message']?.toString() ?? '';

      if (response != null && message == "Profile updated successfully") {
        userSD = response;
        await Storage.setLogin(userSD);

        showToast(
          Get.overlayContext!,
          msg: message,
          duration: 2,
          backColor: kPrimaryColor,
        );

      } else {
        showToast(
          Get.overlayContext!,
          msg: message.isNotEmpty ? message : "Something went wrong",
          duration: 2,
          backColor: kRedColor,
        );
      }

    } catch (e, stackTrace) {

      showToast(
        Get.overlayContext!,
        msg: "Server error occurred",
        duration: 2,
        backColor: kRedColor,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadProfile() async {
    final dynamic data = await Storage.getLogin();
    if (data != null && data is Map) {
      userSD = data;


      fullNameController.text = userSD['user']['name'] ?? '';
      priceController.text = userSD['user']['price'].toString() ?? '';

      emailController.text = userSD['user']['email'] ?? '';
      appLogoUrl.value = userSD['profileImageUrl'] ?? '';


      // log("appLogoUrl==========================${appLogoUrl.value}");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadProfile();
  }
}