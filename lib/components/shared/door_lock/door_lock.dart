import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constanins.dart';
import '../../../constants/Images.dart';

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) =>
        ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: validatingDoorLock(isLock),
      ),
    );
  }
}

SvgPicture validatingDoorLock (bool isLock) {
  if(isLock){
    return getImage(doorLockImagePath, 'lock');
  }
  else {
    return getImage(doorUnlockImagePath, 'unlock');
  }
}

SvgPicture getImage (String pathImage, String keyValue){
  return SvgPicture.asset(pathImage, key: ValueKey(keyValue));
}
