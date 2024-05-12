import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: Image(image: AssetImage('assets/empty.png'))),
          SizedBox(height: 10),
          Text(
            'Nothing to see here :(',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
