import 'package:delivery_boy/main.export.dart';

class RedeemPointsRepo extends Repo {
  FutureResponse<PagedItem<RewardLogs>> getRewordLog([
    String search = '',
    String date = '',
  ]) async {
    final data = await rdb.getRewordLog(search: search, date: date);
    return data;
  }

  FutureResponse<String> redeemPoint() async {
    final data = await rdb.redeemPoint();
    return data;
  }

  FutureResponse<PagedItem<RewardLogs>> getFromUrl(String url) async {
    final data =
        await rdb.pagedItemFromUrl(url, 'reward_logs', RewardLogs.fromMap);
    return data;
  }
}
