import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );

  StreamSubscription? _messagesSubscription;

  void sendMessage({required String msg, required String email}) {
    try {
      messages.add({kMessage: msg, kCreatedAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    _messagesSubscription = messages
        .orderBy(kCreatedAt, descending: true)
        .snapshots()
        .listen((event) {
          List<MessageModel> messagesList = [];
          for (var doc in event.docs) {
            messagesList.add(MessageModel.fromJson(doc));
          }
          emit(ChatSuccess(messages: messagesList));
        });
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
