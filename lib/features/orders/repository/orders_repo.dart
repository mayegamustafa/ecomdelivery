import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/models/home/assigned_order.dart';

class OrderRepo extends Repo {
  FutureResponse<PagedItem<ProductOrder>> getOrders({
    String? status,
    String? search,
    String? date,
  }) async {
    final data =
        await rdb.fetchOrderList(status: status, search: search, date: date);
    return data;
  }

  FutureResponse<PagedItem<AssignedOrder>> getAssignLog({
    String? search,
    String? date,
    String? type,
  }) async {
    final data = await rdb.getAssignLog(search: search, date: date, type: type);
    return data;
  }

  FutureResponse<String> requestOrder({
    required String status,
    required String id,
    required String note,
  }) async {
    final data = await rdb.requestOrder(
      status: status,
      id: id,
      note: note,
    );
    return data;
  }

  FutureResponse<String> handleOrder({
    required String status,
    required String id,
    required QMap formData,
  }) async {
    final data = await rdb.handleOrder(
      status: status,
      id: id,
      formData: formData,
    );
    return data;
  }

  FutureResponse<String> assignOrder({
    required String id,
    required String deliverymanID,
    required QMap formData,
  }) async {
    final data = await rdb.assignOrder(
      id: id,
      deliverymanID: deliverymanID,
      formData: formData,
    );
    return data;
  }

  FutureResponse<PagedItem<ProductOrder>> getRequestOrder([
    String search = '',
    String date = '',
  ]) async {
    final data = await rdb.getRequestOrder(search: search, date: date);
    return data;
  }

  FutureResponse<PagedItem<ProductOrder>> fromUrl(String url) async {
    final data = await rdb.pagedItemFromUrl(
        url, 'orders', (map) => ProductOrder.fromMap(map));
    return data;
  }

  FutureResponse<PagedItem<AssignedOrder>> assignUrl(String url) async {
    final data = await rdb.pagedItemFromUrl(
        url, 'assigned_orders', (map) => AssignedOrder.fromMap(map));
    return data;
  }

  FutureResponse<ProductOrder> getOrderDetails(String id) async {
    final data = await rdb.fetchOrder(id);
    return data;
  }

  FutureResponse<List<DeliveryMan>> getDeliveryman() async {
    final data = await rdb.getDeliveryman();
    return data;
  }
}
