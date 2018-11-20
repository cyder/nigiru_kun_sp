import 'dart:core';

enum Hand {
  Right,
  Left,
}

class NigirukunCountSensorData {
  int count;
  DateTime time;

  NigirukunCountSensorData(this.count, this.time);

  NigirukunCountSensorData.count(int count){
    this.count = count ?? 0;
    this.time = time ?? DateTime.now();
  }
}

class NigirukunForceSensorData {
  int force;
  DateTime time;
  Hand hand;

  NigirukunForceSensorData(int force, DateTime time, Hand hand){
    this.force = force ?? 0;
    this.time = time ?? DateTime.now();
    this.hand = hand ?? Hand.Right;
  }
}
