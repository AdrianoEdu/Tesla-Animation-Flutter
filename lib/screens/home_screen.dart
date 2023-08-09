import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teslacaranimation/constanins.dart';
import 'package:teslacaranimation/constants/Images.dart';
import 'package:teslacaranimation/home_controller.dart';

import '../components/shared/battery_status/batteryStatus.dart';
import '../components/shared/door_lock/door_lock.dart';
import '../components/shared/enum/enum.dart';
import '../components/shared/testa_bottom_navigation/tesla_bottom_navigation.dart';
import '../components/shared/tmp_btn/tmp.btn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}): super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;

  void setupBatteryAnimation(){
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  void setupTempAnimation(){
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1500),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    void selectShowHideAnimationLock(int index) {
      if(index == BottomNavigationBarIndex.BATTERY.index) {
        _batteryAnimationController.forward();
      }

      if(_controller.selectedBottomTab == 1 && index != 1) {
        _batteryAnimationController.reverse(from: 0.7);
      }
    }

    void selectShowHideAnimationBattery(int index) {
      if (index == BottomNavigationBarIndex.TEMP.index) {
        _tempAnimationController.forward();
      }
      if(_controller.selectedBottomTab == 2 && index != 2) {
        _tempAnimationController.reverse(from: 0.4);
      }
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              selectShowHideAnimationLock(index);
              selectShowHideAnimationBattery(index);

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
                    SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    ),
                    Positioned(
                      left: constraints.maxWidth / 2 * _animationCarShift.value,
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          carImagePath,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    ...ListAnimatedPositioned(_controller, constraints),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: getImageWithWidth(
                        batteryImagePath, 'battery',
                        constraints.maxWidth * 0.45
                      )
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constraints: constraints
                        )
                      ),
                    ),
                    ...ListTempBtn(_controller),
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

// ignore: non_constant_identifier_names
List<Widget> ListAnimatedPositioned(HomeController controller, BoxConstraints constraints) {
  return [
    AnimatedPositioned(
      duration: defaultDuration,
        right: getAnimatenPositionWidth(controller.selectedBottomTab, 0.05, 2, constraints),
        child: AnimatedOpacity(
          duration: defaultDuration,
          opacity: getOpacity(controller.selectedBottomTab),
          child: DoorLock(
            isLock: controller.isRightDoorLock,
            press: controller.updateRightDoorLock,
          ),
        ),
      ),
      AnimatedPositioned(
        duration: defaultDuration,
        left: getAnimatenPositionWidth(controller.selectedBottomTab, 0.05, 2, constraints),
        child: AnimatedOpacity(
          duration: defaultDuration,
          opacity: getOpacity(controller.selectedBottomTab),
          child: DoorLock(
            isLock: controller.isLeftDoorLock,
            press: controller.updateLeftDoorLock,
          ),
        ),
      ),
      AnimatedPositioned(
        duration: defaultDuration,
        top: getAnimatenPositionHeight(controller.selectedBottomTab, 0.15, 2, constraints),
        child: AnimatedOpacity(
          duration: defaultDuration,
          opacity: getOpacity(controller.selectedBottomTab),
          child: DoorLock(
            isLock: controller.isBonnetLock,
            press: controller.updateBonnetDoorLock,
          ),
        ),
      ),
      AnimatedPositioned(
        duration: defaultDuration,
        bottom: getAnimatenPositionHeight(controller.selectedBottomTab, 0.17, 2, constraints),
        child: AnimatedOpacity(
          duration: defaultDuration,
          opacity: getOpacity(controller.selectedBottomTab),
          child: DoorLock(
            isLock: controller.isTrunkLock,
            press: controller.updateTrunkDoorLock,
          ),
        ),
      ),
  ];
}

// ignore: non_constant_identifier_names
List<Widget> ListTempBtn(HomeController controller) {
  return [
    TempBtn(
      isActive: controller.isCoolSelected,
      svgSrc: coolShapeImagePath,
      title: 'Cool',
      press: controller.updateCoolSelectedTab,
    ),
    const SizedBox(width: defaultPadding,),
    TempBtn(
      isActive: controller.isCoolSelected,
      svgSrc: heatShapeImagePath,
      title: 'Heat',
      press: controller.updateCoolSelectedTab,
    )
  ];
}
SvgPicture getImageWithWidth (String pathImage, String keyValue, double width){
  return SvgPicture.asset(
    pathImage,
    key: ValueKey(keyValue),
    width: width,);
}

double getAnimatenPositionWidth(int index, double multiply, double divide, BoxConstraints constraints){
    if(index == 0) return constraints.maxWidth * multiply;

    return constraints.maxWidth / divide;
}

double getAnimatenPositionHeight(int index, double multiply, double divide, BoxConstraints constraints){
    if(index == 0) return constraints.maxHeight * multiply;

    return constraints.maxHeight / divide;
}

double getOpacity(int index) {
  if (index == 0) return 1;

  return 0;
}

