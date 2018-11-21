import 'dart:core';

class NigirukunDataProcessor {
  int toCount(List<int> raw) {
    return raw[0] + (raw[1] << 8) + (raw[2] << 16) + (raw[3] << 24);
  }

  List<double> toForce(List<int> raw) {
    return [
      (raw[0] + (raw[1] << 8)) / 10,
      (raw[2] + (raw[3] << 8)) / 10,
      (raw[4] + (raw[5] << 8)) / 10,
      (raw[6] + (raw[7] << 8)) / 10,
    ].toList();
  }

  double toThresh(List<int> raw) {
    return (raw[0] + (raw[1] << 8)) / 10;
  }

  List<int> fromThresh(double t) {
    final x = (t * 10).toInt();
    return [x & ((1 << 8) - 1), x >> 8];
  }
}
