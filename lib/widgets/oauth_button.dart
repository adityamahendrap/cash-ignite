import 'package:flutter/material.dart';

class OauthButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final Function()? onPressed;

  const OauthButton({
    Key? key,
    required this.iconPath,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: this.onPressed,
      icon: SizedBox(
        height: 24,
        child: Image.asset(this.iconPath),
      ),
      label: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        shape: StadiumBorder(),
        side: BorderSide(color: Colors.grey, width: 0.6),
      ),
    );
  }
}
