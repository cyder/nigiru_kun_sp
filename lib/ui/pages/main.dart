import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/main_view_model.dart';
import 'package:nigiru_kun/ui/widget/tabs/home_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/record_tab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';

class MainPage extends StatelessWidget {
  final viewModel = new MainViewModel();
  final Widget homeTabWidget = new HomeTab();
  final Widget challengeTabWidget = new ChallengeTab();
  final Widget recordTabWidget = new RecordTab();

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<MainViewModel>(
        model: viewModel,
        child: new ScopedModelDescendant<MainViewModel>(
            builder: (context, child, model) => Scaffold(
                  appBar: new AppBar(
                    title: _getTitleWidget(model.currentTab.title, model.currentTab.isHome),
                  ),
                  body: _getTabWidget(model.currentTab.viewModel),
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: model.selectTab,
                    currentIndex: model.currentIndex,
                    items: model.tabs.map((tab) => new BottomNavigationBarItem(
                          icon: Icon(tab.icon),
                          title: Text(tab.title),
                        )).toList(),
                  ),
                )));
  }

  // タブの中身のwidgetを返す
  Widget _getTabWidget(Model viewModel) {
    if (viewModel is HomeTabViewModel) {
      return homeTabWidget;
    }
    if (viewModel is ChallengeTabViewModel) {
      return challengeTabWidget;
    }
    if (viewModel is RecordTabViewModel) {
      return recordTabWidget;
    }
    return null;
  }

  // タイトルウィジェットを返す
  Widget _getTitleWidget(String title, bool isHome) {
    if(isHome) {
      return Text('にぎるくん'); //TODO: 画像に差し替え
    }
    return Text(title);
  }
}
