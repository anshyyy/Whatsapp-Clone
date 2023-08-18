import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chat/controller/chat_controller.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;
  const BottomChatField({super.key, required this.recieverUserId});

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  TextEditingController message = TextEditingController();

  bool isShowSendButton = false;

  void sendTextMessage() {
    if (isShowSendButton) {
      ref
          .read(chatControllerProvider)
          .sendTextMessage(context, message.text.trim(), widget.recieverUserId);

      setState(() {
        message.clear();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    message.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextFormField(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    isShowSendButton = true;
                  });
                }
                if (value.isEmpty) {
                  setState(() {
                    isShowSendButton = false;
                  });
                }
              },
              controller: message,
              decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                prefixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.gif,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                hintText: 'Type a message!',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 2, left: 2),
          child: GestureDetector(
            onTap: sendTextMessage,
            child: CircleAvatar(
              radius: 25,
              child: !isShowSendButton ? Icon(Icons.mic) : Icon(Icons.send),
              backgroundColor: const Color(0xFF128C7E),
            ),
          ),
        )
      ],
    );
  }
}
