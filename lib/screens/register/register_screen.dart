import 'dart:convert';
import 'dart:math';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_plain_with_shadow.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_round_with_shadow.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:requests/requests.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class RegisterInputField extends StatelessWidget {
  final String text;
  final String iconPath;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextStyle hintStyle;

  const RegisterInputField(
      {Key key,
      this.text,
      this.iconPath,
      this.controller,
      this.keyboardType,
      this.obscureText,
      this.hintStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: obscureText == null ? false : obscureText,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: text != null ? text : '',
          hintStyle: hintStyle != null
              ? hintStyle
              : TextStyle(
                  fontSize: 21, fontWeight: FontWeight.w500, color: wood_smoke),
          contentPadding: EdgeInsets.all(16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: black),
              borderRadius: BorderRadius.all(Radius.circular(16))),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              iconPath,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  String countryCode;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 5,
                child: ListView(
                  padding: EdgeInsets.all(24),
                  children: <Widget>[
                    ContraText(
                      text: "Sign up",
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "You have chance to create new account if you really want to.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 21,
                          color: trout,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    RegisterInputField(
                      text: "Full Name",
                      iconPath: "assets/icons/user.svg",
                      keyboardType: TextInputType.name,
                      obscureText: false,
                      controller: fullNameController,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // LoginEmailText(
                    //   text: "Email address",
                    //   iconPath: "assets/icons/mail.svg",
                    // ),
                    RegisterInputField(
                      text: "Email",
                      iconPath: "assets/icons/mail.svg",
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CountryListPick(
                            appBar: AppBar(
                              backgroundColor: Colors.blue,
                              title: Text('Select Your Country'),
                            ),
                            pickerBuilder: (context, CountryCode countryCode) {
                              return Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      countryCode.flagUri,
                                      package: 'country_list_pick',
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // Text(countryCode.code),
                                  // Text(countryCode.dialCode),
                                ],
                              );
                            },
                            // To disable option set to false
                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: true,
                              isShowCode: true,
                              isDownIcon: true,
                              showEnglishName: true,
                            ),
                            // Set default value
                            initialSelection: '+91',
                            onChanged: (CountryCode code) {
                              print(code.name);
                              print(code.code);
                              print(code.dialCode);
                              print(code.flagUri);
                              countryCode = code.code;
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: RegisterInputField(
                            text: "Phone Number",
                            iconPath: "assets/icons/mail.svg",
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    RegisterInputField(
                      text: "\u25CF \u25CF \u25CF \u25CF \u25CF \u25CF",
                      iconPath: "assets/icons/lock.svg",
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      controller: passwordController,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: wood_smoke,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ButtonPlainWithShadow(
                      text: "Sign up",
                      shadowColor: wood_smoke,
                      borderColor: wood_smoke,
                      callback: () async {
                        String encoded = base64.encode(utf8.encode(
                            "${emailController.text}:${passwordController.text}|${Random.secure().nextInt(1000000)}"));

                        print('encoded: $encoded');

                        // split the name into first and last name
                        List<String> splitName =
                            fullNameController.text.split(" ");
                        String firstName = splitName[0].trim();
                        String lastName = splitName.sublist(1).join(" ").trim();

                        String statusMessage = "UNKNOWN";

                        try {
                          var r = await Requests.post(
                            'http://192.168.1.193:8001/register/$encoded',
                            body: {
                              "firstname": firstName,
                              "lastname": lastName,
                              "email": "${emailController.text}",
                              "country_code": countryCode,
                              "mob": phoneNumberController.text,
                            },
                            bodyEncoding: RequestBodyEncoding.JSON,
                          );
                          r.raiseForStatus();
                          String body = r.content();
                          print(body);

                          // register success
                          Navigator.of(context).pop();

                        } on HTTPException catch (err) {
                          statusMessage = err.message;
                          print(err.message);
                        } catch (err) {
                          statusMessage = err.toString();
                          print(err);
                        }

                        final snackBar = SnackBar(content: Text(statusMessage));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      color: lightening_yellow,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 24,
            top: 80,
            child: ButtonRoundWithShadow(
              size: 48,
              iconPath: "assets/icons/close.svg",
              borderColor: black,
              shadowColor: black,
              color: white,
              callback: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
