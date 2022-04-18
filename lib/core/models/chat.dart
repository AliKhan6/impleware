import 'package:flutter/foundation.dart';
import '../enums/message_type.dart';

class Chat {
  String? id;
  String? pharmacistId;
  String? userId;
  String? userName;
  String? pharmacistName;
  String? userUrl;
  String? pharmacistUrl;
  String? createdAt;
  String? message;
  String? formattedTime;
  MessageType? type;

  Chat({
    this.id,
    this.pharmacistId,
    this.userId,
    this.createdAt,
    this.userName,
    this.userUrl,
    this.pharmacistName,
    this.pharmacistUrl,
    this.message,
    this.formattedTime,
    this.type = MessageType.text,
  });

  Chat.fromJson(json) {
    pharmacistId = json['userid'];
    userId = json['PharmacistId'];
    createdAt = json['createdAt'];
    message = json['message'];
    formattedTime = json['formattedTime'];
    userName = json['userName'];
    pharmacistName = json['pharmacistName'];
    userUrl = json['userUrl'];
    pharmacistUrl = json['pharmacistUrl'];
    type = _getMessageType(json['type']);
  }

  toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userid'] = pharmacistId;
    data['PharmacistId'] = userId;
    data['createdAt'] = createdAt;
    data['type'] = describeEnum(type ?? MessageType.text);
    data['message'] = message;
    data['userName'] = userName;
    data['pharmacistName'] = pharmacistName;
    data['userUrl'] = userUrl;
    data['pharmacistUrl'] = pharmacistUrl;
    data['formattedTime'] = formattedTime;
    return data;
  }

  _getMessageType(type) {
    if (type == 'text') {
      return MessageType.text;
    } else if (type == 'voice') {
      return MessageType.voice;
    } else if (type == 'image') {
      return MessageType.image;
    } else {
      return MessageType.location;
    }
  }
}
