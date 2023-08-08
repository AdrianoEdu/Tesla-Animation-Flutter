import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teslacaranimation/constanins.dart';

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
          ImagePath imagePath = getObjectImage(navIconSrc.elementAt(index));
          return BottomNavigationBarItem(
            icon: getImageSelect(imagePath.path, imagePath.key, index, selectTab),
            label: ''
          );
        }
        )
    );
  }

  List<Map<String, Object>> navIconSrc = [
    {'lock': {'path': lockImagePath, 'key': 'lock'}},
    {'charge': {'path': chargeImagePath, 'key': 'charge'}},
    {'temp': {'path': tempImagePath, 'key': 'temp'}},
    {'tyre': {'path': tyreImagePath, 'key': 'tyre'}},
  ];

   getObjectImage(Map<String, Object> value) {
    dynamic json = value.entries.first.value;
    return ImagePath.fromJson(json);
  }

  SvgPicture getImageSelect (String pathImage, String keyValue, int index, int select){
  return SvgPicture.asset(
    pathImage,
    key: ValueKey(keyValue),
    color: index == select ? primaryColor : Colors.white54,
  );
}
}
