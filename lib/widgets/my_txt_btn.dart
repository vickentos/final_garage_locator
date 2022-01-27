import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/model/app_styles.dart';

class MyTextBtn extends StatelessWidget {
  const MyTextBtn({
    required this.name,
    required this.onPressed,
    required this.myTextStyle,
    Key? key,
  }) : super(key: key);

  final String name;
  final VoidCallback onPressed;
  final TextStyle myTextStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: myTextStyle,
        ),
      ),
    );
  }
}
