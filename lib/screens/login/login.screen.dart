import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_solid_with_icon.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:friday_app/screens/kyc_verification/kyc_screen.dart';
import 'package:friday_app/screens/register/register_screen.dart';
import 'package:requests/requests.dart';

import 'login_input_email.dart';
import 'login_input_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: white,
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ContraText(
                      text: 'Friday',
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlutterLogo(
                        size: 200,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      ContraText(
                        text: "Login",
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      LoginEmailText(
                        controller: emailController,
                        text: "Email address",
                        iconPath: "assets/icons/user.svg",
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      LoginPasswordText(
                        controller: passwordController,
                        text: "..........",
                        iconPath: "assets/icons/lock.svg",
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      ButtonPlainWithIcon(
                        color: wood_smoke,
                        textColor: white,
                        iconPath: "assets/icons/arrow_next.svg",
                        isPrefix: false,
                        isSuffix: true,
                        text: "Sign in",
                        callback: () async {
                          print(
                              'email: ${emailController.text}, password: ${passwordController.text}');
                          String encoded = base64.encode(utf8.encode(
                              "${emailController.text}:${passwordController.text}"));
                          print('encoded: $encoded');

                          String statusString = "";

                          try {
                            var r = await Requests.get(
                              'http://192.168.1.193:8001/login/$encoded',
                              bodyEncoding: RequestBodyEncoding.JSON,
                            );
                            r.raiseForStatus();
                            String body = r.content();
                            print(body);

                            // login success, go to KYC screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KycScreen(),
                              ),
                            );

                          } on HTTPException catch (err) {
                            statusString = err.message;
                            print(err.message);
                          } catch (err) {
                            statusString = err.toString();
                            print(err);
                          }

                          final snackBar = SnackBar(content: Text(statusString));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "You are new? ",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: black,
                                ),
                              ),
                              TextSpan(
                                text: "Create new",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: flamingo,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   left: 24,
          //   top: 80,
          //   child: ButtonRoundWithShadow(
          //     size: 48,
          //     iconPath: "assets/icons/close.svg",
          //     borderColor: black,
          //     shadowColor: black,
          //     color: white,
          //     callback: () {
          //       // Navigator.of(context).pop();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}
