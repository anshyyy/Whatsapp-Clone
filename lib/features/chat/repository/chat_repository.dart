import 'package:uuid/uuid.dart';
import 'package:whatsapp/core/common/enums/message_enum.dart';
import 'package:whatsapp/core/model/chat_contact.dart';
import 'package:whatsapp/core/model/message.dart';
import 'package:whatsapp/exports.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void _saveDataToContactsSubCollection(
      UserModel senderUserData,
      UserModel recieverUserData,
      String text,
      DateTime timeSent,
      String recieverUserId) async {
    var recieverChatContact = ChatContact(
        name: senderUserData.name,
        timeSent: timeSent,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: text);
    await firestore
        .collection('users')
        .doc(recieverUserId)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());
    var senderChatContact = ChatContact(
        name: recieverUserData.name,
        timeSent: timeSent,
        profilePic: recieverUserData.profilePic,
        contactId: recieverUserData.uid,
        lastMessage: text);
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(recieverUserId)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessageSubCollection(
      {required String recieverUserID,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String username,
      required String recieverUsername,
      required MessageEnum messageType}) async {
    final message = Message(
        senderId: auth.currentUser!.uid,
        recieverId: recieverUserID,
        text: text,
        type: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserID)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(recieverUserID)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String recieverUserId,
      required UserModel senderUser}) async {
    try {
      var timeSent = DateTime.now();
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection("users").doc(recieverUserId).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);
      var messageId = const Uuid().v1();
      _saveDataToContactsSubCollection(
          senderUser, recieverUserData, text, timeSent, recieverUserId);
      _saveMessageToMessageSubCollection(
        recieverUserID: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageType: MessageEnum.TEXT,
        messageId: messageId,
        username: senderUser.name,
        recieverUsername: recieverUserData.name,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: tabColor,
      ));
    }
  }
}
