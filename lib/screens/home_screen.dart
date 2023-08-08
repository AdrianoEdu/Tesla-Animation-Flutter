import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teslacaranimation/constanins.dart';
import 'package:teslacaranimation/constants/Images.dart';
import 'package:teslacaranimation/home_controller.dart';

import '../components/shared/testa_bottom_navigation/tesla_bottom_navigation.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}): super(key: key);

  final HomeController _controller = HomeController();
  @override
  Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              _controller.onBottomnavigationChange(index);
            },
            selectTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.1),
                      child: SvgPicture.asset(
                        carImagePath,
                        width: double.infinity,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: getAnimatenPosition(_controller.selectedBottomTab, 0.05, 2, constraints),
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: getOpacity(_controller.selectedBottomTab),
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: getAnimatenPosition(_controller.selectedBottomTab, 0.05, 2, constraints),
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: getOpacity(_controller.selectedBottomTab),
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: getAnimatenPosition(_controller.selectedBottomTab, 0.13, 2, constraints),
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: getOpacity(_controller.selectedBottomTab),
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: getAnimatenPosition(_controller.selectedBottomTab, 0.17, 2, constraints),
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: getOpacity(_controller.selectedBottomTab),
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkDoorLock,
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
          ),
        );
      }
    );
  }
}


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

double getAnimatenPosition(int index, double multiply, double divide, BoxConstraints constraints){
    if(index == 0) {
      return constraints.maxWidth * multiply;
    }

    return constraints.maxWidth / divide;
}


double getOpacity(int index) {
  if(index == 0) {
    return 1;
  }

  return 0;
}
