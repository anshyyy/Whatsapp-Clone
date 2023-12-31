// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/select_contacts/repository/select_contact_repo.dart';

final getContactProvider = FutureProvider((ref) async {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});

final selectContactProvider = Provider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return SelectContactController(
      ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContactController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(Contact selectedContact, BuildContext context) async {
    selectContactRepository.selectContact(selectedContact, context);
  }
}
