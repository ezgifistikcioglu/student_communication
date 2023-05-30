// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessagesRepository {
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
  int newMessageCount = 4;
}

class Message {
  String text;
  String sender;
  DateTime dateTime;

  Message({
    required this.text,
    required this.sender,
    required this.dateTime,
  });
}
