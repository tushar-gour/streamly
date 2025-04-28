import 'package:flutter/material.dart';
import 'package:streamly/globals/themes.dart';

class CustomLoginIcon extends StatelessWidget {
  const CustomLoginIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [gradient1, gradient2],
        ),
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Image.asset('assets/images/playbutton.png'),
      ),
    );
  }
}
