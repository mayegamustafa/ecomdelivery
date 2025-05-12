import 'package:event_bus/event_bus.dart';

final eventBus = EventBus();

class UnAuthEvent {
  const UnAuthEvent(this.msg);

  final String msg;
}

class ServerEvent {
  const ServerEvent(this.code);

  final int code;
}
