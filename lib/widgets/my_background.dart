import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:garage_locator/constants/color_constants.dart';

class MyBackground extends StatelessWidget {
  const MyBackground({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteBackground,
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: whiteBackground,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: whiteBackground),
        child: child,
      ),
    );
  }
}
