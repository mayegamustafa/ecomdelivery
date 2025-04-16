import 'package:delivery_boy/main.export.dart';

class AnalyticsRepo extends Repo {
  FutureResponse<AnalyticsModel> fetchAnalytics() async {
    final data = await rdb.fetchAnalytics();
    return data;
  }
}
