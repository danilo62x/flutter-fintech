/// Clean domain model for a saved payment contact / Pix key.
class Contact {
  const Contact({
    required this.id,
    required this.name,
    required this.initials,
    required this.pixKey,
    required this.bank,
  });

  final String id;
  final String name;
  final String initials;
  final String pixKey;
  final String bank;
}
