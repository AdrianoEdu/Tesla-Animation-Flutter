import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constanins.dart';
import '../../../constants/Images.dart';

class TempBtn extends StatelessWidget {
    const TempBtn({
    Key? key,
    required this.svgSrc,
    required this.title,
    required this.press,
    this.isActive = false,
    this.activeColor = primaryColor
  }): super(key: key);

  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutBack,
            height: getSizeByFlag(isActive, 76, 50),
            width: getSizeByFlag(isActive, 76, 50),
            child: getImageWithColor(
              coolShapeImagePath,
              'coolShape',
              getColorByFlag(isActive, primaryColor, Colors.white38)
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              fontSize: 16,
              color: getColorByFlag(isActive, primaryColor, Colors.white38),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            child: Text(
              title.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}

double getSizeByFlag(bool flag, double valueIfTrue, double valueIfFalse)
{
  if(flag) return valueIfTrue;

  return valueIfFalse;
}

SvgPicture getImageWithColor (String pathImage, String keyValue, Color colors){
  return SvgPicture.asset(
    pathImage,
    key: ValueKey(keyValue),
    color: colors,);
}

Color getColorByFlag(bool flag, Color colorIfTrue, Color colorIfFalse){
  if(flag) return colorIfTrue;

  return colorIfFalse;
}
