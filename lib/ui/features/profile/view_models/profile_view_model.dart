import 'package:flutter/foundation.dart';

/// Holds profile + settings state (toggles for security, notifications, theme).
class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel();

  final String name = 'Ana Souza';
  final String email = 'ana.souza@fintech.com';
  final String initials = 'AS';
  final String memberSince = 'Cliente desde 2021';
  final String plan = 'Plano Black';

  bool _biometrics = true;
  bool _notifications = true;
  bool _darkMode = false;
  bool _emailAlerts = false;

  bool get biometrics => _biometrics;
  bool get notifications => _notifications;
  bool get darkMode => _darkMode;
  bool get emailAlerts => _emailAlerts;

  void setBiometrics(bool value) {
    _biometrics = value;
    notifyListeners();
  }

  void setNotifications(bool value) {
    _notifications = value;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void setEmailAlerts(bool value) {
    _emailAlerts = value;
    notifyListeners();
  }
}
