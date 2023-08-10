import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
    bool isRightDoorLock = true;
    bool isLeftDoorLock = true;
    bool isBonnetLock = true;
    bool isTrunkLock = true;
    bool isCoolSelected = true;
    bool isShowTyre = false;

    int selectedBottomTab = 0;

    void showTyreController(int index) {
      if (selectedBottomTab != 3 && index == 3) {
        Future.delayed(const Duration(milliseconds: 400), () {
          isShowTyre = true;
          notifyListeners();
        });
      }
      else {
        isShowTyre = false;
        notifyListeners();
      }
    }

    void onBottomnavigationChange(int index) {
      selectedBottomTab = index;
      notifyListeners();
    }

    void updateRightDoorLock() {
      isRightDoorLock = !isRightDoorLock;
      notifyListeners();
    }

    void updateLeftDoorLock()
    {
      isLeftDoorLock = !isLeftDoorLock;
      notifyListeners();
    }

    void updateBonnetDoorLock(){
      isBonnetLock = !isBonnetLock;
      notifyListeners();
    }

    void updateTrunkDoorLock(){
      isTrunkLock = !isTrunkLock;
      notifyListeners();
    }

    void updateCoolSelectedTab(){
      isCoolSelected = !isCoolSelected;
      notifyListeners();
    }
}
