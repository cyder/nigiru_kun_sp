import 'dart:core';

class NigirukunCountSensorData {
  int count;
  DateTime time;

  NigirukunCountSensorData(this.count, this.time);

  NigirukunCountSensorData.count(int count){
    this.count = count ?? 0;
    this.time = time ?? DateTime.now();
  }
}

class NigirukunForceensorData {
  List<int> force;
  DateTime time;

  NigirukunSensorData(List<int> force, DateTime time){
    this.force = force;
    this.time = time ?? DateTime.now();
  }
}
