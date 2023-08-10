import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teslacaranimation/components/shared/temp_details/temp_details.dart';
import 'package:teslacaranimation/constanins.dart';
import 'package:teslacaranimation/constants/Images.dart';
import 'package:teslacaranimation/home_controller.dart';
import 'package:teslacaranimation/model/TyrePsi.dart';

import '../components/shared/battery_status/batteryStatus.dart';
import '../components/shared/door_lock/door_lock.dart';
import '../components/shared/tyre_psi_card/tyre_psi_card.dart';
import '../components/shared/tyres/tyres.dart';
import '../enum/enum.dart';
import '../components/shared/testa_bottom_navigation/tesla_bottom_navigation.dart';

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
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  late AnimationController _tyreAnimationcontroller;
  late Animation<double> _animationTyrePs1;
  late Animation<double> _animationTyrePs2;
  late Animation<double> _animationTyrePs3;
  late Animation<double> _animationTyrePs4;

  late List<Animation<double>> _tyreAnimations;

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

    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );

    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );

  }

  void setupTyreAnimation() {
    _tyreAnimationcontroller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animationTyrePs1 = CurvedAnimation(
      parent: _tyreAnimationcontroller,
      curve: const Interval(0.34, 0.5),
    );
     _animationTyrePs2 = CurvedAnimation(
      parent: _tyreAnimationcontroller,
      curve: const Interval(0.5, 0.66),
    );
     _animationTyrePs3 = CurvedAnimation(
      parent: _tyreAnimationcontroller,
      curve: const Interval(0.66, 0.82),
    );
     _animationTyrePs4 = CurvedAnimation(
      parent: _tyreAnimationcontroller,
      curve: const Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _animationTyrePs1,
      _animationTyrePs2,
      _animationTyrePs3,
      _animationTyrePs4,
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationcontroller.dispose();
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

    void selectShowHideAnimationTyre(index) {
      if (index == BottomNavigationBarIndex.TYRE.index) {
        _tyreAnimationcontroller.forward();
      }
      if(_controller.selectedBottomTab == 3 && index != 3) {
        _tyreAnimationcontroller.reverse();
      }
    }

    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryAnimationController,
        _tempAnimationController,
        _tyreAnimationcontroller
      ]),
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              selectShowHideAnimationLock(index);
              selectShowHideAnimationBattery(index);
              selectShowHideAnimationTyre(index);

              _controller.showTyreController(index);
              _controller.tyreStatusController(index);
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
                          carIconPath,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    ...ListAnimatedPositioned(_controller, constraints),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: getImageSvgWithWidth(
                        batteryIconPath, 'battery',
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
                    Positioned(
                      height: constraints.maxHeight,
                      width:  constraints.maxWidth,
                      top:  60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(controller: _controller)),
                    ),
                    Positioned(
                        right: -180 * (1 - _animationCoolGlow.value),
                        child: AnimatedSwitcher(
                          duration: defaultDuration,
                          child: _controller.isCoolSelected ?
                            Image.asset(coolGlowImagePath, key: UniqueKey(), width: 200):
                            Image.asset(hootGlowImagePath, key: UniqueKey(), width: 200)
                        ),
                      ),
                    if (_controller.isShowTyre)...tyres(constraints),
                    if (_controller.isShowTyreStatus)
                    GridView.builder(
                      itemCount: 4,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: defaultPadding,
                        crossAxisSpacing: defaultPadding,
                        childAspectRatio: constraints.maxWidth / constraints.maxHeight,
                      ),
                      itemBuilder: (context, index) => ScaleTransition(
                        scale: _tyreAnimations[index],
                        child: TyrePsiCard(
                          isBottomTwoTyre:
                          index > 1,
                          tyrePsi: demoPsiList[index]
                        ),
                      ),
                      )
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



SvgPicture getImageSvgWithWidth (String pathImage, String keyValue, double width){
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

