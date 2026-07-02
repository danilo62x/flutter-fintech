import 'package:flutter/foundation.dart';

/// Backs the add-card form and drives the live card preview. Seeds a sample
/// card synchronously so the preview renders content in the screenshot.
class AddCardViewModel extends ChangeNotifier {
  AddCardViewModel() {
    _number = '4321 5678 9012 3456';
    _holder = 'ANA SOUZA';
    _expiry = '09/29';
    _cvv = '123';
  }

  String _number = '';
  String _holder = '';
  String _expiry = '';
  String _cvv = '';

  String get number => _number;
  String get holder => _holder;
  String get expiry => _expiry;
  String get cvv => _cvv;

  String get brand {
    final String digits = _number.replaceAll(RegExp(r'\s'), '');
    if (digits.startsWith('4')) return 'VISA';
    if (digits.startsWith('5')) return 'MASTERCARD';
    if (digits.startsWith('3')) return 'AMEX';
    return 'CARTÃO';
  }

  /// Masked display for the preview, keeping the last four digits.
  String get previewNumber {
    if (_number.isEmpty) return '•••• •••• •••• ••••';
    return _number;
  }

  bool get isValid =>
      _number.replaceAll(RegExp(r'\s'), '').length >= 16 &&
      _holder.isNotEmpty &&
      _expiry.length >= 5 &&
      _cvv.length >= 3;

  void setNumber(String value) {
    _number = value;
    notifyListeners();
  }

  void setHolder(String value) {
    _holder = value.toUpperCase();
    notifyListeners();
  }

  void setExpiry(String value) {
    _expiry = value;
    notifyListeners();
  }

  void setCvv(String value) {
    _cvv = value;
    notifyListeners();
  }
}
