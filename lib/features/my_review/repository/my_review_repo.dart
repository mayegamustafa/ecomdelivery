import 'package:delivery_boy/main.export.dart';

class ReviewRepo extends Repo {
  FutureResponse<PagedItem<DeliveryManReview>> getFromUrl(String url) async {
    final data = await rdb.fromUrl(
      url,
      'delivery_man',
      (map) => PagedItem.fromMap(
        map['reviews'],
        (x) => DeliveryManReview.fromMap(x),
      ),
    );
    return data;
  }
}
