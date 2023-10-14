import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService extends StatefulWidget {
  const ImagePickerService({super.key});

  @override
  State<ImagePickerService> createState() => _ImagePickerServiceState();
  Future getImageFromCamera() async {}
  Future getImageFromGallery() async {}
}

class _ImagePickerServiceState extends State<ImagePickerService> {
  File? image;
  final picker = ImagePicker();

//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
    return image;
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image != null
                ? Image.file(image!)
                : const Text("Nenhuma imagem selecionada"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: getImageFromGallery,
              child: const Text("Escolher da galeria"),
            ),
            ElevatedButton(
              onPressed: getImageFromCamera,
              child: const Text("Tirar foto"),
            ),
          ],
        ),
      ),
    );
  }
}
