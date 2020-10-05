import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static var _t = Translations("en_us") +
      {
        "en_us": "years old",
        "fr_be": "ans",
      } +
      {
        "en_us": "Motivation",
        "fr_be": "Motivation",
      };

  String get i18n => localize(this, _t);
}
