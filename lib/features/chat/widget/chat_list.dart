import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/core/model/message.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chatList/widgets/my_message.dart';
import 'package:whatsapp/features/chatList/widgets/sender_message.dart';

import '../../../core/info.dart';

class ChatList extends ConsumerWidget {
  final String recieverUserID;
  const ChatList({Key? key, required this.recieverUserID}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).getChatStream(recieverUserID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.data);
            return ErrorScreen(error: snapshot.error.toString());
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              final timeSent = messageData.timeSent;
              print("time is here boi $timeSent");
              if (messages[index]['isMe'] ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: '${timeSent.hour}:${timeSent.minute}',
                );
              }
              return SenderMessageCard(
                message: messageData.text,
                date: '${timeSent.hour}:${timeSent.minute}',
              );
            },
          );
        });
  }
}
