import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';

class Tab {
  final String title;
  final IconData icon;
  final bool isHome;
  final Model viewModel;

  Tab(this.title, this.icon, this.isHome, this.viewModel);
}

class MainViewModel extends Model {
  final tabs = [
    new Tab('HOME', Icons.home, true, new HomeTabViewModel()),
    new Tab('Challenge', Icons.star, false, new ChallengeTabViewModel()), //TODO: アイコンの差し替え
    new Tab('Record', Icons.note, false, new RecordTabViewModel()), //TODO: アイコンの差し替え
  ];

  int _currentIndex = 0;

  Tab get currentTab => tabs[_currentIndex];

  int get currentIndex => _currentIndex;

  void selectTab(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
