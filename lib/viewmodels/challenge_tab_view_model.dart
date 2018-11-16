import 'package:scoped_model/scoped_model.dart';
import 'package:nigiru_kun/utils/hand.dart';

class ChallengeTabViewModel extends Model {
  Hand currentHand = Hand.Right;

  void handleCurrentHand(Hand hand) {
    currentHand = hand;
    notifyListeners();
  }
}
