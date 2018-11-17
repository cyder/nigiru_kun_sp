import 'package:scoped_model/scoped_model.dart';

enum BluetoothState {
  Connected,
  Disconnected,
  Searching,
}

class BluetoothViewModel extends Model {
  BluetoothState _currentState = BluetoothState.Disconnected;

  BluetoothState get currentState => _currentState;

  String get message {
    switch (currentState) {
      case BluetoothState.Connected:
        return '接続されました。';
      case BluetoothState.Disconnected:
        return '接続されていません。';
      case BluetoothState.Searching:
        return '検索中';
    }
    return null;
  }

  String get buttonLabel {
    switch (currentState) {
      case BluetoothState.Connected:
        return '切断';
      case BluetoothState.Disconnected:
        return '接続する';
      case BluetoothState.Searching:
        return 'キャンセル';
    }
    return null;
  }

  Function get handleButton {
    switch (currentState) {
      case BluetoothState.Connected:
        return disconnect;
      case BluetoothState.Disconnected:
        return search;
      case BluetoothState.Searching:
        return cancel;
    }
    return null;
  }

  void search() {
    _currentState = BluetoothState.Connected;
    notifyListeners();
  }

  void disconnect() {
    _currentState = BluetoothState.Disconnected;
    notifyListeners();
  }

  void cancel() {
    _currentState = BluetoothState.Disconnected;
    notifyListeners();
  }
}
