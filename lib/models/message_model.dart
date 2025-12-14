import 'package:scholar_chat/constants.dart';

class MessageModel {
  final String msg;
  final String id;

  MessageModel(this.msg, this.id);

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(jsonData[kMessage], jsonData['id']);
  }
}
