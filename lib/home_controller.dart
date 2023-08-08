import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
    bool isRightDoorLock = true;
    bool isLeftDoorLock = true;
    bool isBonnetLock = true;
    bool isTrunkLock = true;

    int selectedBottomTab = 0;

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
}
