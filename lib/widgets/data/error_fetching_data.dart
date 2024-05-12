import 'package:flutter/material.dart';

class ErrorFetchingData extends StatelessWidget {
  const ErrorFetchingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: Image(image: AssetImage('assets/error.png'))),
          SizedBox(height: 10),
          Text(
            'Something went wrong :(',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
