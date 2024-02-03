import 'package:flutter/foundation.dart';

class BottomNavProvider with ChangeNotifier {
  int bottomNavIndex = 0;

  void changeBottomNavIndex(int index) {
    if (bottomNavIndex != index) {
      bottomNavIndex = index;
      notifyListeners();
    }
  }
}
