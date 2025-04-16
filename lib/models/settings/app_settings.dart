import 'package:delivery_boy/main.export.dart';

class AppSettings {
  const AppSettings({
    required this.countries,
    required this.config,
    required this.languages,
    required this.currencies,
    required this.defaultLanguage,
    required this.currency,
    required this.imageFormate,
    required this.faq,
    required this.pages,
    required this.fileFormate,
    required this.kycConfig,
  });

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    final kycConfig = switch (map['kyc_config']) {
      List x when x.every((x) => x is Map) =>
        x.map((x) => KYCConfig.fromMap(x)).toList(),
      _ => <KYCConfig>[],
    };

    return AppSettings(
      countries: Country.fromList(map['countries']),
      config: Config.fromMap(map['config']),
      languages: Language.listFromConfig(map['languages']),
      currencies: Currency.listFromConfig(map['currency']),
      defaultLanguage: Language.fromMap(map['default_language']),
      currency: Currency.fromMap(map['default_currency']),
      imageFormate: List<String>.from(map['image_format']),
      faq: List<Faq>.from(
        map['faqs']?.map((x) => Faq.fromMap(x)).toList(),
      ),
      pages: Pages.fromMap(map['pages']),
      fileFormate: List<String>.from(map['file_format']),
      kycConfig: kycConfig,
    );
  }

  final Config config;
  final List<Country> countries;
  final List<Currency> currencies;
  final Currency currency;
  final List<Language> languages;
  final Language defaultLanguage;
  final List<String> imageFormate;
  final List<String> fileFormate;
  final List<Faq> faq;
  final List<KYCConfig> kycConfig;
  final Pages pages;

  List<String> get allFormate => [...imageFormate, ...fileFormate];

  Map<String, dynamic> toMap() {
    final data = {
      'countries': {'data': countries.map((e) => e.toMap()).toList()},
      'config': config.toMap(),
      'languages': {'data': languages.map((e) => e.toMap()).toList()},
      'currency': {'data': currencies.map((e) => e.toMap()).toList()},
      'default_language': defaultLanguage.toMap(),
      'default_currency': currency.toMap(),
      'image_format': imageFormate,
      'faqs': faq.map((e) => e.toMap()).toList(),
      'pages': pages.toMap(),
      'file_format': fileFormate,
      'kyc_config': kycConfig.map((e) => e.toMap()).toList(),
    };
    return data;
  }
}
