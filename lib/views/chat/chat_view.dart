import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:ecomercy_app_flutter/configs/constants/consts.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final _openAI = OpenAI.instance.build(
      token: OPEN_AI_KEY,
      baseOption: HttpSetup(receiveTimeout: Duration(seconds: 5)),
      enableLog: true,
  );

  final ChatUser _currentUser =
  ChatUser(id: "1", firstName: "Đào", lastName: "Dũng");

  final ChatUser _chatGpt =
  ChatUser(id: "1", firstName: "Chat", lastName: "Gpt");

  List<ChatMessage> _messages = <ChatMessage>[];

  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: PrimaryText(
          "Chat",
          fontSize: 18,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white,)),
      ),
      body: DashChat(
        typingUsers: _typingUsers,
          messageOptions: MessageOptions(
              currentUserContainerColor: Theme
                  .of(context)
                  .colorScheme
                  .primary,
              containerColor: Colors.yellow,
              textColor: Colors.red),
          currentUser: _currentUser,
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_chatGpt);
    });
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();

    final request = ChatCompleteText(
        model: GptTurboChatModel(),
        messages: _messagesHistory,
        maxToken: 200
    );

    final response = await _openAI.onChatCompletion(request: request);

    for(var element in response!.choices){
      if(element.message != null) {
        setState(() {
          _messages.insert(0, ChatMessage(user: _chatGpt, createdAt: DateTime.now(), text: element.message!.content),);
        });
      }
    }
    setState(() {
      _typingUsers.remove(_chatGpt);
    });
  }
}
