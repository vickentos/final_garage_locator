import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/model/app_styles.dart';
import 'package:garage_locator/model/onboarding_data.dart';
import 'package:garage_locator/provider/size-config.dart';
import 'package:garage_locator/widgets/my_background.dart';
import 'package:garage_locator/widgets/my_button.dart';
import 'package:garage_locator/widgets/my_txt_btn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';
import 'introduction.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  ///_____________________________________________________VARIABLES
  final PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  ///_____________________________________________________set seenonboard
  Future setSeenonboard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    seenOnboard = await pref.setBool('seenOnboard', true);
  }

  ///____________________________________________________dot indicator
  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 400),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? linkColor : appGreen,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///___________________________________________________initialize size config
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;

    return MyBackground(
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 9,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        },
                        itemCount: onBoardingContents.length,
                        itemBuilder: (context, index) => Column(children: [
                          SizedBox(height: sizeH * 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              onBoardingContents[index].description,
                              style: currentPage == 0
                                  ? onBoardingStartText
                                  : onBoardingBodyText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: sizeH * 5),
                          SizedBox(
                            height: sizeH * 45,
                            child: Image.asset(
                              onBoardingContents[index].imagePath,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: sizeH * 5),

                        ]),
                      )),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center,
                      children: [
                        currentPage == onBoardingContents.length - 1
                            ? MyButton(
                                buttonName: 'Get Started',
                                bgColor: appGreen,
                                onPressed: () {
                                  setSeenonboard();
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const IntroductionPage()));
                                },
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MyTextBtn(
                                    name: 'Skip',
                                    onPressed: () {
                                      setSeenonboard();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const IntroductionPage()));
                                    },
                                    myTextStyle: onBoardingBtn,
                                  ),
                                  Row(
                                      children: List.generate(
                                          onBoardingContents.length,
                                          (index) => dotIndicator(index))),
                                  GestureDetector(
                                    child: Icon(Icons.arrow_forward_ios_outlined,color: appGreen, size: 32),
                                    onTap: () {
                                      _pageController.nextPage(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          curve: Curves.easeInOut);
                                    },
                                  )
                                ],
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}

