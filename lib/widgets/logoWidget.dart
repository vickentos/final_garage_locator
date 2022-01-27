import 'package:flutter/material.dart';
import 'package:garage_locator/model/app_styles.dart';


class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          height: appBarIconsIZE -1,
          width: appBarIconsIZE -1,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('lib/assets/translogo.png'), fit: BoxFit.contain
            )
          ),
        ),const SizedBox(width: 4),
        Text('Sure Bets', style: onBoardingBtn,)
      ],
    );
  }
}
