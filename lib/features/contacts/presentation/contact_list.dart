import 'package:intl/intl.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/core/info.dart';
import 'package:whatsapp/core/model/chat_contact.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';
import 'package:whatsapp/features/chat/presentation/mobile_chat_screen.dart';

class Contacts extends ConsumerStatefulWidget {
  const Contacts({super.key});

  @override
  ConsumerState<Contacts> createState() => _ContactsState();
}

class _ContactsState extends ConsumerState<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 3,
      ),
      child: StreamBuilder<List<ChatContact>>(
          stream: ref.watch(chatControllerProvider).chatContacts(),
          builder: (context, snapshot) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var chatContactData = snapshot.data![index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const MobileChatScreen(name: "", uid: "")));
                        },
                        onLongPress: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: ListTile(
                            title: Text(
                              chatContactData.name,
                              style: const TextStyle(fontSize: 18),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                chatContactData.lastMessage,
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(chatContactData.profilePic),
                            ),
                            trailing: Text(
                              DateFormat.Hm().format(chatContactData.timeSent),
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        color: dividerColor,
                        indent: 85,
                      )
                    ],
                  );
                });
          }),
    );
  }
}
