import 'package:delivery_boy/models/_misc/pagination.dart';
import 'package:delivery_boy/models/delivery_man/chat/delivery_man.dart';
import 'package:delivery_boy/models/delivery_man/chat/delivery_message.dart';
import 'package:delivery_boy/models/delivery_man/chat/loggedin.dart';

class DeliveryManChat {
  DeliveryManChat({
    required this.deliveryMan,
    required this.loggedInDeliveryman,
    required this.messages,
  });

  factory DeliveryManChat.fromMap(Map<String, dynamic> map) {
    return DeliveryManChat(
      deliveryMan: DeliveryManModel.fromMap(map['deliveryman']),
      loggedInDeliveryman:
          LoggedDeliveryman.fromMap(map['logged_in_deliveryman']),
      messages: PagedItem<DeliveryMessage>.fromMap(
        map['messages'],
        (x) => DeliveryMessage.fromMap(x),
      ),
    );
  }

  final DeliveryManModel deliveryMan;
  final LoggedDeliveryman loggedInDeliveryman;
  final PagedItem<DeliveryMessage> messages;

  Map<String, dynamic> toMap() {
    return {
      'deliveryman': deliveryMan.toMap(),
      'logged_in_deliveryman': loggedInDeliveryman.toMap(),
      'messages': messages.toMap((x) => x.toMap()),
    };
  }

  DeliveryManChat copyWith({
    DeliveryManModel? deliveryMan,
    LoggedDeliveryman? loggedInDeliveryman,
    PagedItem<DeliveryMessage>? messages,
  }) {
    return DeliveryManChat(
      deliveryMan: deliveryMan ?? this.deliveryMan,
      loggedInDeliveryman: loggedInDeliveryman ?? this.loggedInDeliveryman,
      messages: messages ?? this.messages,
    );
  }
}
