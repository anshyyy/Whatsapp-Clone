import "package:whatsapp/exports.dart";

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = "/select-contacts";

  const SelectContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
      ),
    );
  }
}
