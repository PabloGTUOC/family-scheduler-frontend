// lib/models/user_model.dart
import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  String? _userId;
  String? _userName;
  int? _familyId;
  String? _familyName;
  int? _originalUnitsDue;
  int? _currentUnitsDue;
  int? _userUnitBalance;
  bool? _isUserNew;

  String? get userId => _userId;
  String? get userName => _userName;
  int? get familyId => _familyId;
  String? get familyName => _familyName;
  int? get originalUnitsDue => _originalUnitsDue;
  int? get currentUnitsDue => _currentUnitsDue;
  int? get userUnitBalance => _userUnitBalance;
  bool? get isUserNew => _isUserNew;

  void setUserData({
    required String userId,
    required String userName,
    required bool isUserNew,
    int? familyId,
    String? familyName,
    int? originalUnitsDue,
    int? currentUnitsDue,
    int? userUnitBalance,
  }) {
    _userId = userId;
    _userName = userName;
    _isUserNew = isUserNew;
    _familyId = familyId;
    _familyName = familyName;
    _originalUnitsDue = originalUnitsDue;
    _currentUnitsDue = currentUnitsDue;
    _userUnitBalance = userUnitBalance;
    notifyListeners();
  }

  void clearUserData() {
    _userId = null;
    _userName = null;
    _isUserNew = null;
    _familyId = null;
    _familyName = null;
    _originalUnitsDue = null;
    _currentUnitsDue = null;
    _userUnitBalance = null;
    notifyListeners();
  }
}