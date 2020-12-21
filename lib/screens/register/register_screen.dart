import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_solid_with_icon.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:friday_app/models/user_model.dart';
import 'package:friday_app/services/login.service.dart';
import 'package:friday_app/ui/close_button.dart';
import 'package:friday_app/ui/friday_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String countryCode = "+91";

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Form(
                        child: Expanded(
                          flex: 6,
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
                              FridayTextFormField(
                                labelText: 'Name',
                                controller: fullNameController,
                                text: "Full Name",
                                iconPath: "assets/icons/user.svg",
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FridayTextFormField(
                                labelText: 'Email',
                                controller: emailController,
                                text: "Email ID",
                                iconPath: "assets/icons/mail.svg",
                                keyboardType: TextInputType.emailAddress,
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
                                      pickerBuilder:
                                          (context, CountryCode countryCode) {
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
                                    child: FridayTextFormField(
                                      labelText: 'Phone',
                                      controller: phoneNumberController,
                                      text: "Phone Number",
                                      iconPath: "assets/icons/phone-call.svg",
                                      keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              FridayTextFormField(
                                labelText: 'Password',
                                controller: passwordController,
                                text:
                                    "\u25CF \u25CF \u25CF \u25CF \u25CF \u25CF",
                                keyboardType: TextInputType.text,
                                iconPath: "assets/icons/lock.svg",
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              ButtonPlainWithIcon(
                                color: wood_smoke,
                                textColor: white,
                                iconPath: "assets/icons/arrow_next.svg",
                                isPrefix: false,
                                isSuffix: true,
                                text: "Sign up",
                                callback: () async {
                                  // split the name into first and last name
                                  List<String> splitName =
                                      fullNameController.text.split(" ");
                                  String firstName = splitName[0].trim();
                                  String lastName =
                                      splitName.sublist(1).join(" ").trim();

                                  String statusMessage = "REGISTER SUCCESS";

                                  bool success = false;

                                  FridayRegisterUser user = FridayRegisterUser(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      firstName: firstName,
                                      lastName: lastName,
                                      countryCode: countryCode,
                                      mob: phoneNumberController.text);

                                  LoginService.instance.registerUser(user);

                                  if (LoginService.instance.currentUser !=
                                      null) {
                                    success = true;
                                    // register success
                                    Navigator.of(context).pop();
                                  }

                                  final snackBar = SnackBar(
                                    content: Text(statusMessage),
                                    backgroundColor:
                                        success ? Colors.green : Colors.red,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  // left: 24,
                  top: 60,
                  child: Container(
                    color: Colors.white70,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 60,
                    width: constraints.maxWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FridayCloseButton(
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                          iconSize: 40.0,
                          color: Colors.red,
                        ),
                      ],
                    ),
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
