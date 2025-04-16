import 'package:delivery_boy/main.export.dart';

class NotificationRepo extends Repo {
  Future<bool> storeNotification(FCMPayload payload) async {
    return ldb.storeNotification(payload.toMap());
  }

  List<FCMPayload> getNotifications() {
    return ldb.getNotificationsList();
  }

  Future<bool> deleteMessage(int id) async {
    return ldb.deleteMessage(id);
  }

  Future<bool> clearNotifications() async {
    return ldb.clearAllNotifications();
  }

  Future<void> reload() async {
    return ldb.reload();
  }
}
