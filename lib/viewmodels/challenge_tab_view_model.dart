import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/usecases/challenge_use_case.dart';
import 'package:nigiru_kun/entities/hand.dart';
import 'package:nigiru_kun/entities/challenge_data.dart';

enum ChallengeState {
  StandBy,
  Doing,
  Finished,
  Error,
}

enum DialogType {
  Finished,
  Error,
  Close,
}

class ChallengeTabViewModel extends Model {
  final int maxForce = 100;
  final ChallengeUseCase useCase = ChallengeUseCase();
  Hand _currentHand = Hand.Right;
  ChallengeData _rightBest;
  ChallengeData _leftBest;
  PublishSubject<DialogType> _currentDialog = PublishSubject<DialogType>();
  ChallengeState _currentState = ChallengeState.StandBy;
  double _currentForce = 0;
  double _resultForce;

  Hand get currentHand => _currentHand;

  ChallengeData get rightBest => _rightBest;

  ChallengeData get leftBest => _leftBest;

  int get currentForce => _currentForce.toInt();

  int get resultForce => _resultForce?.toInt() ?? 0;

  double get currentForceRatio => _currentForce / maxForce;

  ChallengeState get currentState => _currentState;

  PublishSubject<DialogType> get currentDialog => _currentDialog;

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
    useCase.observeChallengeResult.listen((result) {
      _resultForce = result;
      _currentDialog.add(DialogType.Finished);
      notifyListeners();
    });
    notifyListeners();
    useCase.startChallenge();
  }

  void saveChallenge() {
    _currentState = ChallengeState.StandBy;
    useCase.saveData(_resultForce.toInt(), _currentHand);
    useCase.stopChallenge();
    _updateBestForce();
    notifyListeners();
  }

  void cancelChallenge() {
    _currentState = ChallengeState.StandBy;
    notifyListeners();
    useCase.stopChallenge();
  }

  void init() {
    _currentDialog = PublishSubject<DialogType>();
    useCase.observeForceWeight.listen((weight) {
      _currentForce = weight < maxForce ? weight : maxForce;
      notifyListeners();
    });
    _updateBestForce();
  }

  void dispose() {
    _currentDialog.close();
    useCase.stopChallenge();
  }

  void _updateBestForce() {
    useCase.leftBestForce.listen((data) {
      _leftBest = data;
      notifyListeners();
    });
    useCase.rightBestForce.listen((data) {
      _rightBest = data;
      notifyListeners();
    });
  }
}
