import 'package:uuid/uuid.dart';
import 'package:whatsapp/core/common/enums/message_enum.dart';
import 'package:whatsapp/core/common/repository/firebase_storage.dart';
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

  Stream<List<Message>> getChatStream(String recieverUserID) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserID)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<Message> message = [];
      for (var document in event.docs) {
        message.add(Message.fromMap(document.data()));
      }
      return message;
    });
  }

  Stream<List<ChatContact>> getChatContacts() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContact> contacts = [];
      for (var document in event.docs) {
        print("here is the docs ${document.data()}");
        var chatContact = ChatContact.fromMap(document.data());
        var userData = await firestore
            .collection('users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);
        contacts.add(ChatContact(
            name: user.name,
            timeSent: chatContact.timeSent,
            profilePic: user.profilePic,
            contactId: chatContact.contactId,
            lastMessage: chatContact.lastMessage));
      }
      return contacts;
    });
  }

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

  void sendFileMessage(
      {required BuildContext context,
      required File file,
      required String recieverID,
      required UserModel sendUserData,
      required ProviderRef ref,
      required MessageEnum messageEnum}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = const Uuid().v1();
      String imageUrl = await ref.read(firebaseStorageProvider).storeFileToFirebase(
          "chat/${messageEnum.type}/${sendUserData.uid}/$recieverID/$messageId",
          file);
      UserModel recieverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverID).get();
      recieverUserData = UserModel.fromMap(userDataMap.data()!);

      String contactMsg;
      switch (messageEnum) {
        case MessageEnum.IMAGE:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.VIDEO:
          contactMsg = '📽️ Video';
          break;
        case MessageEnum.AUDIO:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.GIF:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }

      _saveDataToContactsSubCollection(
          sendUserData, recieverUserData, contactMsg, timeSent, recieverID);
      _saveMessageToMessageSubCollection(
          recieverUserID: recieverID,
          text: imageUrl,
          timeSent: timeSent,
          messageId: messageId,
          username: sendUserData.name,
          recieverUsername: recieverUserData.name,
          messageType: messageEnum);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: tabColor,
      ));
    }
  }
}
