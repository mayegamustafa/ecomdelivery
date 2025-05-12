import 'package:delivery_boy/main.export.dart';

class ProfileRepo extends Repo {
  FutureResponse<String> updateProfile(QMap formData) async {
    final data = await rdb.updateProfile(formData);
    return data;
  }

  FutureResponse<String> activeStatus(String status) async {
    final data = await rdb.activeStatus(status);
    return data;
  }

  FutureResponse<String> pushNotificationStatus(String status) async {
    final data = await rdb.pushNotificationStatus(status);
    return data;
  }
}
