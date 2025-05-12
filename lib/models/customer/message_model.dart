import 'package:delivery_boy/main.export.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomerChat {
  const CustomerChat({
    required this.messages,
    required this.customer,
    required this.deliveryMan,
  });

  factory CustomerChat.fromMap(Map<String, dynamic> map) {
    return CustomerChat(
      messages:
          PagedItem.fromMap(map['messages'], (x) => MessageModel.fromMap(x)),
      customer: CustomerData.fromMap(map['user']),
      deliveryMan: DeliveryMan.fromMap(map['delivery_man']),
    );
  }

  final CustomerData customer;
  final DeliveryMan deliveryMan;
  final PagedItem<MessageModel> messages;

  Map<String, dynamic> toMap() {
    return {
      'messages': messages.toMap((data) => data.toMap()),
      'user': customer.toMap(),
      'delivery_man': deliveryMan.toMap(),
    };
  }

  CustomerChat copyWith({
    CustomerData? customer,
    DeliveryMan? deliveryMan,
    PagedItem<MessageModel>? messages,
  }) {
    return CustomerChat(
      customer: customer ?? this.customer,
      deliveryMan: deliveryMan ?? this.deliveryMan,
      messages: messages ?? this.messages,
    );
  }
}

class MessageModel {
  const MessageModel({
    required this.id,
    required this.message,
    required this.fileMap,
    required this.isSeen,
    required this.createdAt,
    required this.isMine,
    required this.userData,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map.parseInt('id'),
      message: map['message'],
      fileMap: List<Map>.from(map['files']),
      isSeen: map['is_seen'],
      createdAt: map['created_at'],
      isMine: map['sender_role']['role'] == 'deliveryman',
      userData: map['sender_role']?['user'] ?? {},
    );
  }

  final String createdAt;
  final List<Map> fileMap;
  final int id;
  final bool isMine;
  final bool isSeen;
  final String message;
  final QMap userData;

  String get userName {
    return (userData['username'] ?? userData['name']) ??
        (isMine ? 'customer' : 'seller');
  }

  DateTime get dateTime => DateTime.parse(createdAt);

  String get readableTime => timeago.format(dateTime, locale: 'en');

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
      'created_at': createdAt,
      'sender_role': {
        'role': isMine ? 'deliveryman' : 'customer',
        'user': userData,
      },
    };
  }
}
