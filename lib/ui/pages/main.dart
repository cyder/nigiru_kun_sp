import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:nigiru_kun/viewmodels/main_view_model.dart';
import 'package:nigiru_kun/ui/widget/tabs/home_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/record_tab.dart';
import 'package:nigiru_kun/viewmodels/home_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/challenge_tab_view_model.dart';
import 'package:nigiru_kun/viewmodels/record_tab_view_mode.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final viewModel = new MainViewModel();
  Widget homeTabWidget;
  Widget challengeTabWidget;
  Widget recordTabWidget;

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<MainViewModel>(
      model: viewModel,
      child: new ScopedModelDescendant<MainViewModel>(
          builder: (context, child, model) => GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Scaffold(
                appBar: new AppBar(
                  title: _getTitleWidget(
                      model.currentTab.title, model.currentTab.isHome),
                  actions: <Widget>[
                    PopupMenuButton<Menu>(
                      onSelected: model.selectMenu,
                      itemBuilder: (BuildContext context) {
                        return model.menus
                            .map((menu) => PopupMenuItem<Menu>(
                                  value: menu,
                                  child: Text(menu.title),
                                ))
                            .toList();
                      },
                    )
                  ],
                ),
                body: _getTabWidget(model.currentTab.viewModel),
                bottomNavigationBar: BottomNavigationBar(
                  onTap: model.selectTab,
                  currentIndex: model.currentIndex,
                  items: model.tabs
                      .map((tab) => new BottomNavigationBarItem(
                            icon: Container(
                              margin: EdgeInsets.only(top: 1.0, bottom: 3.0),
                              width: 22,
                              height: 22,
                              child: SvgPicture.asset(
                                tab.svgIconPath,
                                color:
                                    tab.isSelected ? tab.color : Colors.white54,
                              ),
                            ),
                            title: Text(
                              tab.title,
                              style: TextStyle(
                                  color: tab.isSelected
                                      ? tab.color
                                      : Colors.white54),
                            ),
                          ))
                      .toList(),
                ),
              ))),
    );
  }

  // タブの中身のwidgetを返す
  Widget _getTabWidget(Model viewModel) {
    if (viewModel is HomeTabViewModel) {
      return homeTabWidget ?? (homeTabWidget = new HomeTab(viewModel));
    }
    if (viewModel is ChallengeTabViewModel) {
      return challengeTabWidget ??
          (challengeTabWidget = new ChallengeTab(viewModel));
    }
    if (viewModel is RecordTabViewModel) {
      return recordTabWidget ?? (recordTabWidget = new RecordTab(viewModel));
    }
    return null;
  }

  // タイトルウィジェットを返す
  Widget _getTitleWidget(String title, bool isHome) {
    if (isHome) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: SvgPicture.asset(
          'assets/svg/logo.svg',
          alignment: Alignment.centerLeft,
          color: Colors.white,
        ),
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
