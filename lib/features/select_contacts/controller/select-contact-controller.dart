import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/select_contacts/repository/select_contact_repo.dart';

final getContactProvider = FutureProvider((ref) async {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});
