import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/contacts/presentation/contact_list.dart';

class WebScreen extends StatelessWidget {
  const WebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //web profile bar
                //web search bar
                Contacts(),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/backgroundImage.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ));
  }
}
