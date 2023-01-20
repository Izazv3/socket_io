class Message {
  final String message;
  final String senderUsername;
  final String type;

  Message({
    required this.message,
    required this.senderUsername,
    required this.type,
  });

  // factory Message.fromJson(Map<String, dynamic> message) {
  //   return Message(
  //     message: message['message'],
  //     senderUsername: message['senderUsername'],
  //     type: message['type']
  //   );
  // }
}
