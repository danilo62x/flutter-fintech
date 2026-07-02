import 'package:flutter/foundation.dart';

/// Backs the receive / QR screen. Holds a Pix key and the encoded payload.
class ReceiveViewModel extends ChangeNotifier {
  ReceiveViewModel() {
    _holder = 'Ana Souza';
    _bank = 'Fintech • Ag 0001';
    _pixKey = 'ana.souza@fintech.com';
    _amount = 250.00;
  }

  String _holder = '';
  String _bank = '';
  String _pixKey = '';
  double _amount = 0;

  String get holder => _holder;
  String get bank => _bank;
  String get pixKey => _pixKey;
  double get amount => _amount;

  /// Deterministic payload used by the drawn QR matrix.
  String get qrData => 'PIX|$_pixKey|$_holder|$_amount';
}
