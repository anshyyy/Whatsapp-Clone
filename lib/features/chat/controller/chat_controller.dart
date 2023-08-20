import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/core/model/chat_contact.dart';
import 'package:whatsapp/core/model/message.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/repository/chat_repository.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  Stream<List<ChatContact>> chatContacts() {
    final Stream<List<ChatContact>> contacts = chatRepository.getChatContacts();
    print("contact data $contacts");
    return contacts;
  }

  Stream<List<Message>> getChatStream(String recieverUserID) {
    return chatRepository.getChatStream(recieverUserID);
  }

  void sendTextMessage(
      BuildContext context, String text, String recieverUserId) {
    ref.read(userDataAuthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: recieverUserId,
            senderUser: value!));
  }
}
