import 'package:whatsapp/exports.dart';

class BottomChatField extends StatelessWidget {
  const BottomChatField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: mobileChatBoxColor,
                prefixIcon: const SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.gif,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                suffixIcon: SizedBox(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        color: Colors.grey,
                      ),
                      Icon(
                        Icons.attach_file,
                        color: Colors.grey,
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
          child: CircleAvatar(
            radius: 25,
            child: Icon(Icons.send),
            backgroundColor: const Color(0xFF128C7E),
          ),
        )
      ],
    );
  }
}
