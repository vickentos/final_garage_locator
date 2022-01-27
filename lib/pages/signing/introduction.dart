import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/model/app_styles.dart';
import 'package:garage_locator/pages/signing/signing_both.dart';
import 'package:garage_locator/provider/size-config.dart';
import 'package:garage_locator/widgets/my_background.dart';
import 'package:garage_locator/widgets/my_rounded_btn.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeH!;
    double mWidth = SizeConfig.blockSizeW!;

    return MyBackground(
      child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Hello.',
                        style: introTitle,
                      )),
                  SizedBox(height: mHeight * 10),
                  Container(
                    width: mWidth * 40,
                    height: mWidth * 40,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('lib/assets/gllogo.png'),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(height: mHeight * 2),
                  Text('Garage Locator', style: introBodyTitle),
                ],
              ),
              SizedBox(height: mHeight * 10),
              Column(children: [
                MyRoundedButton(
                    buttonName: 'LOG IN',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const Signing(clickedLogin: true)));
                    },
                    bgColor: appGreen),
                const SizedBox(height: 20),
                MyRoundedButton(
                    buttonName: 'CREATE ACCOUNT',
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              const Signing(clickedLogin: false)));
                    },
                    bgColor: appGreenDark),
                const SizedBox(height: 40),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'By continuing, you are agreeing to our ',
                          style: introTerms),
                      TextSpan(
                          text: 'Terms & Conditions ', style: introTermsYellow),
                      TextSpan(text: 'of use.', style: introTerms)
                    ],
                  ),
                )
              ])
            ],
          ),
        ),
      )),
    );
  }
}
