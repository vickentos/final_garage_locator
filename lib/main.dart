import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garage_locator/pages/app_wrapper.dart';
import 'package:garage_locator/pages/home_screen/home_page.dart';
import 'package:garage_locator/pages/home_screen/details_page.dart';
import 'package:garage_locator/pages/home_screen/search_page.dart';
import 'package:garage_locator/pages/signing/introduction.dart';
import 'package:garage_locator/pages/signing/onboarding.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/color_constants.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  WidgetsFlutterBinding.ensureInitialized();

  ///___________________________________________to load onboarding screen first time only
  SharedPreferences prefs = await SharedPreferences.getInstance();
  seenOnboard = (prefs.getInt('seenOnboard') ?? false) as bool?;
  //_____if null set to null
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sure Odds',
        theme: ThemeData(
            primaryColor: appGreen,
            iconTheme: IconThemeData(color: linkColor),
            inputDecorationTheme: InputDecorationTheme(
              floatingLabelStyle: TextStyle(
                  color: Colors.black, backgroundColor: whiteBackground),
              border:
                  OutlineInputBorder(borderSide: BorderSide(color: linkColor)),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: linkColor),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: linkColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: linkColor),
              ),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.redAccent)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.redAccent)),
            ),
            scaffoldBackgroundColor: whiteBackground,
            colorScheme: const ColorScheme.light()),
        themeMode: ThemeMode.light,
        home: seenOnboard == true
            ? const AppWrapper()
            : const OnBoardingPage(),
      ),
    );
  }
}
