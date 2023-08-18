import 'dart:convert';

class ChatContact {
  final String name;
  final DateTime timeSent;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  ChatContact({
    required this.name,
    required this.timeSent,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'timeSent': timeSent,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] as String,
      timeSent: map['timeSent'] as DateTime,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      lastMessage: map['lastMessage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatContact.fromJson(String source) =>
      ChatContact.fromMap(json.decode(source) as Map<String, dynamic>);
}
