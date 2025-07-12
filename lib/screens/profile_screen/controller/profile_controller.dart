import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_colors.dart';

class ProfileController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rxn<Uint8List> pickedImageBytes = Rxn<Uint8List>();

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  Future<void> pickImageFromWeb() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      pickedImageBytes.value = bytes;
    }
  }
}