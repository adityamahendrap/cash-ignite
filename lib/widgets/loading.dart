import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitWaveSpinner(
      color: Colors.white,
      size: 50.0,
      waveColor: Colors.blue,
      trackColor: Colors.blue,
      curve: Curves.easeInOutCubic,
    );
  }
}