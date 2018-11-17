import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';
import 'package:nigiru_kun/utils/color.dart';

class Tab {
  final String title;
  final String svgIconPath;
  final bool isHome;
  final Model viewModel;
  final Color color;
  bool isSelected = false;

  Tab(
    this.title,
    this.svgIconPath,
    this.isHome,
    this.viewModel,
    this.color,
  );
}

class Menu {
  final String title;

  Menu(this.title);
}

class MainViewModel extends Model {
  final tabs = [
    new Tab(
      'HOME',
      'assets/svg/home.svg',
      true,
      new HomeTabViewModel(),
      CustomColors.primaryColor,
    ),
    new Tab(
      'Challenge',
      'assets/svg/challenge.svg',
      false,
      new ChallengeTabViewModel(),
      CustomColors.secondaryColor,
    ),
    new Tab(
      'Record',
      'assets/svg/record.svg',
      false,
      new RecordTabViewModel(),
      CustomColors.tertiaryColor,
    ),
  ];

  final menus = <Menu>[
    Menu('にぎるくんと接続'),
  ];

  int _currentIndex = 0;

  Tab get currentTab => tabs[_currentIndex];

  int get currentIndex => _currentIndex;

  MainViewModel() {
    tabs[_currentIndex].isSelected = true;
  }

  void selectTab(int index) {
    tabs[_currentIndex].isSelected = false;
    _currentIndex = index;
    tabs[index].isSelected = true;
    notifyListeners();
  }

  void selectMenu(Menu menu) {

  }
}
