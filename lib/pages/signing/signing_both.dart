import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:garage_locator/constants/color_constants.dart';
import 'package:garage_locator/model/app_styles.dart';
import 'package:garage_locator/provider/size-config.dart';
import 'package:garage_locator/widgets/my_background.dart';
import 'package:garage_locator/widgets/my_button.dart';
import 'package:garage_locator/widgets/my_txt_btn.dart';
import 'package:overlay_support/overlay_support.dart';

class Signing extends StatefulWidget {
  final bool clickedLogin;

  const Signing({Key? key, required this.clickedLogin}) : super(key: key);

  @override
  _SigningState createState() => _SigningState();
}

class _SigningState extends State<Signing> {
  ///___________________________________________________________________________CLASS VARIABLES
  String newUserusername = '';
  String newUserEmail = '';
  String newUserPassword = '';
  String email = '';
  String password = '';
  late bool isLogin;
  RegExp emailVAR = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool obscurePass = true;
  final GlobalKey<FormState> formSignInKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  ///___________________________________________________________________________Password Visibility
  void obscurePassword() {
    setState(() {
      obscurePass = !obscurePass;
    });
  }

  ///___________________________________________________________________________Change Signing Type
  changeSigning() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  void initState() {
    isLogin = widget.clickedLogin ? true : false;
    super.initState();
  }

  ///___________________________________________________________________________Widget Build
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double mHeight = SizeConfig.blockSizeH!;
    double mWidth = SizeConfig.blockSizeW!;

    return MyBackground(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Column(
                  children: [
                    ///_______________________________________________________HEADER ROW
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(isLogin ? 'Login.' : 'Sign up.',
                            style: introBodyTitle),
                      ],
                    ),
                    SizedBox(height: mHeight * 10),

                    ///_______________________________________________________FORM FIELDS
                    isLogin
                        ? Form(
                            key: formSignInKey,
                            child: Column(
                              children: [
                                buildEmail(email),
                                const SizedBox(height: 20),
                                buildPassword(password),
                                const SizedBox(height: 12),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: MyTextBtn(
                                        name: 'Forgot Password?',
                                        onPressed: () {},
                                        myTextStyle: forgotPasswordStyle)),
                                SizedBox(height: mHeight * 10),
                                MyButton(
                                    buttonName: 'Log in',
                                    onPressed: () {
                                      signIn();
                                    },
                                    bgColor: appGreen),
                                SizedBox(height: mHeight * 3),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'No Account?',
                                          style: signingOption),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = changeSigning,
                                          text: '   Sign Up.',
                                          style: signingOptionBtn),
                                    ],
                                  ),
                                )
                              ],
                            ))
                        : Form(
                            key: formSignUpKey,
                            child: Column(
                              children: [
                                buildEmail(newUserEmail),
                                const SizedBox(height: 20),
                                buildPassword(newUserPassword),
                                const SizedBox(height: 12),
                                SizedBox(height: mHeight * 10),
                                MyButton(
                                    buttonName: 'Create Account',
                                    onPressed: (){
                                      signUp();
                                    },
                                    bgColor: appGreen),
                                SizedBox(height: mHeight * 3),
                                RichText(
                                    text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Already registered?',
                                        style: signingOption),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = changeSigning,
                                        text: '   Sign In.',
                                        style: signingOptionBtn),
                                  ],
                                )),
                              ],
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///___________________________________________________________________________Email Text Form Field
  Widget buildEmail(String userEmail) => TextFormField(
        decoration: InputDecoration(
          labelText: 'email',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: whiteBackground,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value != null && !EmailValidator.validate(value)
            ? 'Enter a valid email'
            : null,
        onSaved: (value) {
          setState(() {
            userEmail = value!;
          });
        },
      );

  ///___________________________________________________________________________Password Text Form Field
  Widget buildPassword(String userPassword) => TextFormField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: obscurePass
                ? Icon(
                    Icons.visibility,
                    color: appGreen.withOpacity(0.6),
                  )
                : Icon(
                    Icons.visibility_off,
                    color: appGreen.withOpacity(0.6),
                  ),
            onPressed: obscurePassword,
          ),
          labelText: 'password',
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: whiteBackground,
        ),
        obscureText: obscurePass,
        validator: (value) {
          if (value!.length < 6) {
            return 'Password is too short';
          } else {
            null;
          }
        },
        onSaved: (value) {
          setState(() {
            userPassword = value!;
          });
        },
      );

  ///___________________________________________________________________________Sign Up Future
  Future signUp() async {
    var isValid = formSignUpKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: appGreen,
              ),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: newUserEmail,
        password: newUserPassword,
      );
    } on FirebaseAuthException catch (e) {
      showSimpleNotification(
        Text(e.message!),
        background: Colors.red,
      );
    }
  }

  ///___________________________________________________________________________Sign In Future
  Future signIn() async {
    var isValid = formSignInKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: appGreen,
              ),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      showSimpleNotification(Text(e.message!),
          background: Colors.red);
    }
  }
}
