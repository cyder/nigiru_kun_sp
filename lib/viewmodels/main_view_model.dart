import 'package:scoped_model/scoped_model.dart';

enum Tabs {
  HomeTab,
  ChallengeTab,
  RecordTab,
}

class MainViewModel extends Model {
  Tabs _currentTab = Tabs.HomeTab;

  Tabs get currentTab => _currentTab;

  void selectTab(Tabs tab) {
    _currentTab = tab;
    notifyListeners();
  }
}
