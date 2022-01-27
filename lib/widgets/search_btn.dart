import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({Key? key, required this.onPressed, required this.mHeight})
      : super(key: key);
  final double mHeight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: appGreen,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                )
              ]),
          child: Icon(
            Icons.location_searching_sharp,
            color: whiteBackground,
            size: mHeight * 4.5,
          )),
    );
  }
}
