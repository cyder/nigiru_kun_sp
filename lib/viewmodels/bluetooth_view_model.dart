import 'package:scoped_model/scoped_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:nigiru_kun/usecases/bluetooth_use_case.dart';

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

class BluetoothViewModel extends Model {
  BluetoothUseCase useCase = BluetoothUseCase();
  BluetoothState _currentState = BluetoothState.Disconnected;
  List<Peripheral> deviceList = [];

  BluetoothState get currentState => _currentState;

  PublishSubject<DialogType> _currentDialog = PublishSubject<DialogType>();

  BluetoothViewModel() {
    if(useCase.isConnected) {
      _currentState = BluetoothState.Connected;
    }
  }

  String get message {
    switch (currentState) {
      case BluetoothState.Connected:
        Peripheral connected = useCase.connectedPeripheral;
        if(connected != null) {
          return '接続中：${connected.name} (${connected.id})';
        }
        _currentState = BluetoothState.Error;
        _currentDialog.add(DialogType.Error);
        return null;
      case BluetoothState.Disconnected:
      case BluetoothState.Error:
        return '接続されていません。';
      case BluetoothState.Searching:
        return '検索中…';
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
    deviceList = [];
    useCase.scan().listen((data) {
      if (deviceList.isEmpty) {
        _currentDialog.add(DialogType.Select);
      }
      deviceList.add(data);
      notifyListeners();
    });

    _currentState = BluetoothState.Searching;
    notifyListeners();
  }

  void disconnect() {
    _currentState = BluetoothState.Disconnected;
    useCase.disconnect();
    notifyListeners();
  }

  void cancel() {
    _currentState = BluetoothState.Disconnected;
    deviceList.clear();
    notifyListeners();
  }

  void selectDevice(Peripheral device) {
    useCase.connect(device.id);
    _currentState = BluetoothState.Connected;
    deviceList.clear();
    notifyListeners();
  }

  void init() {
    _currentDialog = PublishSubject<DialogType>();
  }

  void dispose() {
    _currentDialog.close();
  }
}
