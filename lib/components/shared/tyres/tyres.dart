import 'package:flutter/cupertino.dart';

import '../../../constants/Images.dart';
import '../door_lock/door_lock.dart';

List<Widget> tyres(BoxConstraints constraints) {
  return [
    Positioned(
      left: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.22,
      child: getImage(flTyreImagePath, 'flTyre1'),
    ),
    Positioned(
      right: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.22,
      child: getImage(flTyreImagePath, 'flTyre2'),
    ),
    Positioned(
      right: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.63,
      child: getImage(flTyreImagePath, 'flTyre3'),
    ),
    Positioned(
      left: constraints.maxWidth * 0.2,
      top: constraints.maxHeight * 0.63,
      child: getImage(flTyreImagePath, 'flTyre4'),
    )
  ];
}
