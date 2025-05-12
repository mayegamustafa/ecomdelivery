import 'package:delivery_boy/features/notification/repository/notification_repo.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_ctrl.g.dart';

@Riverpod(keepAlive: true)
class NotificationCtrl extends _$NotificationCtrl {
  final _repo = locate<NotificationRepo>();
  @override
  List<FCMPayload> build() {
    return _repo.getNotifications();
  }

  void reload() async {
    await _repo.reload();
    ref.invalidateSelf();
  }

  Future<void> deleteMessage(FCMPayload msg) async {
    await _repo.deleteMessage(msg.id);
    ref.invalidateSelf();
  }

  Future<void> clearNotifications() async {
    await _repo.clearNotifications();
    ref.invalidateSelf();
  }

  Future<void> storeNotification(RemoteMessage msg) async {
    final payload = FCMPayload.fromRM(msg);
    await _repo.storeNotification(payload);
    ref.invalidateSelf();
  }
}
