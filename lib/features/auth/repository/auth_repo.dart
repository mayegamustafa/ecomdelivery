import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthRepo extends Repo {
  FutureResponse<String> registration(QMap formData) async {
    final deviceId = await getUniqueDeviceId();
    final data = await rdb.deliveryManReg(formData, deviceId);
    return data;
  }

  FutureResponse<String> login(QMap formData) async {
    final deviceId = await getUniqueDeviceId();
    final data = await rdb.login(formData, deviceId);
    return data;
  }

  FutureResponse<String> logOut() async {
    final deviceId = await getUniqueDeviceId();

    final data = await rdb.logOut(deviceId);
    await deleteToken();
    return data;
  }

  FutureResponse<String> updatePassword(QMap formData) async {
    final data = await rdb.updatePassword(formData);
    return data;
  }

  FutureResponse<String> verifyPhone(QMap formData) async {
    final data = await rdb.verifyPhone(formData);
    return data;
  }

  FutureResponse<String> verifyOTP(QMap formData) async {
    final data = await rdb.verifyCode(formData);
    return data;
  }

  FutureResponse<String> resetPassword(QMap formData) async {
    final data = await rdb.resetPassword(formData);
    return data;
  }

  String? getToken() {
    final token = ldb.getToken();
    Logger('$token', 'Got TOKEN');
    return token;
  }

  Future<bool> saveToken(String token) async {
    final data = await ldb.setToken(token);
    Logger('[$data] : $token', 'Saved TOKEN');
    return data;
  }

  Future<bool> deleteToken() async {
    final data = await ldb.setToken(null);
    Logger('$data', 'TOKEN DELETED');
    return data;
  }

  Future<String?> getUniqueDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}';
    }
    if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return '${androidDeviceInfo.model}:${androidDeviceInfo.id}';
    }

    return null;
  }
}
