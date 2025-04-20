import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PhotoService extends GetxService {
  final ImagePicker _picker = ImagePicker();

  final selectedImage = Rxn<File>();

  Future<void> pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    final croppedFile = await cropImage(File(pickedImage.path));
    if (croppedFile == null) return;

    selectedImage.value = croppedFile;
  }

  Future<void> pickImageFromCamera() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;

    final croppedFile = await cropImage(File(pickedImage.path));
    if (croppedFile == null) return;

    selectedImage.value = croppedFile;

  }

  Future<File?> cropImage(File file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Chỉnh sửa ảnh',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Chỉnh sửa ảnh',
          aspectRatioLockEnabled: false,
        ),
      ],
    );

    if (croppedFile == null) return null;

    return File(croppedFile.path);
  }
}

