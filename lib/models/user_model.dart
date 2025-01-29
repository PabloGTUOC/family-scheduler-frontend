// lib/models/user_model.dart
import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String? _userId;
  String? _userName;

  String? get userId => _userId;
  String? get userName => _userName;

  void setUserData({required String? userId, String? userName}) {
    _userId = userId;
    _userName = userName;
    notifyListeners();
  }

  void clearUserData() {
    _userId = null;
    _userName = null;
    notifyListeners();
  }
}