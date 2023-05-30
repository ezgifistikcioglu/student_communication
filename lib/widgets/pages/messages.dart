import 'dart:math';

import 'package:flutter/material.dart';
import 'package:student_communication/core/constants/app_constants.dart';
import 'package:student_communication/repository/messages_repository.dart';

class Messages extends StatefulWidget {
  final MessagesRepository messagesRepository;
  const Messages(this.messagesRepository, {super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    widget.messagesRepository.newMessageCount = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: widget.messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageView(widget.messagesRepository.messages[
                    widget.messagesRepository.messages.length - index - 1]);
              },
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(border: Border.all()),
            child: Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: ApplicationConstants.normalPadding,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: const Padding(
                      padding: ApplicationConstants.symmetricPadding,
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        print("send");
                      },
                      child: const Text('SEND')),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MessageView extends StatelessWidget {
  final Message message;

  const MessageView(
    this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.sender == 'Jack'
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Padding(
        padding: ApplicationConstants.symmetricPadding,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              color: Colors.purple.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: ApplicationConstants.normal2xPadding,
            child: Text(message.text),
          ),
        ),
      ),
    );
  }
}
