import 'dart:convert';
import 'dart:io';

import 'package:delivery_boy/main.export.dart';

class LocalDB extends LocalStorageBase implements Database {
  //! Notification
  @override
  Future<bool> clearAllNotifications() async {
    return delete(DBKeys.notification);
  }

  @override
  Future<bool> deleteMessage(int id) async {
    final it = getNotificationsList();
    if (it.isEmpty) return false;

    final list = <FCMPayload>[];

    for (var message in it) {
      if (message.id != id) list.add(message);
    }

    return save(
      DBKeys.notification,
      list.map((e) => jsonEncode(e.toMap())).toList(),
    );
  }

  @override
  List<FCMPayload> getNotificationsList() {
    final data = getStringList(DBKeys.notification);

    if (data == null) return [];

    return List<FCMPayload>.from(
      data.map(
        (e) => FCMPayload.fromMap(jsonDecode(e)),
      ),
    );
  }

  @override
  markNotificationAsRead(int id) => throw UnimplementedError();

  @override
  notificationCount() => throw UnimplementedError();

  @override
  Future<bool> storeNotification(QMap payload) {
    final data = jsonEncode(payload);
    return appendToList(DBKeys.notification, data, limit: 500);
  }

  //! FCM
  Future<bool> saveFCM(String fcm) async {
    return await save(PrefKeys.fcmToken, fcm);
  }

  String? getFcm() => getString(PrefKeys.fcmToken);

  //! Onboard
  Future<bool> disableOnboard() async {
    return await save(PrefKeys.isFirst, false);
  }

  bool showOnboard() => getBool(PrefKeys.isFirst) ?? true;

  //! Token
  Future<bool> setToken(String? token) async {
    if (token == null) return delete(PrefKeys.accessToken);
    return await save(PrefKeys.accessToken, token);
  }

  String? getToken() => getString(PrefKeys.accessToken);

  //! Theme
  Future<bool> setTheme(bool? themeMode) async {
    if (themeMode == null) return delete(PrefKeys.isLight);
    return await save(PrefKeys.isLight, themeMode);
  }

  bool? getTheme() => getBool(PrefKeys.isLight);

  //! Language
  Future<bool> setLanguage(String? langCode) async {
    if (langCode == null) return delete(PrefKeys.language);
    return await save(PrefKeys.language, langCode);
  }

  String? getLanguage() => getString(PrefKeys.language);

  //! Currency
  Future<bool> setCurrency(Currency? currency) async {
    if (currency == null) return delete(PrefKeys.currency);
    return await save(PrefKeys.currency, currency.toMap());
  }

  Currency? getCurrency() {
    var map = getMap(PrefKeys.currency);
    if (map == null) return null;
    return Currency.fromMap(map);
  }

  //! Currency
  Future<bool> setBaseCurrency(Currency? currency) async {
    if (currency == null) return delete(PrefKeys.baseCurrency);
    return await save(PrefKeys.baseCurrency, currency.toMap());
  }

  Currency? getBaseCurrency() {
    var map = getMap(PrefKeys.baseCurrency);
    if (map == null) return null;
    return Currency.fromMap(map);
  }

  //! Config

  @override
  AppSettings? getConfig([AppSettings? settings]) {
    const key = DBKeys.config;

    final config = getMap(key);

    if (config == null) return null;

    return AppSettings.fromMap(config);
  }

  Future<AppSettings> setConfig(AppSettings settings) async {
    const key = DBKeys.config;
    await save(key, settings.toMap());
    return settings;
  }

  //! home

  @override
  HomeModel? fetchHomeData() {
    const key = DBKeys.home;
    final config = getMap(key);
    if (config == null) return null;
    return HomeModel.fromMap(config);
  }

  Future<HomeModel> setHomeData(HomeModel home) async {
    const key = DBKeys.home;
    await save(key, home.toMap());
    return home;
  }

  @override
  logOut(String? divideId) async {}

  @override
  login(QMap formData, String? divideId) async {}

  @override
  resetPassword(QMap formData) {
    throw UnimplementedError();
  }

  @override
  verifyCode(QMap formData) {
    throw UnimplementedError();
  }

  @override
  verifyPhone(QMap formData) {
    throw UnimplementedError();
  }

  @override
  createTicket(id) {
    throw UnimplementedError();
  }

  @override
  fetchTicketList(String? url, String? search) {
    throw UnimplementedError();
  }

  @override
  ticketDownloadFile({
    required String id,
    required String massageId,
    required String ticketNo,
  }) {
    throw UnimplementedError();
  }

  @override
  ticketMessage(String id) {
    throw UnimplementedError();
  }

  @override
  ticketClose(String id) {
    throw UnimplementedError();
  }

  @override
  ticketMessageReply({
    required String message,
    required String ticketNumber,
    required List<File> files,
  }) {
    throw UnimplementedError();
  }

  @override
  fetchWithdrawList({String? search, String? date}) {
    throw UnimplementedError();
  }

  @override
  fetchWithdrawMethods() {
    throw UnimplementedError();
  }

  @override
  requestWithdraw({required String methodId, required String amount}) {
    throw UnimplementedError();
  }

  @override
  storeWithdraw({required String id, required QMap formData}) {
    throw UnimplementedError();
  }

  @override
  updatePassword(QMap formData) {
    throw UnimplementedError();
  }

  @override
  updateProfile(QMap formData) {
    throw UnimplementedError();
  }

  @override
  deleteConversation(String id) {
    throw UnimplementedError();
  }

  @override
  fetchChatList() {
    throw UnimplementedError();
  }

  @override
  fetchChatMessage(String id) {
    throw UnimplementedError();
  }

  @override
  sendChatMessage(QMap formData) {
    throw UnimplementedError();
  }

  @override
  fetchOrder(String id) {
    throw UnimplementedError();
  }

  @override
  fetchOrderList() {
    throw UnimplementedError();
  }

  @override
  fetchTransactions(String search, String date) {
    throw UnimplementedError();
  }

  @override
  earningLogs() {
    throw UnimplementedError();
  }

  @override
  updateFCMToken(String token) {
    throw UnimplementedError();
  }

  @override
  activeStatus(String status) {
    throw UnimplementedError();
  }

  @override
  pushNotificationStatus(String status) {
    throw UnimplementedError();
  }

  @override
  deliveryManReg(QMap formData, String? divideId) {
    throw UnimplementedError();
  }

  @override
  fetchDeliveryManChatList() {
    throw UnimplementedError();
  }

  @override
  fetchDeliveryManMessage(String id) {
    throw UnimplementedError();
  }

  @override
  sendDeliveryManMessage(QMap formData) {
    throw UnimplementedError();
  }

  @override
  fetchAnalytics() {
    throw UnimplementedError();
  }

  @override
  requestOrder({
    required String status,
    required String id,
    required String note,
  }) {
    throw UnimplementedError();
  }

  @override
  assignOrder({
    required String id,
    required String deliverymanID,
    required QMap formData,
  }) {
    throw UnimplementedError();
  }

  @override
  handleOrder({
    required String status,
    required String id,
    required QMap formData,
  }) {
    throw UnimplementedError();
  }

  @override
  getDeliveryman() {
    throw UnimplementedError();
  }

  @override
  updateReferralCode(String code) {
    throw UnimplementedError();
  }

  @override
  getReferralLog() {
    throw UnimplementedError();
  }

  @override
  getRequestOrder({String? search, String? date}) {
    throw UnimplementedError();
  }

  @override
  getRewordLog({String? search, String? date}) {
    throw UnimplementedError();
  }

  @override
  getAssignLog() {
    throw UnimplementedError();
  }

  @override
  redeemPoint() {
    throw UnimplementedError();
  }
}
