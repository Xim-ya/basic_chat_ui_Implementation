import 'package:basic_chat_ui_implementation/chat_message_type.dart';

class Chat {
  final String message;
  final ChatMessageType type;
  final DateTime time;

  Chat({required this.message, required this.type, required this.time});

  factory Chat.sent({required message}) =>
      Chat(message: message, type: ChatMessageType.sent, time: DateTime.now());

  static List<Chat> generate() {
    return [
      Chat(
        message: "Hello!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
      Chat(
        message: "Nice to meet you!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 14)),
      ),
      Chat(
        message: "The weather is nice today.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 13)),
      ),
      Chat(
        message: "Yes, it's a great day to go out.",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      Chat(
        message: "Have a nice day!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 11)),
      ),
      Chat(
        message: "What are your plans for the weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      Chat(
        message: "I'm planning to go to the beach.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 9)),
      ),
      Chat(
        message: "That sounds fun!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      Chat(
        message: "Do you want to come with me?",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 7)),
      ),
      Chat(
        message: "Sure, I'd love to!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 6)),
      ),
      Chat(
        message: "What time should we meet?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      Chat(
        message: "Let's meet at 10am.",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      Chat(
        message: "Sounds good to me!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
      Chat(
        message: "See you then!",
        type: ChatMessageType.sent,
        time: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      Chat(
        message: "Bye!",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      Chat(
        message: "How was your weekend?",
        type: ChatMessageType.received,
        time: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
      Chat(
        message: "It was great! The beach was awesome.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      Chat(
        message: "I'm glad to hear that!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
      Chat(
        message: "We should do that again sometime.",
        type: ChatMessageType.sent,
        time: DateTime.now(),
      ),
      Chat(
        message: "Definitely!",
        type: ChatMessageType.received,
        time: DateTime.now(),
      ),
    ];
  }


// static List<Chat> generate() {
  //   return [
  //     Chat(
  //       message: "Hello!",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 5)),
  //     ),
  //     Chat(
  //       message: "Nice to meet you!",
  //       type: ChatMessageType.received,
  //       time: DateTime.now().subtract(const Duration(minutes: 4)),
  //     ),
  //     Chat(
  //       message: "The weather is nice today.",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 3)),
  //     ),
  //     Chat(
  //       message: "Yes, it's a great day to go out.",
  //       type: ChatMessageType.received,
  //       time: DateTime.now().subtract(const Duration(minutes: 2)),
  //     ),
  //     Chat(
  //       message: "Have a nice day!",
  //       type: ChatMessageType.sent,
  //       time: DateTime.now().subtract(const Duration(minutes: 1)),
  //     ),
  //   ];
  // }
}
