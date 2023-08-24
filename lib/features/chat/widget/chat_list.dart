import 'package:flutter/scheduler.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/core/model/message.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/widget/my_message.dart';
import 'package:whatsapp/features/chat/widget/sender_message.dart';

import '../../../core/info.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserID;
  const ChatList({Key? key, required this.recieverUserID}) : super(key: key);

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .read(chatControllerProvider)
            .getChatStream(widget.recieverUserID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.data);
            return ErrorScreen(error: snapshot.error.toString());
          }
          SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            controller: messageController,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final messageData = snapshot.data![index];
              final timeSent = messageData.timeSent;
              //print("time is here boi $timeSent");
              if (messages[index]['isMe'] ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  message: messageData.text,
                  date: '${timeSent.hour}:${timeSent.minute}',
                  type: messageData.type,
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
