import 'package:flutter/cupertino.dart';
import 'package:forfor/utils/utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class ChatUsers {
  final String idUser;

  String name;
  String messageText;
  String urlAvatar;
  DateTime lastMessageTime;

  ChatUsers({
    required this.name,
    required this.idUser,
    required this.messageText,
    required this.urlAvatar,
    required this.lastMessageTime,
  });

  ChatUsers copyWith({
    String? idUser,
    String? name,
    String? urlAvatar,
    DateTime? lastMessageTime,
  }) =>
      ChatUsers(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
        lastMessageTime: lastMessageTime ?? this.lastMessageTime,
        messageText: '',
      );

  static ChatUsers fromJson(Map<String, dynamic> json) => ChatUsers(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        messageText: json['messageText'],
        lastMessageTime: Utils.toDateTime(json['lastMessageTime']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        'messageText': messageText,
        'lastMessageTime': Utils.fromDateTimeToJson(lastMessageTime),
      };
}
