import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/contacts/presentation/contact_list.dart';
import '../../features/web profile/web_profile.dart';
import '../../features/web search bar/web_search_bar.dart';

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
                WebProfileBar(),
                //web search bar
                WebSearchBar(),
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
