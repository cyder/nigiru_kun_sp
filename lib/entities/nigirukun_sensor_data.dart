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

class NigirukunForceSensorData {
  List<int> force;
  DateTime time;

  NigirukunForceSensorData(this.force, this.time);

  NigirukunForceSensorData.force(List<int> force){
    this.force = force;
    this.time = time ?? DateTime.now();
  }
}
