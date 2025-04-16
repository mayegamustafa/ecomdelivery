import 'dart:async';

import 'package:delivery_boy/features/auth/controller/auth_ctrl.dart';
import 'package:delivery_boy/features/auth/view/chanage_password.dart';
import 'package:delivery_boy/features/auth/view/reset_password_view.dart';
import 'package:delivery_boy/features/auth/view/sign_up.dart';
import 'package:delivery_boy/features/auth/view/verify_otp_view.dart';
import 'package:delivery_boy/features/auth/view/verify_phone_view.dart';
import 'package:delivery_boy/features/home/view/home_init_page.dart';
import 'package:delivery_boy/features/kyc/view/kyc_logs_view.dart';
import 'package:delivery_boy/features/kyc/view/kyc_view.dart';
import 'package:delivery_boy/features/kyc/view/verify_kyc_view.dart';
import 'package:delivery_boy/features/my_review/view/my_review.dart';
import 'package:delivery_boy/features/notification/view/notification_view.dart';
import 'package:delivery_boy/features/on_board/controller/onboard_ctrl.dart';
import 'package:delivery_boy/features/orders/view/local/delivery_success.dart';
import 'package:delivery_boy/features/orders/view/local/return_success.dart';
import 'package:delivery_boy/features/orders/view/order_list_view.dart';
import 'package:delivery_boy/features/profile/view/my_profile_view.dart';
import 'package:delivery_boy/features/region/view/currency_view.dart';
import 'package:delivery_boy/features/region/view/language_view.dart';
import 'package:delivery_boy/features/settings/view/settings_view.dart';
import 'package:delivery_boy/features/statement/view/statement_view.dart';
import 'package:delivery_boy/features/support_ticket/view/create_ticket.dart';
import 'package:delivery_boy/features/support_ticket/view/ticket_chat_view.dart';
import 'package:delivery_boy/features/support_ticket/view/ticket_list.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/navigation/navigation_root.dart';
import 'package:delivery_boy/routes/pages/module_inactive.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

import '../features/about/view/about_view.dart';
import '../features/analytics/view/analytics_view.dart';
import '../features/auth/view/login_view.dart';
import '../features/chat/view/chats_tab_view.dart';
import '../features/chat/view/customer/customer_chat_details.dart';
import '../features/chat/view/delivery/deliveryman_chat_details.dart';
import '../features/home/view/home_view.dart';
import '../features/home/view/request_order.dart';
import '../features/on_board/view/on_board.dart';
import '../features/orders/view/accept_order_view.dart';
import '../features/orders/view/assign_order_view.dart';
import '../features/orders/view/local/assign_order_log.dart';
import '../features/orders/view/order_details.dart';
import '../features/profile/view/local/pages_details.dart';
import '../features/profile/view/profile_view.dart';
import '../features/redeem_points/view/redeem_points_view.dart';
import '../features/referral/view/referral_list.dart';
import '../features/referral/view/referral_view.dart';
import '../features/support/view/support_view.dart';
import '../features/wallet/view/report.dart';
import '../features/wallet/view/wallet_view.dart';
import '../features/withdraw/view/add_method.dart';
import '../features/withdraw/view/bank_transfer.dart';
import '../features/withdraw/view/other_payment.dart';
import '../features/withdraw/view/withdraw_succes.dart';
import '../features/withdraw/view/withdraw_view.dart';
import 'pages/invalid_purchase.dart';
import 'pages/maintenance.dart';

typedef RouteRedirect = FutureOr<String?> Function(BuildContext, GoRouterState);

final routerProvider =
    AutoDisposeNotifierProvider<AppRouter, GoRouter>(AppRouter.new);

class AppRouter extends AutoDisposeNotifier<GoRouter> {
  final _rootNavigator = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _shellNavigator = GlobalKey<NavigatorState>(debugLabel: 'shell');

  @override
  GoRouter build() {
    Get._key = _rootNavigator;
    Toaster.navigator = _rootNavigator;
    final isLoggedIn = ref.watch(authCtrlProvider);
    final showOnboard = ref.watch(onBoardCtrlProvider);
    final serverStatus = ref.watch(serverStatusProvider);

    FutureOr<String?> redirectLogic(ctx, state) async {
      final current = state.uri.toString();
      final query = state.uri.queryParameters;
      HomeInitPage.route = current;
      Logger.route(current);

      if (showOnboard) return RoutePaths.onBoarding;

      if (current.contains(RoutePaths.login)) return null;

      if (!isLoggedIn) {
        Logger.route('Redirecting to login');
        return Uri(path: RoutePaths.login, queryParameters: query).toString();
      }

      final statusResult = serverStatus.paths;
      if (statusResult != null) {
        return statusResult;
      }

      return null;
    }

    return _appRouter(redirectLogic);
  }

  GoRouter _appRouter(RouteRedirect? redirect) {
    return GoRouter(
      // debugLogDiagnostics: true,
      navigatorKey: _rootNavigator,
      redirect: redirect,
      initialLocation: RoutePaths.home,
      errorPageBuilder: (context, state) =>
          MaterialPage(child: PageNotFound(state.uri.toString())),
      routes: _routes,
      observers: [
        RouteOBS(),
      ],
    );
  }

  // The app router list
  List<RouteBase> get _routes => [
        AppRoute(RoutePaths.splash, (_) => const SplashPage()),
        AppRoute(RoutePaths.onBoarding, (_) => const OnboardingView()),
        AppRoute(RoutePaths.login, (_) => const LoginView()),
        AppRoute(RoutePaths.signUp, (_) => const SignUpView()),
        AppRoute(RoutePaths.verifyPhone, (_) => const VerifyPhoneView()),
        AppRoute(RoutePaths.verifyOtp, (_) => const VerifyOtpView()),
        AppRoute(RoutePaths.resetPassword, (_) => const ResetPasswordView()),
        AppRoute(RoutePaths.maintenance, (_) => const MaintenancePage()),
        AppRoute(
            RoutePaths.invalidPurchase, (_) => const InvalidPurchasePage()),
        AppRoute(RoutePaths.moduleInactive, (_) => const ModuleInactive()),
        AppRoute(RoutePaths.verifyKyc, (_) => const VerifyKYCView()),
        AppRoute(
          RoutePaths.kycLog,
          (s) => switch (s.extra) {
            KYCLog log => KYCView(log),
            _ => const ErrorView('Invalid KYC Log', null),
          },
        ),
        AppRoute(RoutePaths.kycLogs, (_) => const KYCLogsView()),
        ShellRoute(
          navigatorKey: _shellNavigator,
          builder: (_, __, child) => NavigationRoot(child),
          routes: [
            AppRoute(RoutePaths.home, (_) => const HomeView()),
            AppRoute(RoutePaths.analytics, (_) => const AnalyticsView()),
            AppRoute(RoutePaths.chat, (_) => const ChatsTabView()),
            AppRoute(
              RoutePaths.report,
              (_) => const ReportView(),
            ),
            AppRoute(RoutePaths.profile, (_) => const ProfileView()),
          ],
        ),
        //! Home
        AppRoute(RoutePaths.notification, (_) => const NotificationView()),

        AppRoute(
          RoutePaths.orderDetails(':id'),
          (s) => OrderDetailsView(s.pathParameters['id']!),
        ),
        AppRoute(
          RoutePaths.acceptOrder(':id'),
          (s) => AcceptOrderView(s.pathParameters['id']!),
        ),
        AppRoute(
          RoutePaths.assignOrder(':id'),
          (s) => AssignOrderView(s.pathParameters['id']!),
        ),

        AppRoute(
            RoutePaths.deliverySuccess, (_) => const DeliverySuccessView()),
        AppRoute(RoutePaths.returnSuccess, (_) => const ReturnSuccessView()),

        //! Wallet
        // AppRoute(RoutePaths.transactions, (_) => const TransactionView()),

        AppRoute(RoutePaths.withdraw, (_) => const WithdrawView()),
        AppRoute(
            RoutePaths.withdrawSuccess, (_) => const WithdrawSuccessView()),
        AppRoute(RoutePaths.bankTransfer, (_) => const BankTransferView()),
        AppRoute(RoutePaths.addMethod, (_) => const AddMethodView()),
        AppRoute(RoutePaths.otherPayment, (_) => const OtherPaymentView()),

        //! order
        AppRoute(RoutePaths.orders, (_) => const OrderListView()),
        AppRoute(RoutePaths.requestOrders, (_) => const RequestOrderView()),

        //! Chat
        AppRoute(
          RoutePaths.chatDetails(':id'),
          (s) => CustomerChatDetailsView(id: s.pathParameters['id']!),
        ),
        AppRoute(
          RoutePaths.deliverymanChatDetails(':id'),
          (s) => DeliverymanChatDetailsView(id: s.pathParameters['id']!),
        ),
        AppRoute(RoutePaths.adminTickets, (_) => const TicketListView()),
        AppRoute(RoutePaths.createTicket, (_) => const CreateTicketView()),
        AppRoute(
          RoutePaths.adminTicket(':id'),
          (s) => TicketChatView(s.pathParameters['id']!),
        ),

        //! Profile
        AppRoute(RoutePaths.aboutUs, (_) => const AboutUsView()),
        AppRoute(
          RoutePaths.pageDetails(':id'),
          (s) => PagesDetailsView(
            s.pathParameters['id']!,
          ),
        ),
        AppRoute(RoutePaths.myWallet, (_) => const WalletView()),
        AppRoute(RoutePaths.assignByMe, (_) => const AssignOrderLog()),
        AppRoute(RoutePaths.redeemPoints, (_) => const RedeemPointsView()),
        AppRoute(RoutePaths.support, (_) => const SupportView()),
        AppRoute(RoutePaths.myProfile, (_) => const MyProfileView()),
        AppRoute(RoutePaths.passwordChange, (_) => const ChangePassView()),
        AppRoute(RoutePaths.settings, (_) => const SettingView()),
        AppRoute(RoutePaths.currency, (_) => const CurrencyView()),
        AppRoute(RoutePaths.language, (_) => const LanguageView()),
        AppRoute(RoutePaths.myReview, (_) => const MyReviewView()),
        AppRoute(RoutePaths.statements, (_) => const StatementView()),
        AppRoute(RoutePaths.referral, (_) => const ReferralView()),
        AppRoute(RoutePaths.referralList, (_) => const ReferralListView()),

        AppRoute(
          RoutePaths.statementDetails(':id'),
          onPop: () => HomeInitPage.route = '',
          (s) => OrderDetailsView(s.pathParameters['id']!),
        ),
      ];
}

class Get {
  const Get._();
  static GlobalKey<NavigatorState>? _key;
  static BuildContext? get context => _key?.currentContext;
}

class RouteOBS extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    Logger.route('popped : ${route.settings.name} ', 'didPop');
    HomeInitPage.route = '';
  }
}
