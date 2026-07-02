import '../../domain/models/contact.dart';

/// Provides saved contacts / Pix keys for the send flow.
class ContactsRepository {
  const ContactsRepository();

  /// Synchronous seed so the first frame already has content.
  List<Contact> seed() {
    return const <Contact>[
      Contact(
        id: 'p1',
        name: 'Bruno Almeida',
        initials: 'BA',
        pixKey: 'bruno@email.com',
        bank: 'Banco Digital',
      ),
      Contact(
        id: 'p2',
        name: 'Carla Nunes',
        initials: 'CN',
        pixKey: '(11) 98765-4321',
        bank: 'Nubank',
      ),
      Contact(
        id: 'p3',
        name: 'Diego Ramos',
        initials: 'DR',
        pixKey: '123.456.789-00',
        bank: 'Itaú',
      ),
      Contact(
        id: 'p4',
        name: 'Elaine Costa',
        initials: 'EC',
        pixKey: 'elaine.costa@pix.com',
        bank: 'Inter',
      ),
    ];
  }
}
