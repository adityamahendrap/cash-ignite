import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final String text;

  const HorizontalDivider({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Divider(
          indent: 0,
          endIndent: 10.0,
          thickness: 1,
          color: Colors.grey.shade400,
        ),
      ),
      Text(this.text),
      Expanded(
        child: Divider(
          indent: 10.0,
          endIndent: 0,
          thickness: 1,
          color: Colors.grey.shade400,
        ),
      ),
    ]);
  }
}
