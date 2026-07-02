import 'package:flutter/foundation.dart';

import '../../../../data/repositories/contacts_repository.dart';
import '../../../../domain/models/contact.dart';

/// Backs the send-money flow: recipient + amount entered on a numeric keypad.
/// Seeds synchronously so the screenshot renders content.
class SendViewModel extends ChangeNotifier {
  SendViewModel({ContactsRepository? repository})
      : _repository = repository ?? const ContactsRepository() {
    _contacts = _repository.seed();
    _selected = _contacts.first;
    _cents = 25000; // R$ 250,00
  }

  final ContactsRepository _repository;

  List<Contact> _contacts = const <Contact>[];
  Contact? _selected;
  int _cents = 0;

  List<Contact> get contacts => List.unmodifiable(_contacts);
  Contact? get selected => _selected;

  double get amount => _cents / 100.0;
  bool get canContinue => _cents > 0 && _selected != null;

  void selectContact(Contact contact) {
    _selected = contact;
    notifyListeners();
  }

  void inputDigit(String digit) {
    if (digit == ',') return;
    final int d = int.tryParse(digit) ?? 0;
    _cents = (_cents * 10 + d).clamp(0, 99999999);
    notifyListeners();
  }

  void backspace() {
    _cents = _cents ~/ 10;
    notifyListeners();
  }
}
