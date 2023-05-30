
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Bitesy/constants/constants.dart';

class UploadImage{
    File? image;
    final picker = ImagePicker();

    // constructor
    UploadImage({this.image});

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

  Future<String> upLoadToFirebase(String name) async {
    
    String url = '404';
    Reference ref = Constants.storage.ref().child('images/$name/'+Constants.IDGenerator.v1());
    UploadTask uploadTask = ref.putFile(image!);

    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
      
    }).catchError((onError) {
      print(onError);
    });

    return url;

    // await Future.value(uploadTask);


  }

}