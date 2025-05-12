export 'package:go_router/go_router.dart';

// extension type RPath(String path) {
//   void push(
//     BuildContext context, {
//     Map<String, String> pathParameters = const <String, String>{},
//     Map<String, dynamic> queryParameters = const <String, dynamic>{},
//     Object? extra,
//   }) {
//     final name = path.split('/').last;
//     final route = context.namedLocation(
//       name,
//       pathParameters: pathParameters,
//       queryParameters: queryParameters,
//     );
//     context.pushNamed(route, extra: extra);
//   }
// }

class RoutePaths {
  const RoutePaths._();

  static const navRoutes = [
    home,
    analytics,
    chat,
    report,
    profile,
  ];

  static const String splash = '/splash';
  static const String onBoarding = '/on-boarding';
  static const String maintenance = '/maintenance';
  static const String invalidPurchase = '/invalid-purchase';
  static const String moduleInactive = '/module-inactive';
  static String error(String? err) => '/splash?error=$err';

  static const String verifyKyc = '/kyc-verify';
  static const String kycLog = '$verifyKyc/kyc_log';
  static const String kycLogs = '$verifyKyc/kyc_logs';

  //! auth

  static const String login = '/auth/login';
  static const String signUp = '$login/sign-up';
  static const String verifyPhone = '$login/verify-phone';
  static const String verifyOtp = '$login/verify-otp';
  static const String resetPassword = '$login/reset-password';
  static const String orders = '/orders';
  static String orderDetails(String id) => '$orders/o/$id';
  static String acceptOrder(String id) => '$orders/accept-order/$id';
  static String assignOrder(String id) => '$orders/assign-order/$id';
  static const String requestOrders = '/request-orders';

  //! Home
  static const String home = '/home';

  // static const String orderNew = '$home/order-new';
  // static const String orderDetailsNew = '$orderNew/order-details-new';

  static const String deliverySuccess = '/delivery-success';
  static const String returnSuccess = '/return-success';

  static const String notification = '$home/notification';
  //!analytics
  static const String analytics = '/analytics';

  //! chat
  static const String chat = '/chat';
  static String chatDetails(String id) => '$chat/chat-details/$id';
  static String deliverymanChatDetails(String id) => '$chat/details/$id';

//! all Transaction
  static const String report = '/all-transactions';
  //! profile
  static const String profile = '/profile';
  static const String assignByMe = '/assign-by-me';
  static String pageDetails(String id) => '$profile/page/$id';
  static const String redeemPoints = '$profile/redeem-points';
  static const String support = '$profile/support';
  static const String aboutUs = '$profile/about-us';
  static const String adminTickets = '/support-tickets';
  static const String createTicket = '$adminTickets/create-ticket';
  static String adminTicket(String id) => '$adminTickets/t/$id';

  static const String myProfile = '$profile/my-profile';
  static const String myReview = '$profile/my-review';
  static const String settings = '$profile/settings';
  static const String currency = '$profile/currency';
  static const String language = '$profile/language';
  static const String passwordChange = '$profile/password-change';
  static const String statements = '$profile/statement';
  static String statementDetails(String id) => '$statements/s/$id';
  static const String myWallet = '$profile/my-wallet';
  static const String withdraw = '$myWallet/withdraw';
  static const String withdrawSuccess = '$withdraw/withdraw-success';
  static const String bankTransfer = '$withdraw/bank-transfer';
  static const String addMethod = '$withdraw/edit-method';
  static const String otherPayment = '$withdraw/other-payment';

  static const String sendWithdraw = '$myWallet/send-withdraw';
  static const String referral = '/referral';
  static const String referralList = '$referral/list';
}
