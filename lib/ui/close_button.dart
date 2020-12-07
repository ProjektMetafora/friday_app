import 'package:flutter/material.dart';
import 'package:friday_app/screens/kyc_verification/kyc_screen.dart';
import 'package:friday_app/ui/round_button.dart';
import 'dart:async';

class FridayCloseButton extends StatelessWidget {

  const FridayCloseButton({ Key key, this.color, this.onPressed, this.iconSize }) : super(key: key);
  final Color color;

  final VoidCallback onPressed;

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      iconSize: iconSize != null ? iconSize : 24.0,
      icon: const Icon(Icons.close),
      color: color,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

