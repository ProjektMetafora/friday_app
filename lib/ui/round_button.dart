import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonRound extends StatelessWidget {
  final Color borderColor;
  final Color color;
  final String iconPath;
  final VoidCallback callback;
  final double size;
  final Color shadowColor;

  const ButtonRound(
      {this.borderColor,
      this.color,
      this.iconPath,
      this.size,
      this.callback,
      this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: size == null ? null : size,
        width: size == null ? null : size,
        padding: EdgeInsets.all(size != null ? 8 : 16),
        child: SvgPicture.asset(
          iconPath,
        ),
        decoration: ShapeDecoration(
          shadows: this.shadowColor != null
              ? [
                  BoxShadow(
                    color: shadowColor,
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      4.0, // Move to bottom 5 Vertically
                    ),
                  )
                ]
              : null,
          color: color,
          shape: CircleBorder(
            side: BorderSide(color: borderColor, width: 2),
          ),
        ),
      ),
    );
  }
}
