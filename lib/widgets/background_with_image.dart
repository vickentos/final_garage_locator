import 'package:flutter/material.dart';

class IntroBackImage extends StatelessWidget {
  String imagePath;
  Widget? child;
  IntroBackImage({
    this.child,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover)),
      child: child,
    );
  }
}
