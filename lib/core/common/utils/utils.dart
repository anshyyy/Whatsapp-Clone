import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:whatsapp/exports.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "SomeThing Went Wrong!!",
        style: TextStyle(color: blackColor),
      ),
      backgroundColor: tabColor,
    ));
  }

  return image;
}
