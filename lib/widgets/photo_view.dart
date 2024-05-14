import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart' as pub_dev_photo_view;

class PhotoView extends StatefulWidget {
  final ImageProvider image;

  const PhotoView({super.key, required this.image});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  bool isBackButtonVisible = true;

  void _toggleBackButtonVisibility() {
    setState(() {
      isBackButtonVisible = !isBackButtonVisible;
    });
  }

  void _onBackButtonPressed() {
    if (isBackButtonVisible) Get.back();
    _toggleBackButtonVisibility();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => _toggleBackButtonVisibility(),
        child: Stack(
          children: [
            Container(
              child: pub_dev_photo_view.PhotoView(
                imageProvider: this.widget.image,
              ),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              opacity: isBackButtonVisible ? 1 : 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.arrow_left,
                    color: Colors.white,
                  ),
                  onPressed: () => _onBackButtonPressed(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
