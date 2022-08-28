import 'dart:io';

import 'package:banja/utils/customOverlay.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FilePicker {
  static late File imageFile;

  static Future getImage(String fileName, Function setter) async {
    final imagePref = GetStorage();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        preferredCameraDevice: CameraDevice.front,
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 60);

    String dir = (await getApplicationDocumentsDirectory()).path;
    String newPath = path.join(dir, '$fileName.jpg');
    File newFile = await File(pickedFile!.path).copy(newPath);
    imageFile = newFile;

    setter(() {
      imagePref.write(fileName, newFile.path);
      imagePref.write(
          '${fileName}Name', newFile.path.split('/').toList().last.toString());
    });
    CustomOverlay.showToast(
        'Image selected successfully!', Colors.orange.shade400, Colors.white);
  }
}

class GetImagePath {
  GetImagePath._();

  static String _uploadedFileURL = '';
  static Future<String> uploadFile(File imageFile) async {
    
    var preference = GetStorage();
    var phone = preference.read('phone');
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('clientBase/$phone');

    await storageReference.putFile(imageFile);

    _uploadedFileURL = await storageReference.getDownloadURL();
    return _uploadedFileURL;
  }
}
