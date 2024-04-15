import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<dynamic> bottomSheetFitContentWrapper({
  required BuildContext context,
  required Widget content,
  bool enableDrag = true,
  bool isHorizontalPaddingActive = true,
}) {
  return showMaterialModalBottomSheet(
    context: context,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isHorizontalPaddingActive ? 20 : 0,
          ),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(height: 4, width: 50, color: Colors.grey.shade300),
              SizedBox(height: 20),
              content,
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ),
  );
}
