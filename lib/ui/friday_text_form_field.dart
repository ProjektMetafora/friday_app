import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';

class FridayTextFormField extends StatelessWidget {
  final String text;
  final String iconPath;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final bool obscureText;

  const FridayTextFormField(
      {this.text,
      this.iconPath,
      this.controller,
      this.keyboardType,
      this.labelText,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: obscureText != null ? obscureText : false,
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(
            fontSize: 21, fontWeight: FontWeight.w500, color: wood_smoke),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w900, color: wood_smoke),
          hintText: text,
          hintStyle: TextStyle(
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
          prefixIcon: iconPath != null
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
