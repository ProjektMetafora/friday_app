import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_round_with_shadow.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_solid_with_icon.dart';
import 'package:friday_app/contrauikit/custom_widgets/contra_button.dart';
import 'package:friday_app/contrauikit/custom_widgets/contra_input_box.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class KycScreen extends StatefulWidget {
  KycScreen({Key key}) : super(key: key);

  @override
  _KycScreenState createState() => _KycScreenState();
}

final currStepProvider = StateProvider((ref) => 0);

class _KycScreenState extends State<KycScreen> {
  List<Widget> stepScreens = [KYCOnboardingScreen(), KYCForm()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer(
            builder: (context, watch, _) {
              final step = watch(currStepProvider).state;
              return stepScreens[step];
            },
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
                context.read(currStepProvider).state = 0;
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}

class KYCForm extends StatefulWidget {
  @override
  _KYCFormState createState() => _KYCFormState();
}

class _KYCFormState extends State<KYCForm> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  Image imagePreview;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: 130,
              ),
              ContraText(
                alignment: Alignment.centerLeft,
                text: "KYC Details",
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContraInputBox(
                  hintText: "Full Name",
                  showPrefix: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContraInputBox(
                  hintText: "PAN/Aadhar Card",
                  showPrefix: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ButtonPlainWithIcon(
                  color: wood_smoke,
                  textColor: white,
                  iconPath: "assets/icons/arrow_next.svg",
                  isPrefix: false,
                  isSuffix: true,
                  text: "Image Proof",
                  callback: () async {
                    try {
                      final pickedFile = await _picker.getImage(
                        source: ImageSource.gallery,
                      );
                      setState(() {
                        _imageFile = pickedFile;
                        imagePreview = Image.file(File(pickedFile.path));
                      });
                    } catch (e) {}
                  },
                ),
              ),
              Container(
                height: 200.0,
                child: imagePreview,
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ContraButton(
                  borderColor: persian_blue,
                  text: "Confirm",
                  color: persian_blue,
                  textColor: white,
                  callback: () {},
                  height: 50,
                  isPrefix: true,
                  shadowColor: persian_blue,
                  isSuffix: false,
                  iconPath: "assets/icons/ic_heart_fill.svg",
                  iconColor: white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KYCOnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      "assets/images/onboarding_image_four.svg",
                      height: 340,
                      width: 310,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                  child: Text(
                    'KYC Verification',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 44,
                        color: wood_smoke,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                  child: Text(
                    'Complete your KYC to get started with Friday !',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 18,
                        color: wood_smoke,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 8, right: 24),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    child: Consumer(
                      builder: (context, watch, _) {
                        return RaisedButton(
                          padding: EdgeInsets.all(16),
                          color: wood_smoke,
                          onPressed: () {
                            context.read(currStepProvider).state++;
                          },
                          textColor: white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Get Started",
                                style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SvgPicture.asset(
                                    "assets/icons/arrow_next.svg"),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(16.0)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
