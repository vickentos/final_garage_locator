import 'package:flutter/material.dart';

class IntroBackColor extends StatelessWidget {
  final Color introColor;
  Widget? child;
  IntroBackColor({
    this.child,
    required this.introColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: introColor),
      child: child,
    );
  }
}
