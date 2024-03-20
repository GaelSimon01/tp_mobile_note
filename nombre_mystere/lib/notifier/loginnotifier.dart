import 'package:flutter/foundation.dart';

class LoginInfo extends ChangeNotifier {
  String _username = '';

  bool get logged => _username.isNotEmpty;

  void login(String username) {
    _username = username;
    notifyListeners();
  }

  void logout() {
    _username = '';
    notifyListeners();
  }
}