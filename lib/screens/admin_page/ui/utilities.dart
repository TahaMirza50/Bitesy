
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class UploadImage{
    File? image;
    final picker = ImagePicker();

    File? getImage(){
      return image;
    }

    Future getGalleryImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    }

  Future removeImage() async {
    image = null;
  }

}