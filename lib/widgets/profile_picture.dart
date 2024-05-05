import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progmob_magical_destroyers/controller/getx/profile_controller.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  // XFile? _image;
  final _profileC = Get.find<ProfileController>();

  final _picker = ImagePicker();

  Future getImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    // setState(() {
    // if (pickedImage != null) _image = pickedImage;
    // });

    if (pickedImage != null) _profileC.image.value = pickedImage;
  }

  Future getImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);

    // setState(() {
    // if (pickedImage != null) _image = pickedImage;
    // });

    if (pickedImage != null) _profileC.image.value = pickedImage;
  }

  Future showChangeImageOptions({required ImageProvider currentImage}) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('See Current Picture'),
            onPressed: () {
              Navigator.of(context).pop();
              Get.to(() => ShowPhotoView(image: currentImage));
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Select From Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Take A Picture'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Delete Picture', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                // _image = null;
                _profileC.image.value = null;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showChangeImageOptions(
          currentImage: _profileC.image.value != null
              ? FileImage(File(_profileC.image.value!.path))
              : AssetImage(defaultImagePath) as ImageProvider),
      child: Stack(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundImage: _profileC.image.value != null
                  ? FileImage(File(_profileC.image.value!.path))
                  : AssetImage(defaultImagePath) as ImageProvider,
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
