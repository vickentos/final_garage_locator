import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';

class HomeMenuLogo extends StatelessWidget {
  const HomeMenuLogo({Key? key, required this.onPressed,required this.mHeight}) : super(key: key);
  final VoidCallback onPressed;
  final double mHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: InkWell(
        splashColor: appGreen.withOpacity(0.5),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: whiteBackground,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
