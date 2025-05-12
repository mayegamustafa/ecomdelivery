import 'package:delivery_boy/main.export.dart';

class EarningRepo extends Repo {
  FutureResponse<PagedItem<EarningData>> earningLogs() async {
    final data = await rdb.earningLogs();
    return data;
  }

  FutureResponse<PagedItem<EarningData>> fromUrl(String url) async {
    final data = await rdb.pagedItemFromUrl(
      url,
      'earning_logs',
      (map) => EarningData.fromMap(map),
    );
    return data;
  }
}
