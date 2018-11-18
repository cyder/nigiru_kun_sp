import 'dart:core';

class NigirukunCountSensorData {
  int count;
  DateTime time;

  NigirukunSensorData(int count, DateTime time){
    this.count = count;
    this.time = time;
  }

  NigirukunCountSensorData.count(int count){
    this.count = count;
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
