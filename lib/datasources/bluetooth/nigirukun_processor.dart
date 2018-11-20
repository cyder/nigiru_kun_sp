import 'dart:core';

class NigirukunDataProcessor {
  int toCount(List<int> raw) {
    return raw[0] + (raw[1] << 8) + (raw[2] << 16) + (raw[3] << 24);
  }

  List<int> toForce(List<int> raw) {
    return [
      raw[0] + (raw[1] << 8),
      raw[2] + (raw[3] << 8),
      raw[4] + (raw[5] << 8),
      raw[6] + (raw[7] << 8)
    ].toList();
  }

  int toThresh(List<int> raw) {
    return raw[0] + (raw[1] << 8);
  }

  List<int> fromThresh(int t) {
    return [t & ((1 << 8) - 1), t>>8];
  }
}
