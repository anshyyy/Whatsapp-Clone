import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/exports.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }
}
