import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/repository/chat_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });
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
