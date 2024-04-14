import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> dialogWrapper({
  required BuildContext context,
  bool? barrierDismissible = true,
  required Widget content,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: barrierDismissible!,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        insetPadding: EdgeInsets.all(20),
        content: SingleChildScrollView(child: content),
      );
    },
  );
}
