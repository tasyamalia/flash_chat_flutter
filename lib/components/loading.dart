import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.4),
      child: Center(
        child: LoadingAnimationWidget.twistingDots(
          leftDotColor: Colors.lightBlueAccent,
          rightDotColor: Colors.blueAccent,
          size: 100,
        ),
      ),
    );
  }
}
