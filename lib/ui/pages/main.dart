import 'package:flutter/material.dart';
import 'package:nigiru_kun/viewmodels/main_view_model.dart';
import 'package:nigiru_kun/ui/widget/tabs/home_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/challenge_tab.dart';
import 'package:nigiru_kun/ui/widget/tabs/record_tab.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPage extends StatelessWidget {
  final viewModel = new MainViewModel();

  @override
  Widget build(BuildContext context) {
    return new ScopedModel<MainViewModel>(
        model: viewModel,
        child: new ScopedModelDescendant<MainViewModel>(
            builder: (context, child, model) => Scaffold(
                  appBar: new AppBar(
                    title: (() {
                      switch (model.currentTab) {
                        case Tabs.HomeTab:
                          return new Text('にぎるくん');
                        case Tabs.ChallengeTab:
                          return new Text('Challangeモード');
                        case Tabs.RecordTab:
                          return new Text('Recordモード');
                      }
                    })(),
                  ),
                  body: (() {
                    switch (model.currentTab) {
                      case Tabs.HomeTab:
                        return new HomeTab();
                      case Tabs.ChallengeTab:
                        return new ChallengeTab();
                      case Tabs.RecordTab:
                        return new RecordTab();
                    }
                  })(),
                  bottomNavigationBar: BottomNavigationBar(
                    onTap: _onTabTapped,
                    currentIndex: model.currentTab.index,
                    items: [
                      new BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        title: Text('Home'),
                      ),
                      new BottomNavigationBarItem(
                        icon: Icon(Icons.star),
                        title: Text('Challenge'),
                      ),
                      new BottomNavigationBarItem(
                        icon: Icon(Icons.note),
                        title: Text('Record'),
                      ),
                    ],
                  ),
                )));
  }

  void _onTabTapped(int index) {
    viewModel.selectTab(Tabs.values[index]);
  }
}
