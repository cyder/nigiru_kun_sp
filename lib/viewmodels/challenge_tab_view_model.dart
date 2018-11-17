import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/utils/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';

enum ChallengeState {
  StandBy,
  Doing,
  Finished,
  Error,
}

class ChallengeTabViewModel extends Model {
  Hand _currentHand = Hand.Right;
  ChallengeData _rightBest =
      ChallengeData(Hand.Right, 120, DateTime(2018, 10, 14));
  ChallengeData _leftBest =
      ChallengeData(Hand.Left, 60, DateTime(2018, 10, 16));
  final formatter = DateFormat('yyyy.MM.dd');
  ChallengeState _currentState = ChallengeState.StandBy;

  Hand get currentHand => _currentHand;

  int get rightBestWeight => _rightBest.weight.floor();

  int get leftBestWeight => _leftBest.weight.floor();

  String get rightBestDate => formatter.format(_rightBest.date);

  String get leftBestDate => formatter.format(_leftBest.date);

  ChallengeState get currentState => _currentState;

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
    if (_currentState == ChallengeState.StandBy) {
      _currentHand = hand;
      notifyListeners();
    }
  }

  void startChallenge() {
    _currentState = ChallengeState.Doing;
    notifyListeners();
  }

  void cancelChallenge() {
    _currentState = ChallengeState.StandBy;
    notifyListeners();
  }
}
