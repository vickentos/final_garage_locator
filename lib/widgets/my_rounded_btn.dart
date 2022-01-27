import 'package:flutter/material.dart';
import 'package:garage_locator/model/app_styles.dart';
import 'package:garage_locator/provider/size-config.dart';


class MyRoundedButton extends StatelessWidget {
  const MyRoundedButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 7,
        width: SizeConfig.blockSizeW! * 90,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: myTextBtn,
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0))
                  )
              )
          )
        ),
    );
  }
}