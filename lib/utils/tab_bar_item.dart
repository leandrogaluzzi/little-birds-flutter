import 'package:flutter/material.dart';
import 'package:little_birds/utils/constants.dart';

class TabBarItem {
  static BottomNavigationBarItem buildItem(String title, String imageName) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(imageName),
        size: kTabBarIconSize,
      ),
      title: Text(title),
    );
  }
}
