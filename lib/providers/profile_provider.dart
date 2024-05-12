import 'dart:io';

import 'package:color_log/color_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

String defaultImagePath = 'assets/magical_destroyers.jpg';

class ProfileProvider extends ChangeNotifier {
  ImageProvider<Object> _imageProvider = AssetImage(defaultImagePath);

  ImageProvider<Object> get imageProvider => _imageProvider;

  void setImageProvider(XFile? imageCrossFile) {
    if (imageCrossFile != null) {
      _imageProvider = FileImage(File(imageCrossFile.path));
    } else {
      _imageProvider = AssetImage(defaultImagePath);
    }
    clog.debug('Image Provider: $_imageProvider');
    notifyListeners();
  }
}
