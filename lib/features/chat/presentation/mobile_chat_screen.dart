import 'package:flutter/material.dart';
import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/core/common/widgets/loader.dart';
import 'package:whatsapp/core/model/user_model.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/widget/bottom_chat_field.dart';
import '../widget/chat_list.dart';

class MobileChatScreen extends ConsumerWidget {
  static const String routeName = "/mobile-chat-screen";
  final String name;
  final String uid;
  const MobileChatScreen({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                    ),
                    Text(
                      snapshot.data!.isOnline ? "Online" : "Offline",
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal),
                    ),
                  ],
                );
              }
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserID: uid,
            ),
          ),
          BottomChatField(
            recieverUserId: uid,
          ),
        ],
      ),
    );
  }
}
