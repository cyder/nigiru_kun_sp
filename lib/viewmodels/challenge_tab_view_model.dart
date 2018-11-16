import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/utils/hand.dart';

class ChallengeTabViewModel extends Model {
  Hand _currentHand = Hand.Right;

  Hand get currentHand => _currentHand;

  String get currentHandName {
    switch (_currentHand) {
      case Hand.Right:
        return '右手';
      case Hand.Left:
        return '左手';
    }
    return null;
  }

  void handleCurrentHand(Hand hand) {
    _currentHand = hand;
    notifyListeners();
  }
}
