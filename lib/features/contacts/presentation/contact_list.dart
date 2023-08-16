import 'package:flutter/material.dart';
import 'package:whatsapp/core/constants.dart';
import 'package:whatsapp/core/info.dart';
import 'package:whatsapp/features/chat/presentation/mobile_chat_screen.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 3,
      ),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: info.length,
          itemBuilder: (context, index) {
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
                        info[index]['name'].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Text(
                          info[index]['message'].toString(),
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          info[index]['profilePic'].toString(),
                        ),
                      ),
                      trailing: Text(
                        info[index]['time'].toString(),
                        style:
                            const TextStyle(fontSize: 13, color: Colors.grey),
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
          }),
    );
  }
}
