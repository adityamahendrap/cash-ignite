import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ShowPhotoView extends StatelessWidget {
  final ImageProvider image;

  const ShowPhotoView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
      imageProvider: this.image,
    ));
  }
}
