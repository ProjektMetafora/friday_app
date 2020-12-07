import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:friday_app/contrauikit/custom_widgets/button_solid_with_icon.dart';
import 'package:friday_app/contrauikit/custom_widgets/contra_button.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:friday_app/screens/home/home_screen.dart';
import 'package:friday_app/ui/close_button.dart';
import 'package:friday_app/ui/friday_text_form_field.dart';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Consumer(
                builder: (context, watch, _) {
                  final step = watch(currStepProvider).state;
                  return stepScreens[step];
                },
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
                          context.read(currStepProvider).state = 0;
                          Navigator.maybePop(context);
                        },
                        iconSize: 40.0,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
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
              Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FridayTextFormField(
                        labelText: 'Name',
                        text: "Full Name",
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FridayTextFormField(
                        labelText: 'PAN/Aadhar Card',
                        text: "XXXX-XXXX-XXXX",
                        keyboardType: TextInputType.number,
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
                  ],
                ),
              ),
              imagePreview != null
                  ? Container(
                      height: 200.0,
                      child: imagePreview,
                    )
                  : Container(
                      height: 8,
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
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  height: 50,
                  isPrefix: false,
                  shadowColor: persian_blue,
                  isSuffix: true,
                  iconPath: "assets/icons/arrow_next.svg",
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
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SvgPicture.asset(
                        "assets/images/kyc/undraw_certification_aif8.svg",
                        height: 340,
                        width: 310,
                      ),
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
