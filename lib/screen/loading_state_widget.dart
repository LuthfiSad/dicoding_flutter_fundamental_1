import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/loading_animation.json',
        width: 300,
        height: 300,
        fit: BoxFit.contain,
      ),
    );
  }
}
