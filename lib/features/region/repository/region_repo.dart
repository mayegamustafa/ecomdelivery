import 'package:delivery_boy/main.export.dart';
import 'package:dio/dio.dart';

class RegionRepo extends Repo {
  Future<void> setLanguage(String langCode) async {
    await ldb.setLanguage(langCode);
  }

  Future<void> setCurrency(Currency currency) async {
    await ldb.setCurrency(currency);
  }

  Future<void> setBaseCurrency(Currency currency) async {
    await ldb.setBaseCurrency(currency);
  }

  Future<void> set({
    Currency? currency,
    Currency? baseCurrency,
    String? langCode,
  }) async {
    await Future.wait([
      if (currency != null) ldb.setCurrency(currency),
      if (langCode != null) ldb.setLanguage(langCode),
      if (baseCurrency != null) ldb.setBaseCurrency(baseCurrency),
    ]);
  }

  Future<void> setFromResponse(Response response) async {
    final data = response.data;

    if (data
        case {
          'locale': String? l,
          'currency': QMap? c,
          'default_currency': QMap? b,
        }) {
      await set(
        langCode: l,
        currency: c == null ? null : Currency.fromMap(c),
        baseCurrency: b == null ? null : Currency.fromMap(b),
      );
    }
  }

  Currency? getCurrency() {
    final currency = ldb.getCurrency();
    return currency;
  }

  Currency? getBaseCurrency() {
    final currency = ldb.getBaseCurrency();
    return currency;
  }

  String? getLanguage() {
    final langCode = ldb.getLanguage();
    return langCode;
  }

  Region getRegion() {
    return Region.def.copyWith(
      langCode: ldb.getLanguage(),
      currency: ldb.getCurrency(),
      baseCurrency: ldb.getBaseCurrency(),
    );
  }
}
