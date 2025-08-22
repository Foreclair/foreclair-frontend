import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  final PageController controller = PageController();
  int index = 0;

  void setIndex(int i) {
    index = i;
    controller.animateToPage(i, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    notifyListeners();
  }

  void updateIndex(int i) {
    index = i;
    notifyListeners();
  }
}
