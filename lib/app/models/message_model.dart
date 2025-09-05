class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isMe;
  final bool isRead;

  Message({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isMe,
    this.isRead = false,
  });
}
