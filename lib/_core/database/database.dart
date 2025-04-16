import 'dart:io';

import 'package:delivery_boy/_core/types.dart';

abstract class Database {
  login(QMap formData, String? divideId);
  deliveryManReg(QMap formData, String? divideId);
  logOut(String? divideId);

  verifyPhone(QMap formData);
  verifyCode(QMap formData);
  resetPassword(QMap formData);
  updatePassword(QMap formData);
  getConfig();

  //! withdrew
  fetchWithdrawMethods();
  fetchHomeData();
  fetchWithdrawList({String? search, String? date});
  requestWithdraw({required String methodId, required String amount});
  storeWithdraw({required String id, required QMap formData});

  //! ticket
  fetchTicketList(String? url, String? search);
  createTicket(QMap formData);
  ticketMessage(String id);
  ticketClose(String id);
  ticketMessageReply({
    required String ticketNumber,
    required String message,
    required List<File> files,
  });
  ticketDownloadFile({
    required String id,
    required String massageId,
    required String ticketNo,
  });

  assignOrder({
    required String id,
    required String deliverymanID,
    required QMap formData,
  });

  requestOrder({
    required String status,
    required String id,
    required String note,
  });

  handleOrder({
    required String status,
    required String id,
    required QMap formData,
  });

  //! profile
  updateProfile(QMap formData);
  updateReferralCode(String code);
  getReferralLog();
  getDeliveryman();
  redeemPoint();
  getRewordLog({String? search, String? date});
  getAssignLog();
  getRequestOrder({String? search, String? date});

  //! chat
  fetchChatList();
  fetchDeliveryManChatList();
  fetchDeliveryManMessage(String id);
  fetchChatMessage(String id);
  sendDeliveryManMessage(QMap formData);
  sendChatMessage(QMap formData);
  deleteConversation(String id);
  activeStatus(String status);
  pushNotificationStatus(String status);
  //! Analytics
  fetchAnalytics();
  //! order
  fetchOrderList();
  fetchOrder(String id);

  //! transactions
  fetchTransactions(String search, String date);
  earningLogs();

  //! notification
  updateFCMToken(String token);
  storeNotification(QMap payload);
  notificationCount();
  markNotificationAsRead(int id);
  getNotificationsList();
  deleteMessage(int id);
  clearAllNotifications();
}
