import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../product/models/message_model.dart';

class MessagesRepository extends ChangeNotifier {
  final List<Message> messages = [
    Message(
        text: 'Hello',
        sender: 'Jack',
        dateTime: DateTime.now().subtract(const Duration(minutes: 3))),
    Message(
        text: 'Are u here?',
        sender: 'Jack',
        dateTime: DateTime.now().subtract(const Duration(minutes: 2))),
    Message(
        text: 'Yeah, I am here?',
        sender: 'Jane',
        dateTime: DateTime.now().subtract(const Duration(minutes: 1))),
    Message(text: 'Are u ok?', sender: 'Jane', dateTime: DateTime.now()),
  ];
}

final messagesProvider = ChangeNotifierProvider((ref) => MessagesRepository());

final newMessagesNumberProvider =
    StateNotifierProvider<NewMessageNumber, int>((ref) => NewMessageNumber(4));

class NewMessageNumber extends StateNotifier<int> {
  NewMessageNumber(super.state);

  void reset() {
    state = 0;
  }
}
