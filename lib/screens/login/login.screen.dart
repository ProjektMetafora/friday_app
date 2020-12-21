import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_solid_with_icon.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:friday_app/screens/kyc_verification/kyc_screen.dart';
import 'package:friday_app/screens/register/register_screen.dart';
import 'package:friday_app/services/login.service.dart';
import 'package:friday_app/ui/friday_text_form_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  @override
  void initState() {
    super.initState();

    // for debugging, just logout the user if they are signed in
    if (_googleSignIn.currentUser != null) {
      _googleSignIn.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: constraints.maxHeight + 200,
                  width: constraints.maxWidth,
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
                            size: 55,
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
                      Form(
                        child: Expanded(
                          flex: 9,
                          child: Column(
                            children: <Widget>[
                              ContraText(
                                text: "Login",
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FridayTextFormField(
                                obscureText: false,
                                labelText: 'Email',
                                controller: emailController,
                                text: "Email address",
                                iconPath: "assets/icons/user.svg",
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FridayTextFormField(
                                labelText: 'Password',
                                controller: passwordController,
                                text: "..........",
                                keyboardType: TextInputType.text,
                                iconPath: "assets/icons/lock.svg",
                                obscureText: true,
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
                                  String statusString = "LOGIN SUCCESS";
                                  bool success = false;

                                  LoginService.instance.loginUser(
                                      emailController.text,
                                      passwordController.text);

                                  if (LoginService.instance.currentUser !=
                                      null) {
                                    success = true;

                                    // login success, go to KYC screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KycScreen(),
                                      ),
                                    );
                                  }

                                  final snackBar = SnackBar(
                                    content: Text(statusString),
                                    backgroundColor:
                                        success ? Colors.green : Colors.red,
                                  );
                                  if (!success)
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: constraints.maxWidth,
                                  height: 48,
                                  child: SignInButton(
                                    Buttons.GoogleDark,
                                    elevation: 8.0,
                                    text: "Sign in with Google",
                                    onPressed: () async {
                                      try {
                                        await _googleSignIn.signIn();
                                        print(_googleSignIn.currentUser);
                                      } catch (error) {
                                        print(error);
                                      }
                                    },
                                    padding: EdgeInsets.all(0),
                                  ),
                                ),
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
                                                builder: (context) =>
                                                    RegisterScreen(),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
