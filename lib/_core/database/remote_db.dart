import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';

import '../../models/home/assigned_order.dart';

class RemoteDB extends Database with ApiHandler {
  final _dio = locate<DioClient>();

  FutureResponse<PagedItem<T>> pagedItemFromUrl<T>(
    String url,
    String key,
    T Function(QMap map) mapper,
  ) async {
    final data = await apiCallHandler(
      call: () => _dio.get(url),
      mapper: (map) => PagedItem<T>.fromMap(map[key], mapper),
    );

    return data;
  }

  FutureResponse<T> fromUrl<T>(
    String url,
    String key,
    T Function(QMap map) mapper,
  ) async {
    final data = await apiCallHandler(
      call: () => _dio.get(url),
      mapper: (map) => mapper(map[key]),
    );

    return data;
  }

  ///! auth

  @override
  FutureResponse<String> logOut(String? divideId) async {
    final op = Options(headers: {'device_id': divideId});
    final res = await apiCallHandler(
      call: () => _dio.get(Endpoints.logOut, options: op),
      mapper: (map) => map['message'].toString(),
    );
    return res;
  }

  @override
  FutureResponse<String> login(QMap formData, String? divideId) async {
    final op = Options(headers: {'device_id': divideId});

    final res = await apiCallHandler(
      call: () => _dio.post(Endpoints.login, data: formData, options: op),
      mapper: (map) => map['access_token'].toString(),
    );
    return res;
  }

  ///! reset password

  @override
  FutureResponse<String> resetPassword(QMap formData) async {
    final res = await apiCallHandler(
      call: () => _dio.post(Endpoints.resetPass, data: formData),
      mapper: (map) => map['message'].toString(),
    );
    return res;
  }

  @override
  FutureResponse<String> verifyCode(QMap formData) async {
    final res = await apiCallHandler(
      call: () => _dio.post(Endpoints.verifyCode, data: formData),
      mapper: (map) => map['message'].toString(),
    );
    return res;
  }

  @override
  FutureResponse<String> verifyPhone(QMap formData) async {
    final res = await apiCallHandler(
      call: () => _dio.post(Endpoints.verifyPhone, data: formData),
      mapper: (map) => map['message'].toString(),
    );
    return res;
  }

  ///! Password Update

  @override
  FutureReport<BaseResponse<String>> updatePassword(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.passwordUpdate, data: formData),
      mapper: (map) => (map['message'] as String?) ?? 'Password Updated',
    );

    return data;
  }

  ///! ticket

  @override
  FutureResponse<TicketData> createTicket(QMap formData) async {
    final res = await apiCallHandler(
      call: () => _dio.post(Endpoints.ticketStore, data: formData),
      mapper: (map) => TicketData.fromMap(map),
    );

    return res;
  }

  @override
  FutureResponse<PagedItem<SupportTicket>> fetchTicketList(
    String? url,
    String? search,
  ) async {
    final res = await apiCallHandler(
      call: () => _dio.get(url ?? Endpoints.ticketList(search ?? '')),
      mapper: (map) => PagedItem.fromMap(map['tickets'], SupportTicket.fromMap),
    );
    return res;
  }

  @override
  FutureResponse<String> ticketDownloadFile({
    required String id,
    required String massageId,
    required String ticketNo,
  }) async {
    final body = {
      'id': id,
      'support_message_id': massageId,
      'ticket_number': ticketNo,
    };

    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.ticketFileUrl, data: body),
      mapper: (map) => map['url'] as String,
    );

    return data;
  }

  @override
  FutureResponse<TicketData> ticketMessage(String id) async {
    final res = await apiCallHandler(
      call: () => _dio.get(Endpoints.ticketMessage(id)),
      mapper: TicketData.fromMap,
    );
    return res;
  }

  @override
  FutureResponse<TicketData> ticketMessageReply({
    required String message,
    required String ticketNumber,
    required List<File> files,
  }) async {
    final parts = <MultipartFile>[];
    for (var file in files) {
      parts.add(
        await MultipartFile.fromFile(file.path),
      );
    }
    final body = {
      'ticket_number': ticketNumber,
      'message': message,
      'file': parts,
    };
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.ticketReply, data: body),
      mapper: (map) => TicketData.fromMap(map),
    );

    return data;
  }

  @override
  ticketClose(String id) async {
    final res = await apiCallHandler(
      call: () => _dio.get(Endpoints.ticketClose(id)),
      mapper: (m) => m,
    );
    return res;
  }

  //! config

  @override
  FutureResponse<AppSettings> getConfig() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.config),
      mapper: (map) => AppSettings.fromMap(map),
    );

    return data;
  }

  //! withdrew

  @override
  FutureResponse<PagedItem<WithdrawData>> fetchWithdrawList({
    String? search,
    String? date,
  }) async {
    final data = await apiCallHandler(
      call: () => _dio.get(
        '${Endpoints.withdrawList}?search=$search&date=$date',
      ),
      mapper: (map) =>
          PagedItem.fromMap(map['withdraw_list'], WithdrawData.fromMap),
    );

    return data;
  }

  @override
  FutureResponse<List<WithdrawMethod>> fetchWithdrawMethods() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.withdrawMethods),
      mapper: (map) => List<WithdrawMethod>.from(
        map['methods']?['data']?.map((x) => WithdrawMethod.fromMap(x)) ?? [],
      ),
    );

    return data;
  }

  //! Home Data

  @override
  FutureResponse<HomeModel> fetchHomeData() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.homeData),
      mapper: (map) {
        return HomeModel.fromMap(map);
      },
    );

    return data;
  }

  @override
  FutureResponse<({String msg, WithdrawData data})> requestWithdraw({
    required String methodId,
    required String amount,
  }) async {
    final data = await apiCallHandler(
      call: () => _dio.post(
        Endpoints.requestWithdraw,
        data: {'id': methodId, 'amount': amount},
      ),
      mapper: (map) => (
        msg: '${map['message']}',
        data: WithdrawData.fromMap(map['withdraw'])
      ),
    );

    return data;
  }

  @override
  FutureResponse<String> storeWithdraw({
    required String id,
    required QMap formData,
  }) async {
    final body = {'id': id, ...formData};
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.storeWithdraw, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  //! profile

  @override
  FutureResponse<String> updateProfile(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.profileUpdate, data: formData),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> deliveryManReg(QMap formData, String? divideId) async {
    final op = Options(headers: {'device_id': divideId});

    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.register, data: formData, options: op),
      mapper: (map) => map['access_token'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> activeStatus(String status) async {
    final data = await apiCallHandler(
      call: () => _dio.post(
        Endpoints.activeStatus,
        data: {'status': status},
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> pushNotificationStatus(String status) async {
    final data = await apiCallHandler(
      call: () => _dio.post(
        Endpoints.notificationStatus,
        data: {'status': status},
      ),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }
  //! chat

  @override
  FutureResponse<String> deleteConversation(String id) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.chatDelete(id)),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<List<DeliveryMan>> fetchDeliveryManChatList() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.deliverymanChatList),
      mapper: (map) => List<DeliveryMan>.from(map['delivery_men']?['data'].map(
        (x) => DeliveryMan.fromMap(x),
      )),
    );

    return data;
  }

  @override
  FutureResponse<List<CustomerData>> fetchChatList() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.chatList),
      mapper: (map) => List<CustomerData>.from(map['customer']?['data'].map(
        (x) => CustomerData.fromMap(x),
      )),
    );

    return data;
  }

//! analytics
  @override
  FutureResponse<AnalyticsModel> fetchAnalytics() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.getAnalytics),
      mapper: (map) => AnalyticsModel.fromMap(map),
    );

    return data;
  }

  @override
  FutureResponse<DeliveryManChat> fetchDeliveryManMessage(String id) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.deliverymanMessage(id)),
      mapper: (map) => DeliveryManChat.fromMap(map),
    );

    return data;
  }

  @override
  FutureResponse<CustomerChat> fetchChatMessage(String id) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.chatMessage(id)),
      mapper: (map) => CustomerChat.fromMap(map),
    );

    return data;
  }

  @override
  FutureResponse<String> sendDeliveryManMessage(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.deliveryManSendMessage, data: formData),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> sendChatMessage(QMap formData) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.chatSendMessage, data: formData),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  //! order

  @override
  FutureResponse<ProductOrder> fetchOrder(String id) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.orderDetails(id)),
      mapper: (map) => ProductOrder.fromMap(map['orders']),
    );

    return data;
  }

  @override
  FutureResponse<String> requestOrder({
    required String status,
    required String id,
    required String note,
  }) async {
    final body = {
      'order_id': id,
      'status': status,
      'note': note,
    };
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.requestOrder, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> assignOrder({
    required String id,
    required String deliverymanID,
    required QMap formData,
  }) async {
    final body = {
      'order_id': id,
      'delivery_man_id': deliverymanID,
      ...formData
    };
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.assignOrder, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<String> handleOrder({
    required String status,
    required String id,
    required QMap formData,
  }) async {
    final body = {'order_id': id, 'status': status, ...formData};
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.handleOrder, data: body),
      mapper: (map) => map['message'].toString(),
    );

    return data;
  }

  @override
  FutureResponse<PagedItem<ProductOrder>> fetchOrderList({
    String? status,
    String? search,
    String? date,
  }) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.orders(
        status: status ?? '',
        search: search ?? '',
        date: date ?? '',
      )),
      mapper: (x) =>
          PagedItem.fromMap(x['orders'], (m) => ProductOrder.fromMap(m)),
    );

    return data;
  }

  @override
  FutureResponse<PagedItem<TransactionData>> fetchTransactions(
      String search, String date) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.transactions(search, date)),
      mapper: (map) => PagedItem<TransactionData>.fromMap(
        map['transactions'],
        (map) => TransactionData.fromMap(map),
      ),
    );
    return data;
  }

  // ! earnings

  @override
  FutureResponse<PagedItem<EarningData>> earningLogs() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.earnings),
      mapper: (map) =>
          PagedItem.fromMap(map['earning_logs'], (e) => EarningData.fromMap(e)),
    );
    return data;
  }

  //! notification

  @override
  FutureResponse<String> updateFCMToken(String token) async {
    final data = await apiCallHandler(
      call: () => _dio.post(Endpoints.updateFCM, data: {'fcm_token': token}),
      mapper: (map) => '${map['message']}',
    );
    return data;
  }

  @override
  FutureResponse<List<DeliveryMan>> getDeliveryman() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.getDeliverymen),
      mapper: (map) => List<DeliveryMan>.from(
        map['delivery_men']?['data']?.map((x) => DeliveryMan.fromMap(x)) ?? [],
      ),
    );
    return data;
  }

  @override
  FutureResponse<String> updateReferralCode(String code) async {
    final data = await apiCallHandler(
      call: () =>
          _dio.post(Endpoints.referralUpdate, data: {'referral_code': code}),
      mapper: (map) => '${map['message']}',
    );
    return data;
  }

  @override
  FutureResponse<ReferralLog> getReferralLog() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.referralLog),
      mapper: (map) => ReferralLog.fromMap(map),
    );
    return data;
  }

  @override
  FutureResponse<PagedItem<RewardLogs>> getRewordLog({
    String? search,
    String? date,
  }) async {
    final data = await apiCallHandler(
      call: () =>
          _dio.get('${Endpoints.rewardLog}?date=$date&order_number=$search'),
      mapper: (map) => PagedItem.fromMap(
        map['reward_logs'],
        (e) => RewardLogs.fromMap(e),
      ),
    );
    return data;
  }

  @override
  FutureResponse<PagedItem<ProductOrder>> getRequestOrder({
    String? search,
    String? date,
  }) async {
    final data = await apiCallHandler(
      call: () =>
          _dio.get('${Endpoints.requestedOrder}?search=$search&date=$date'),
      mapper: (map) => PagedItem.fromMap(
        map['orders'],
        (e) => ProductOrder.fromMap(e),
      ),
    );
    return data;
  }

  @override
  FutureResponse<PagedItem<AssignedOrder>> getAssignLog({
    String? search,
    String? date,
    String? type,
  }) async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.assignLog(
          search: search ?? '', date: date ?? '', type: type ?? '')),
      mapper: (map) => PagedItem.fromMap(
        map['assigned_orders'],
        (e) => AssignedOrder.fromMap(e),
      ),
    );
    return data;
  }

  @override
  FutureResponse<String> redeemPoint() async {
    final data = await apiCallHandler(
      call: () => _dio.get(Endpoints.redeemPoint),
      mapper: (map) => '${map['message']}',
    );
    return data;
  }

  @override
  clearAllNotifications() => throw UnimplementedError();
  @override
  deleteMessage(int id) => throw UnimplementedError();
  @override
  getNotificationsList() => throw UnimplementedError();
  @override
  markNotificationAsRead(int id) => throw UnimplementedError();
  @override
  notificationCount() => throw UnimplementedError();
  @override
  storeNotification(QMap payload) => throw UnimplementedError();
}
