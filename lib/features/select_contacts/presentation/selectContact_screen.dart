import "package:flutter_contacts/flutter_contacts.dart";
import "package:whatsapp/core/common/widgets/loader.dart";
import "package:whatsapp/exports.dart";
import "package:whatsapp/features/select_contacts/controller/select-contact-controller.dart";

class SelectContactsScreen extends ConsumerWidget {
  static const String routeName = "/select-contacts";

  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref.read(selectContactProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contacts"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: ref.watch(getContactProvider).when(
          data: (contactsList) => ListView.builder(
              itemCount: contactsList.length,
              itemBuilder: (context, index) {
                final contact = contactsList[index];
                return InkWell(
                  onTap: () => selectContact(ref, contact, context),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(fontSize: 18),
                      ),
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!),
                              radius: 30,
                            ),
                    ),
                  ),
                );
              }),
          error: (err, trace) {
            return ErrorScreen(error: err.toString());
          },
          loading: (() => const Loader())),
    );
  }
}
