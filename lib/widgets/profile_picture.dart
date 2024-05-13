import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progmob_magical_destroyers/providers/profile_provider.dart';
import 'package:progmob_magical_destroyers/widgets/photo_view.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final _picker = ImagePicker();

  Future getImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null)
      context.read<ProfileProvider>().setImageProvider(pickedImage);
  }

  Future getImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null)
      context.read<ProfileProvider>().setImageProvider(pickedImage);
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
              context.read<ProfileProvider>().setImageProvider(null);
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
          currentImage: context.read<ProfileProvider>().imageProvider),
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: context.watch<ProfileProvider>().imageProvider,
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
