import 'package:flutter/material.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';

class ConfirmationDialogContent extends StatelessWidget {
  final Function onConfirmed;
  final Function onCanceled;
  final String? text;
  final Widget? textWidget;
  final String confirmText;

  const ConfirmationDialogContent({
    super.key,
    this.text,
    this.textWidget,
    required this.onConfirmed,
    required this.onCanceled,
    required this.confirmText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        textWidget ??
            Text(
              text!,
              style: TextStyle(fontSize: 16),
            ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => onCanceled(),
              child: Text('Cancel'),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => onConfirmed(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPlanet.primary,
                elevation: 0,
              ),
              child: Text(confirmText, style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ],
    );
  }
}
