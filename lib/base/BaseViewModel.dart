import 'package:flutter/cupertino.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool status) {
    _busy = status;

    notifyListeners();
  }
}