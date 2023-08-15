import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chatList/mobile/mobile_chat_screen.dart';

import '../../../core/model/user_model.dart';

final selectContactRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection("users").get();
      print(userCollection);
      bool isFound = false;
      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        print(userData.phoneNumber);
        String selectNum = selectedContact.phones[0].number.replaceAll(" ", "");
        print(selectNum);
        if (selectNum == userData.phoneNumber) {
          isFound = true;
          Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
            'name': userData.name,
            'uid': userData.uid,
          });
        }
      }
      if (!isFound) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("This contact is not on Whatsapp!"),
          backgroundColor: tabColor,
        ));
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
