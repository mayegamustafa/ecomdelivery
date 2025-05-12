import 'package:delivery_boy/main.export.dart';

class DeliveryMessage {
  const DeliveryMessage({
    required this.id,
    required this.message,
    required this.fileMap,
    required this.isSeen,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory DeliveryMessage.fromMap(Map<String, dynamic> map) {
    return DeliveryMessage(
      id: map.parseInt('id'),
      message: map['message'] ?? '',
      fileMap: List<Map>.from(map['files'])
          .map((e) => Map<String, String>.from(e))
          .toList(),
      isSeen: map['is_seen'] ?? false,
      senderId: map.parseInt('sender_id'),
      receiverId: map.parseInt('receiver_id'),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  final DateTime createdAt;
  final List<Map<String, String>> fileMap;
  final int id;
  final bool isSeen;
  final String message;
  final int receiverId;
  final int senderId;

  List<({String name, String url})> get files {
    final fileJoin = <String, String>{};

    for (final file in fileMap) {
      fileJoin.addAll(file.cast<String, String>());
    }

    return fileJoin.entries.map((e) => (name: e.key, url: e.value)).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'files': fileMap,
      'is_seen': isSeen,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  bool isMe(int id) => senderId == id;
}
