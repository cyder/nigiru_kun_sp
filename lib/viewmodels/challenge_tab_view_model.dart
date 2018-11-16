import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/utils/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';

class ChallengeTabViewModel extends Model {
  Hand _currentHand = Hand.Right;
  ChallengeData _rightBest =
      ChallengeData(Hand.Right, 120, DateTime(2018, 10, 14));
  ChallengeData _leftBest =
      ChallengeData(Hand.Left, 60, DateTime(2018, 10, 16));
  final formatter = DateFormat('yyyy.MM.dd');

  Hand get currentHand => _currentHand;

  int get rightBestWeight => _rightBest.weight.floor();

  int get leftBestWeight => _leftBest.weight.floor();

  String get rightBestDate => formatter.format(_rightBest.date);

  String get leftBestDate => formatter.format(_leftBest.date);

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
