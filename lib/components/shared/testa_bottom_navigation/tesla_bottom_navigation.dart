import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/constants.dart';
import '../../../constants/Images.dart';
import '../../../model/ImagePath.dart';

// ignore: must_be_immutable
class TeslaBottomNavigationBar extends StatelessWidget {
  TeslaBottomNavigationBar({
    Key? key,
    required this.selectTab,
    required this.onTap,
  }) : super(key: key);

  final int selectTab;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: selectTab,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      items: List.generate(
        navIconSrc.length,
        (index) {
          ImagePath imagePath = navIconSrc.elementAt(index);
          return BottomNavigationBarItem(
            icon: getImageSelect(imagePath.path, imagePath.key, index, selectTab),
            label: ''
          );
        }
      )
    );
  }

  List<ImagePath> navIconSrc = [
    ImagePath(lockIconPath, 'lock'),
    ImagePath(chargeIconPath, 'charge'),
    ImagePath(tempIconPath, 'temp'),
    ImagePath(tyreIconPath, 'temp'),
    ImagePath(bluetoothIconPath, 'bluetooth'),
  ];

  }

  SvgPicture getImageSelect (String pathImage, String keyValue, int index, int select){
  return SvgPicture.asset(
    pathImage,
    key: ValueKey(keyValue),
    color: index == select ? primaryColor : Colors.white54,
    width: 40,
    height: 40,
  );
}
