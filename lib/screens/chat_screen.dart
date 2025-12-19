import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message_model.dart';
import 'package:scholar_chat/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:scholar_chat/widgets/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  static String id = 'ChatScreen';

  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, width: 60),
            const Text(
              'Chat',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              builder: (context, state) {
                List<MessageModel> messagesList = [];
                if (state is ChatSuccess) {
                  messagesList = state.messages;
                }

                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBubble(msg: messagesList[index])
                        : ChatBubbleForFreind(msg: messagesList[index]);
                  },
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  BlocProvider.of<ChatCubit>(
                    context,
                  ).sendMessage(msg: value, email: email);
                  controller.clear();
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              decoration: InputDecoration(
                hintText: 'Send message',
                suffixIcon: IconButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(
                        context,
                      ).sendMessage(msg: controller.text, email: email);
                      controller.clear();
                      scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  icon: const Icon(Icons.send, color: kPrimaryColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
