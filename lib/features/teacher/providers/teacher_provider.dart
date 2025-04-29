import 'package:flutter/foundation.dart';

class TeacherProvider extends ChangeNotifier {
  // TODO: Add your teacher state (e.g. currentTabIndex, uploadMaterial(), etc.)

  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  void setTabIndex(int idx) {
    _currentTabIndex = idx;
    notifyListeners();
  }
}
