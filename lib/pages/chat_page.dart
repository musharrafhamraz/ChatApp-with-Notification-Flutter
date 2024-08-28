import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat_services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverID;
  const ChatPage({
    super.key,
    required this.recieverEmail,
    required this.recieverID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat & auth service
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  // text field focus

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add lsitener to focus node

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // scroll controller

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  // send message
  void sendMessage() async {
    // if the text field is not empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverID, _messageController.text);

      // clear the text field
      _messageController.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.recieverEmail),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Iconsax.backward1,
            size: 40,
          ),
        ),
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          // all display messages
          Expanded(child: _buildMessageList()),

          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  // build Message List
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.recieverID, senderID),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          // loaading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          // has data

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(context, doc))
                .toList(),
          );
        });
  }

  // build Message list item
  Widget _buildMessageItem(BuildContext context, DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // align message to the right if sender id the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.7, // Max width is 70% of the screen
        ),
        child: Container(
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : Colors.grey.shade500,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            data['message'],
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // build user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        children: [
          // Text field takes the most of space
          Expanded(
            child: CustomTextInput(
              hintText: "Type a Message",
              obscureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Iconsax.send_14,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
