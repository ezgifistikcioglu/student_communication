import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_communication/core/constants/app_constants.dart';
import 'package:student_communication/repository/messages_repository.dart';

class Messages extends ConsumerStatefulWidget {
  const Messages({super.key});

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends ConsumerState<Messages> {
  @override
  void initState() {
    resetMessages();
    super.initState();
  }

  Future<void> resetMessages() async {
    await Future.delayed(Duration.zero)
        .then((value) => ref.read(newMessagesNumberProvider.notifier).reset());
  }

  @override
  Widget build(BuildContext context) {
    final messagesRepository = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messagesRepository.messages.length,
              itemBuilder: (context, index) {
                return MessageView(messagesRepository
                    .messages[messagesRepository.messages.length - index - 1]);
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
                        debugPrint("send");
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
