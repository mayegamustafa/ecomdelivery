class Endpoints {
  Endpoints._();

  static String? testURL;

  // base url

  static const String baseUrl =
      "https://totalhealthherbalist.com/api/delivery_man";

  static String api = '${testURL ?? baseUrl}/v1/api';

  static const Duration connectionTimeout = Duration(milliseconds: 25000);
  static const Duration receiveTimeout = Duration(milliseconds: 25000);

  static const String login = '/login';
  static const String logOut = '/logout';

  static const String verifyPhone = '/verify/phone';
  static const String verifyCode = '/verify/otp/code';
  static const String resetPass = '/password/reset';

  static String ticketList([String s = '']) => '/ticket/list?search=$s';
  static String ticketMessage(String id) => '/ticket/$id/messages';
  static String ticketClose(String id) => '/ticket/$id/close';
  static const String ticketFileUrl = '/ticket/file/download';
  static const String ticketStore = '/ticket/store';
  static const String ticketReply = '/ticket/reply';

  static const String chatList = '/customer/chat/list';
  static const String getAnalytics = '/get/analytics';
  static const String deliverymanChatList = '/deliveryman/chat/list';
  static String chatMessage(String id) => '/customer/chat/messages/$id';
  static String deliverymanMessage(String id) =>
      '/deliveryman/chat/messages/$id';
  static const String chatSendMessage = '/customer/chat/send/message';
  static const String deliveryManSendMessage = '/deliveryman/chat/send/message';
  static String chatDelete(String id) =>
      '/customer/chat/delete/conversation/$id';

  static const String config = '/config';

  static const String earnings = '/earnings';

  static const String withdrawMethods = '/withdraw/methods';
  static const String withdrawList = '/withdraw/list';
  static const String requestWithdraw = '/withdraw/request';
  static const String storeWithdraw = '/withdraw/store';
  static const String passwordUpdate = '/password/update';
  static const String assignOrder = '/assign/order';
  static const String requestOrder = '/order/request/handle';
  static const String handleOrder = '/order/handle';

  static const String homeData = '/home';
  static const String updateFCM = '/update/fcm-token';

  static const String profileUpdate = '/profile/update';
  static const String activeStatus = '/update/active-status';
  static const String notificationStatus = '/update/push-notification-stauts';
  static const String register = '/register';
  static const String getDeliverymen = '/get/deliverymen';
  static const String referralUpdate = '/referral-code/update';
  static const String referralLog = '/get/referral/log';

  static const String rewardLog = '/reward/point';
  static const String requestedOrder = '/requested/order';
  static const String redeemPoint = '/redeem/point';

  static String assignLog(
          {String search = '', String date = '', String type = ''}) =>
      '/get/assigned/orders?order_number=$search&date=$date&type=$type';
  static const String kycApplication = '/kyc/applications';
  static const String kycLog = '/kyc/log';

  static String orders({
    String status = '',
    String search = '',
    String date = '',
  }) =>
      '/orders?status=$status&search=$search&date=$date';
  static String orderDetails(String id) => '/order/details/$id';

  static String transactions(String search, String date) =>
      '/transactions?search=$search&date=$date';
}
