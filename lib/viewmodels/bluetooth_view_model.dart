import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/rxdart.dart';

enum BluetoothState {
  Connected,
  Disconnected,
  Searching,
  Error,
}

enum DialogType {
  Select,
  Error,
  Close,
}

// TODO: 仮実装
class Device {
  final String name;
  final String id;
  Device(this.name, this.id);
}

class BluetoothViewModel extends Model {
  BluetoothState _currentState = BluetoothState.Disconnected;

  BluetoothState get currentState => _currentState;

  PublishSubject<DialogType> _currentDialog = PublishSubject<DialogType>();

  final List<Device> deviceList  = [
    Device('にぎるくん', '1234567890'),
    Device('にぎるくん', '2345678901'),
  ];

  String get message {
    switch (currentState) {
      case BluetoothState.Connected:
        return '接続されました。';
      case BluetoothState.Disconnected:
      case BluetoothState.Error:
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
      case BluetoothState.Error:
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
      case BluetoothState.Error:
        return cancel;
    }
    return null;
  }

  PublishSubject<DialogType> get currentDialog => _currentDialog;

  void search() {
    _currentDialog.add(DialogType.Select); //TODO: 本来はサーチが終わったタイミングで出す。
    _currentState = BluetoothState.Searching;
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

  void selectDevice(Device device) {
    _currentState = BluetoothState.Connected;
    notifyListeners();
  }

  void init() {
    _currentDialog = PublishSubject<DialogType>();
  }

  void dispose() {
    _currentDialog.close();
  }
}
