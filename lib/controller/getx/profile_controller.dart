import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

String defaultImagePath = 'assets/magical_destroyers.jpg';

class ProfileController extends GetxController {
  final Rx<XFile?> image = Rx<XFile?>(null);
}
