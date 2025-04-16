import 'package:delivery_boy/main.export.dart';

class HomeModel {
  const HomeModel({
    required this.deliveryMan,
    required this.latestOrders,
    required this.overview,
    required this.reviews,
    required this.requestedOrders,
  });

  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      deliveryMan: DeliveryMan.fromMap(map['delivery_man']),
      latestOrders: List<ProductOrder>.from(
        map['latest_orders']?['data']?.map((x) => ProductOrder.fromMap(x)) ??
            [],
      ),
      overview: MainOverview.fromMap(map['overview']),
      reviews: PagedItem<ReviewData>.fromMap(
        map['delivery_man']['reviews'],
        (map) => ReviewData.fromMap(map),
      ),
      requestedOrders: List<ProductOrder>.from(
        map['requested_orders']?['data']?.map((x) => ProductOrder.fromMap(x)) ??
            [],
      ),
    );
  }

  final DeliveryMan deliveryMan;
  final List<ProductOrder> latestOrders;
  final PagedItem<ReviewData> reviews;
  final List<ProductOrder> requestedOrders;
  final MainOverview overview;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'delivery_man': {
        ...deliveryMan.toMap(),
        'reviews': reviews.toMap((x) => x.toMap()),
      }
    });

    result.addAll({
      'delivered_orders': {'data': latestOrders.map((x) => x.toMap()).toList()}
    });

    result.addAll({'overview': overview.toMap()});
    result.addAll({
      'requested_orders': {
        'data': requestedOrders.map((x) => x.toMap()).toList()
      }
    });

    return result;
  }
}
