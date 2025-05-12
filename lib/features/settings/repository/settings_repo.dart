import 'package:delivery_boy/main.export.dart';

class SettingsRepo extends Repo {
  FutureResponse<AppSettings> getApiSettings() async {
    final data = await rdb.getConfig();
    return data;
  }

  AppSettings? getAppSettingsSync() {
    return ldb.getConfig();
  }

  Future<AppSettings> saveSettings(AppSettings settings) async {
    final data = ldb.setConfig(settings);
    return data;
  }
}
